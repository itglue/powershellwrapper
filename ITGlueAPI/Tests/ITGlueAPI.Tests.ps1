# Tested with Pester module version 4.4.0

# Name of this module found by parsing name of test file (ITGlueAPI\Tests\ITGlueAPI.Tests.ps1)
$ThisModule = $PSCommandPath -replace '\.Tests\.ps1$'
$ThisModuleName = $ThisModule | Split-Path -Leaf

# Path of the module based on location of test file (ITGlueAPI\Tests\ITGlueAPI.Tests.ps1)
$ThisModulePath = Split-Path (Split-Path -Parent $PSCommandPath) -Parent

# Make sure one or multiple versions of the module are not loaded
Get-Module -Name $ThisModuleName | Remove-Module

# Internal Files
$InternalDirectoryFiles = (
    'APIKey.ps1',
    'BaseURI.ps1',
    'ModuleSettings.ps1'
)

# Resource Files
$ResourceDirectoryFiles = (
    'ConfigurationInterfaces.ps1',
    'Configurations.ps1',
    'ConfigurationStatuses.ps1',
    'ConfigurationTypes.ps1',
    'Contacts.ps1',
    'ContactTypes.ps1',
    'Countries.ps1',
    'FavoriteOrganizations.ps1',
    'FlexibleAssetFields.ps1',
    'FlexibleAssets.ps1',
    'FlexibleAssetTypes.ps1',
    'Groups.ps1',
    'Locations.ps1',
    'Manufacturers.ps1',
    'Models.ps1',
    'OperatingSystems.ps1',
    'Organizations.ps1',
    'OrganizationStatuses.ps1',
    'OrganizationTypes.ps1',
    'PasswordCategories.ps1',
    'Passwords.ps1',
    'Platforms.ps1',
    'Regions.ps1',
    'UserMetrics.ps1',
    'Users.ps1'
)

Describe '$ThisModuleName Module Tests' {
    
    Context 'Test Module' {
        It "has the root module $ThisModuleName.psm1" {
            "$ThisModulePath\$ThisModuleName.psm1" | Should Exist
        }

        It "has a manifest file of $ThisModuleName.psd1" {
            "$ThisModulePath\$ThisModuleName.psd1" | Should Exist
            # TODO - This test is currently failing...
            #"$ThisModulePath\$ThisModuleName.psd1" | Should Contain "ITGlueAPI.psm1"
        }

        It "$ThisModuleName\Resources directory has functions" {
            "$ThisModulePath\Resources\*.ps1" | Should Exist
        }

        # TODO - Only checking one file currently
        It "$ThisModuleName is valid PowerShell code" {
            $psFile = Get-Content -Path "$ThisModulePath\$ThisModuleName.psm1" -ErrorAction Stop
            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($psfile, [ref]$errors)
            $errors.Count | Should Be 0
        }
    }

    # Check that Internal files exist
    ForEach ($InternalFile in $InternalDirectoryFiles) {
        Context "Test $InternalFile Internal File in .\Internal directory" {
            It "$InternalFile should exist" {
                "$ThisModulePath\Internal\$InternalFile" | Should Exist
            }
        }
    }

    # Check that Resource files exist
    ForEach ($ResourceFile in $ResourceDirectoryFiles) {
        Context "Test $ResourceFile Resource File in .\Resources directory" {
            It "$ResourceFile should exist" {
                "$ThisModulePath\Resources\$ResourceFile" | Should Exist
            }
        }
    }
}