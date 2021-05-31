# Locations of settings path and file
$ITGlueAPIConfPath = "$($env:USERPROFILE)\ITGlueAPI"
$ITGlueAPIConfFile = "config.psd1"

function Export-ITGlueModuleSettings {
    # Confirm variables exist and are not null before exporting
    if ($ITGlue_Base_URI -and $ITGlue_API_Key -and $ITGlue_JSON_Conversion_Depth) {
        $secureString = $ITGlue_API_KEY | ConvertFrom-SecureString
        New-Item -ItemType Directory -Force -Path $ITGlueAPIConfPath | ForEach-Object{$_.Attributes = "hidden"}
@"
@{
    ITGlue_Base_URI = '$ITGlue_Base_URI'
    ITGlue_API_Key = '$secureString'
    ITGlue_JSON_Conversion_Depth = '$ITGlue_JSON_Conversion_Depth'
}
"@ | Out-File -FilePath ($ITGlueAPIConfPath+"\"+$ITGlueAPIConfFile) -Force
    }
    else {
        Write-Host "Failed export ITGlue Module settings to $ITGlueAPIConfPath\$ITGlueAPIConfFile"
    }
}

function Import-ITGlueModuleSettings {

    # PLEASE ADD ERROR CHECKING SUCH AS TESTING FOR VALID VARIABLES?

    if(test-path ($ITGlueAPIConfPath+"\"+$ITGlueAPIConfFile) )  {
        $tmp_config = Import-LocalizedData -BaseDirectory $ITGlueAPIConfPath -FileName $ITGlueAPIConfFile

        # Send to function to strip potentially superflous slash (/)
        Add-ITGlueBaseURI $tmp_config.ITGlue_Base_URI

        $tmp_config.ITGlue_API_key = ConvertTo-SecureString $tmp_config.ITGlue_API_key

        Set-Variable -Name "ITGlue_API_Key"  -Value $tmp_config.ITGlue_API_key `
                    -Option ReadOnly -Scope global -Force

        Set-Variable -Name "ITGlue_JSON_Conversion_Depth" -Value $tmp_config.ITGlue_JSON_Conversion_Depth `
                    -Scope global -Force 

        Write-Host "ITGlueAPI Module configuration loaded successfully from $ITGlueAPIConfPath\$ITGlueAPIConfFile!" -ForegroundColor Green

        # Clean things up
        Remove-Variable "tmp_config"
    }
    else {
        Write-Host "No configuration file was found at $ITGlueAPIConfPath\$ITGlueAPIConfFile." -ForegroundColor Red
        
        Set-Variable -Name "ITGlue_Base_URI" -Value "https://api.itglue.com" -Option ReadOnly -Scope global -Force
        
        Write-Host "Using https://api.itglue.com as Base URI. Run Add-ITGlueBaseURI to modify."
        Write-Host "Please run Add-ITGlueAPIKey to get started." -ForegroundColor Red
        
        Set-Variable -Name "ITGlue_JSON_Conversion_Depth" -Value 100 -Scope global -Force
    }
}