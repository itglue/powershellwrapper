<#
    .SYNOPSIS
        Pester tests looking for help comments in all ITGlueAPI module functions

    .DESCRIPTION
        Pester tests looking for help comments in all ITGlueAPI module functions

    .EXAMPLE
        Invoke-Pester -Path .\Tests\HelpComment.Tests.ps1

        Runs a pester test against "HelpComment.Tests.ps1" and outputs simple test results.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\HelpComment.Tests.ps1 -Output Detailed

        Runs a pester test against "HelpComment.Tests.ps1" and outputs detailed test results.

    .NOTES
        Build out more robust, logical, & scalable pester tests.
        Huge thank you to LazyWinAdmin, Vexx32, & JeffBrown for their blog posts!

    .LINK
        https://github.com/itglue/powershellwrapper

    .LINK
        https://vexx32.github.io/2020/07/08/Verify-Module-Help-Pester/
        https://lazywinadmin.com/2016/05/using-pester-to-test-your-comment-based.html
        https://jeffbrown.tech/getting-started-with-pester-testing-in-powershell/

#>

#Requires -Version 5.0
#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }
#Requires -Modules @{ ModuleName='ITGlueAPI'; ModuleVersion='2.1.0' }

$ModuleName = 'ITGlueAPI'

BeforeAll {
    $ModuleName = 'ITGlueAPI'
    Import-Module $ModuleName
}


Describe "Testing [ $ModuleName ] functions for comment based help" -Tags 'Module' {

    #Region Discovery

    # The module will need to be imported during Discovery since we're using it to generate test cases / Context blocks
    Import-Module $ModuleName

    $ShouldProcessParameters = 'WhatIf', 'Confirm'

    # Generate command list for generating Context / TestCases
    $Module = Get-Module $ModuleName
    $CommandList = @(
        $Module.ExportedFunctions.Keys
        $Module.ExportedCmdlets.Keys
    )

    #EndRegion Discovery

    ForEach ($Command in $CommandList) {
        Context "[ $Command ] - Comment Based Help" {

            #Region Discovery

                $Help = @{ Help = Get-Help -Name $Command -Full | Select-Object -Property * }

                $Parameters = Get-Help -Name $Command -Parameter * -ErrorAction Ignore |
                    Where-Object { $_.Name -and $_.Name -notin $ShouldProcessParameters } |
                    ForEach-Object { @{
                                        Name        = $_.name
                                        Description = $_.Description.Text
                                    }
                    }

                $Ast = @{
                    # Ast will be $null if the command is a compiled cmdlet
                    Ast        = (Get-Content -Path "function:/$Command" -ErrorAction Ignore).Ast
                    Parameters = $Parameters
                }

                $Examples = $Help.Help.Examples.Example |
                    ForEach-Object {    @{
                                            Example = $_
                                            Title = $_.title -replace '-',''
                                        }
                    }

            #EndRegion Discovery

            It "[ $Command ] has comment based help" -TestCases $Help {
                $Help | Should -Not -BeNullOrEmpty
            }

            It "[ $Command ] contains a synopsis" -TestCases $Help {
                $Help.Synopsis | Should -Not -BeNullOrEmpty
            }

            It "[ $Command ] contains a description" -TestCases $Help {
                $Help.Description | Should -Not -BeNullOrEmpty
            }

            It "[ $Command ] contains an example" -TestCases $Help {
                $Help.Examples | Should -Not -BeNullOrEmpty
            }

            It "[ $Command ] contains a note" -TestCases $Help {
                $Notes = $Help.AlertSet.Alert.Text -split '\n'
                $Notes[0].Trim() | Should -Not -BeNullOrEmpty
            }

            It "[ $Command ] contains a link" -TestCases $Help {
                $Help.relatedLinks | Should -Not -BeNullOrEmpty
            }

            # This will be skipped for compiled commands ($Ast.Ast will be $null)
            It "[ $Command ] has a help entry for all parameters" -TestCases $Ast -Skip:(-not ($Parameters -and $Ast.Ast)) {
                @($Parameters).Count | Should -Be $Ast.Body.ParamBlock.Parameters.Count -Because 'the number of parameters in the help should match the number in the function script'
            }

            # -<Name> is a pester variable
            It "[ $Command ] has a description for parameter [ -<Name> ]" -TestCases $Parameters -Skip:(-not $Parameters) {
                $Description | Should -Not -BeNullOrEmpty -Because "parameter $Name should have a description"
            }

            It "[ $Command ] has at least one usage example" -TestCases $Help {
                $Help.Examples.Example.Code.Count | Should -BeGreaterOrEqual 1
            }

            # <title> is a pester variable
            It "[ $Command ] lists a description for: [ <title> ]" -TestCases $Examples {
                $Example.Remarks | Should -Not -BeNullOrEmpty -Because "example $($Example.Title) should have a description!"
            }
        }
    }
}