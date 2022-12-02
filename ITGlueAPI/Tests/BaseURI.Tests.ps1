#Requires -Modules Pester

# Obtain name of this file
$ThisFile = $PSCommandPath -replace '\.Tests\.ps1$'
$ThisFileName = $ThisFile | Split-Path -Leaf

Describe "Tests" {
    Context "Test $ThisFileName Functions" {
        It "Add-ITGlueBaseURI without parameter should return a valid URI" {
            Add-ITGlueBaseURI
            $BaseURI = Get-ITGlueBaseURI
            $BaseURI | Should -Be 'https://api.itglue.com'
        }
        It "Add-ITGlueBaseURI parameter US should return a valid URI" {
            Add-ITGlueBaseURI -data_center 'US'
            $BaseURI = Get-ITGlueBaseURI
            $BaseURI | Should -Be 'https://api.itglue.com'
        }
        It "Add-ITGlueBaseURI parameter EU should return a valid URI" {
            Add-ITGlueBaseURI -data_center 'EU'
            $BaseURI = Get-ITGlueBaseURI
            $BaseURI | Should -Be 'https://api.eu.itglue.com'
        }
        It "Add-ITGlueBaseURI parameter AU should return a valid URI" {
            Add-ITGlueBaseURI -data_center 'AU'
            $BaseURI = Get-ITGlueBaseURI
            $BaseURI | Should -Be 'https://api.au.itglue.com'
        }
        It "Remove-ITGlueBaseURI should remove the variable" {
            Remove-ITGlueBaseURI
            $BaseURI = Get-ITGlueBaseURI
            $BaseURI | Should -BeNullOrEmpty
        }
    }
}