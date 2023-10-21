<#
    .SYNOPSIS
        Pester tests for functions in the "BaseURI.ps1" file

    .DESCRIPTION
        Pester tests for functions in the "BaseURI.ps1" file which
        is apart of the ITGlueAPI module.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\BaseURI.Tests.ps1

        Runs a pester test against "BaseURI.Tests.ps1" and outputs simple test results.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\BaseURI.Tests.ps1 -Output Detailed

        Runs a pester test against "BaseURI.Tests.ps1" and outputs detailed test results.

    .NOTES
        Build out more robust, logical, & scalable pester tests.
        Look into BeforeAll as it is not working as expected with this test

    .LINK
        https://github.com/itglue/powershellwrapper
#>

#Requires -Version 5.0
#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }
#Requires -Modules @{ ModuleName='ITGlueAPI'; ModuleVersion='2.1.0' }

# General variables
    $FullFileName = $MyInvocation.MyCommand.Name
    #$ThisFile = $PSCommandPath -replace '\.Tests\.ps1$'
    #$ThisFileName = $ThisFile | Split-Path -Leaf


Describe " Testing [ *-ITGlueBaseURI } functions with [ $FullFileName ]" {

    Context "[ Add-ITGlueBaseURI ] testing functions" {

        It "[ Add-ITGlueBaseURI ] should accept a value from the pipeline" {
            'https://itglue.com' | Add-ITGlueBaseURI
            Get-ITGlueBaseURI | Should -Be 'https://itglue.com'
        }

        It "[ Add-ITGlueBaseURI ] with parameter -base_uri should return a valid URI" {
            Add-ITGlueBaseURI -base_uri 'https://itglue.com'
            Get-ITGlueBaseURI | Should -Be 'https://itglue.com'
        }

        It "[ Add-ITGlueBaseURI ] a trailing / from a -base_uri should be removed" {
            Add-ITGlueBaseURI -base_uri 'https://itglue.com/'
            Get-ITGlueBaseURI | Should -Be 'https://itglue.com'
        }

    }

    Context "[ Get-ITGlueBaseURI ] testing functions" {

        It "[ Get-ITGlueBaseURI ] value should be a string" {
            Add-ITGlueBaseURI -base_uri 'https://itglue.com'
            Get-ITGlueBaseURI | Should -BeOfType string
        }
    }

    Context "[ Remove-ITGlueBaseURI ] testing functions" {

        It "[ Remove-ITGlueBaseURI ] should remove the variable" {
            Add-ITGlueBaseURI -base_uri 'https://itglue.com'
            Remove-ITGlueBaseURI
            $ITGlue_Base_URI | Should -BeNullOrEmpty
        }
    }

}