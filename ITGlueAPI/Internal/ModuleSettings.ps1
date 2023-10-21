function Export-ITGlueModuleSettings {
<#
    .SYNOPSIS
        Exports the ITGlue BaseURI, API, & JSON configuration information to file.

    .DESCRIPTION
        The Export-ITGlueModuleSettings cmdlet exports the ITGlue BaseURI, API, &
        JSON configuration information to file.

        Making use of PowerShell's System.Security.SecureString type, exporting module settings
        encrypts your API key in a format that can only be unencrypted with the Windows account
        that encrypted the API key.

        This means that you cannot copy your configuration file to another computer or
        use another user account and expect it to work.

    .PARAMETER itglue_api_conf_path
        Define the location to store the ITGlue configuration file.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\ITGlueAPI

    .PARAMETER itglue_api_conf_file
        Define the name of the ITGlue configuration file.

        By default the configuration file is named:
            config.psd1

    .PARAMETER open_conf_path
        Opens the config path location, helpful for testing
        and validation.

    .EXAMPLE
        Export-ITGlueModuleSettings

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's ITGlue configuration file located at:
            $env:USERPROFILE\ITGlueAPI\config.psd1

    .EXAMPLE
        Export-ITGlueModuleSettings -itglue_api_conf_path C:\ITGlueAPI -itglue_api_conf_file MyConfig.psd1 -open_conf_path

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's ITGlue configuration file located at:
            C:\ITGlueAPI\MyConfig.psd1

        If the configuration file is successfully created then its save location is opened up.

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$itglue_api_conf_path = "$($env:USERPROFILE)\ITGlueAPI",

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$itglue_api_conf_file = 'config.psd1',

        [Parameter(Mandatory = $false)]
        [switch]$open_conf_path
    )

    # Confirm variables exist and are not null before exporting
    if ($ITGlue_Base_URI -and $ITGlue_API_Key -and $ITGlue_JSON_Conversion_Depth) {
        $secureString = $ITGlue_API_KEY | ConvertFrom-SecureString
        New-Item -ItemType Directory -Force -Path $itglue_api_conf_path | ForEach-Object {$_.Attributes = "hidden"}
@"
@{
    ITGlue_Base_URI = '$ITGlue_Base_URI'
    ITGlue_API_Key = '$secureString'
    ITGlue_JSON_Conversion_Depth = '$ITGlue_JSON_Conversion_Depth'
}
"@ | Out-File -FilePath ($itglue_api_conf_path+"\"+$itglue_api_conf_file) -Force

        if ( Test-Path ($itglue_api_conf_path+"\"+$itglue_api_conf_file) -PathType Leaf ){
            Write-Output "ITGlueAPI Module configuration saved to [ $itglue_api_conf_path\$itglue_api_conf_file ]"

            if ($open_conf_path){
                Invoke-Item -Path $itglue_api_conf_path
            }

        }
        else{
            Write-Error "Failed to export ITGlue Module settings to [ $itglue_api_conf_path\$itglue_api_conf_file ]"
        }

    }
    else {
        Write-Error "Failed to export ITGlue Module settings due to missing core variables"
    }

}



