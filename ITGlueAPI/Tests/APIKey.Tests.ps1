<#
    .SYNOPSIS
        Pester tests for functions in the "APIKey.ps1" file

    .DESCRIPTION
        Pester tests for functions in the APIKey.ps1 file which
        is apart of the ITGlueAPI module.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\APIKey.Tests.ps1

        Runs a pester test against "APIKey.Tests.ps1" and outputs simple test results.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\APIKey.Tests.ps1 -Output Detailed

        Runs a pester test against "APIKey.Tests.ps1" and outputs detailed test results.

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


Describe "Testing [ *-ITGlueAPIKey ] functions with [ $FullFileName ]" {

    Context "[ Add-ITGlueAPIKey ] testing functions" {

        It "The ITGlue_API_Key variable should initially be empty or null" {
            Remove-ITGlueAPIKey
            $ITGlue_API_Key | Should -BeNullOrEmpty
        }

        It "[ Add-ITGlueAPIKey ] should accept a value from the pipeline" {
            "MyApiKey" | Add-ITGlueAPIKey
            Get-ITGlueAPIKey | Should -Not -BeNullOrEmpty
        }

        It "[ Add-ITGlueAPIKey ] called with parameter -API_Key should not be empty" {
            Add-ITGlueAPIKey -Api_Key "MyApiKey"
            Get-ITGlueAPIKey | Should -Not -BeNullOrEmpty
        }
    }

    Context "[ Get-ITGlueAPIKey ] testing functions" {

        It "[ Get-ITGlueAPIKey ] should return a value" {
            Get-ITGlueAPIKey | Should -Not -BeNullOrEmpty
        }

        It "[ Get-ITGlueAPIKey ] should be a SecureString (From PipeLine)" {
            "MyApiKey" | Add-ITGlueAPIKey
            Get-ITGlueAPIKey | Should -BeOfType SecureString
        }

        It "[ Get-ITGlueAPIKey ] should be a SecureString (With Parameter)" {
            Add-ITGlueAPIKey -Api_Key "MyApiKey"
            Get-ITGlueAPIKey | Should -BeOfType SecureString
        }

    }

    Context "[ Remove-ITGlueAPIKey ] testing functions" {

        It "[ Remove-ITGlueAPIKey ] should remove the ITGlue_API_Key variable" {
            Add-ITGlueAPIKey -Api_Key "MyApiKey"
            Remove-ITGlueAPIKey
            $ITGlue_API_Key | Should -BeNullOrEmpty
        }
    }

    Context "[ Test-ITGlueAPIKey ] testing functions" {

        It "[ Test-ITGlueAPIKey ] without an API key should fail to authenticate" {
            Remove-ITGlueAPIKey -WarningAction SilentlyContinue
            $Value = Test-ITGlueAPIKey -WarningAction SilentlyContinue
            $Value.Message | Should -BeLike '*password" is null*'
        }

        It "[ Test-ITGlueAPIKey ] with an incorrect API key should fail to authenticate" {
            Add-ITGlueAPIKey -Api_Key "MyApiKey"
            $Value = Test-ITGlueAPIKey -WarningAction SilentlyContinue
            $Value.Message | Should -BeLike '*403*'
        }

    }

}