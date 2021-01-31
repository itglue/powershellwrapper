#Requires -Modules Pester

# Obtain name of this file
$ThisFile = $PSCommandPath -replace '\.Tests\.ps1$'
$ThisFileName = $ThisFile | Split-Path -Leaf

Describe "Tests" {
    Context "Test $ThisFileName Functions" {
        It "Add-ITGlueBaseURI without parameter should reutrn a valid URI" {
            Add-ITGlueBaseURI
            $BaseURI = Get-ITGlueBaseURI
            $BaseURI | Should -Be 'https://api.itglue.com'
        }
        It "Add-ITGlueBaseURI parameter US should reutrn a valid URI" {
            Add-ITGlueBaseURI -data_center 'US'
            $BaseURI = Get-ITGlueBaseURI
            $BaseURI | Should -Be 'https://api.itglue.com'
        }
        It "Add-ITGlueBaseURI parameter EU should reutrn a valid URI" {
            Add-ITGlueBaseURI -data_center 'EU'
            $BaseURI = Get-ITGlueBaseURI
            $BaseURI | Should -Be 'https://api.eu.itglue.com'
        }
        It "Remove-ITGlueBaseURI should remove the variable" {
            Remove-ITGlueBaseURI
            $BaseURI = Get-ITGlueBaseURI
            $BaseURI | Should -BeNullOrEmpty
        }
    }
}