function Import-ITGlueModuleSettings {
<#
    .SYNOPSIS
        Imports the ITGlue BaseURI, API, & JSON configuration information to the current session.

    .DESCRIPTION
        The Import-ITGlueModuleSettings cmdlet imports the ITGlue BaseURI, API, & JSON configuration
        information stored in the ITGlue configuration file to the users current session.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\ITGlueAPI

    .PARAMETER itglue_api_conf_path
        Define the location to store the ITGlue configuration file.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\ITGlueAPI

    .PARAMETER itglue_api_conf_file
        Define the name of the ITGlue configuration file.

        By default the configuration file is named:
            config.psd1

    .EXAMPLE
        Import-ITGlueModuleSettings

        Validates that the configuration file created with the Export-ITGlueModuleSettings cmdlet exists
        then imports the stored data into the current users session.

        The default location of the ITGlue configuration file is:
            $env:USERPROFILE\ITGlueAPI\config.psd1

    .EXAMPLE
        Import-ITGlueModuleSettings -itglue_api_conf_path C:\ITGlueAPI -itglue_api_conf_file MyConfig.psd1

        Validates that the configuration file created with the Export-ITGlueModuleSettings cmdlet exists
        then imports the stored data into the current users session.

        The location of the ITGlue configuration file in this example is:
            C:\ITGlueAPI\MyConfig.psd1

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$itglue_api_conf_path = "$($env:USERPROFILE)\ITGlueAPI",

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$itglue_api_conf_file = 'config.psd1'
    )

    if( Test-Path ($itglue_api_conf_path+"\"+$itglue_api_conf_file ) -PathType Leaf ) {
        $tmp_config = Import-LocalizedData -BaseDirectory $itglue_api_conf_path -FileName $itglue_api_conf_file

            # Send to function to strip potentially superfluous slash (/)
            Add-ITGlueBaseURI $tmp_config.ITGlue_Base_URI

            $tmp_config.ITGlue_API_key = ConvertTo-SecureString $tmp_config.ITGlue_API_key

            Set-Variable -Name "ITGlue_API_Key"  -Value $tmp_config.ITGlue_API_key -Option ReadOnly -Scope global -Force

            Set-Variable -Name "ITGlue_JSON_Conversion_Depth" -Value $tmp_config.ITGlue_JSON_Conversion_Depth -Scope global -Force

        Write-Verbose "ITGlueAPI Module configuration loaded successfully from [ $itglue_api_conf_path\$itglue_api_conf_file ]"

        # Clean things up
        Remove-Variable "tmp_config"
    }
    else {
        Write-Verbose "No configuration file was found at [ $itglue_api_conf_path\$itglue_api_conf_file ] run Add-ITGlueBaseURI & Add-ITGlueAPIKey to get started."

        Set-Variable -Name "ITGlue_Base_URI" -Value "https://api.itglue.com" -Option ReadOnly -Scope global -Force
        Set-Variable -Name "ITGlue_JSON_Conversion_Depth" -Value 100 -Scope global -Force
    }
}



function Remove-ITGlueModuleSettings {
<#
    .SYNOPSIS
        Removes the stored ITGlue configuration folder.

    .DESCRIPTION
        The Remove-ITGlueModuleSettings cmdlet removes the ITGlue folder and its files.
        This cmdlet also has the option to remove sensitive ITGlue variables as well.

        By default configuration files are stored in the following location and will be removed:
            $env:USERPROFILE\ITGlueAPI

    .PARAMETER itglue_api_conf_path
        Define the location of the ITGlue configuration folder.

        By default the configuration folder is located at:
            $env:USERPROFILE\ITGlueAPI

    .PARAMETER AndVariables
        Define if sensitive ITGlue variables should be removed as well.

        By default the variables are not removed.

    .EXAMPLE
        Remove-ITGlueModuleSettings

        Checks to see if the default configuration folder exists and removes it if it does.

        The default location of the ITGlue configuration folder is:
            $env:USERPROFILE\ITGlueAPI

    .EXAMPLE
        Remove-ITGlueModuleSettings -itglue_api_conf_path C:\ITGlueAPI -AndVariables

        Checks to see if the defined configuration folder exists and removes it if it does.
        If sensitive ITGlue variables exist then they are removed as well.

        The location of the ITGlue configuration folder in this example is:
            C:\ITGlueAPI

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$itglue_api_conf_path = "$($env:USERPROFILE)\ITGlueAPI",

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [switch]$AndVariables
    )

    if(Test-Path $itglue_api_conf_path) {

        Remove-Item -Path $itglue_api_conf_path -Recurse -Force -WhatIf:$WhatIfPreference

        If ($AndVariables) {
            if ($ITGlue_API_Key) {
                Remove-Variable -Name 'ITGlue_API_Key' -Scope Global -Force -WhatIf:$WhatIfPreference
            }
            if ($ITGlue_Base_URI) {
                Remove-Variable -Name 'ITGlue_Base_URI' -Scope Global -Force -WhatIf:$WhatIfPreference
            }
        }


        if ($WhatIfPreference -eq $false){

            if ( !(Test-Path $itglue_api_conf_path) ) {
                Write-Output "The ITGlueAPI configuration folder has been removed successfully from [ $itglue_api_conf_path ]"
            }
            else {
                Write-Error "The ITGlueAPI configuration folder could not be removed from [ $itglue_api_conf_path ]"
            }

        }

    }
    else {
        Write-Warning "No configuration folder found at [ $itglue_api_conf_path ]"
    }
}