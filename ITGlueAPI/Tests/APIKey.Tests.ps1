#Requires -Modules Pester

# Obtain name of this file
$ThisFile = $PSCommandPath -replace '\.Tests\.ps1$'
$ThisFileName = $ThisFile | Split-Path -Leaf

Describe "Tests" {
    Context "Test $ThisFileName Functions" {
        It "ITGlue_API_Key should intially be empty or null" {
            $ITGlue_API_Key | Should -BeNullOrEmpty
        }
        It "Add-ITGlueAPIKey called with parameter ITGlue_API_Key should not be empty" {
            Add-ITGlueAPIKey -Api_Key "ITGAPIKEY"
            Get-ITGlueAPIKey | Should -Not -BeNullOrEmpty
        }
        It "Get-ITGlueAPIKey should return a value" {
            Get-ITGlueAPIKey | Should -Not -BeNullOrEmpty
        }
        It "Remove-ITGlueAPIKey should remove the ITGlue_API_Key variable" {
            Remove-ITGlueAPIKey
            Get-ITGlueAPIKey | Should -BeNullOrEmpty
        }
    }
}