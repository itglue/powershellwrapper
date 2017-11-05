function Export-ITGlueModuleSettings {

$secureString = $ITGlue_API_KEY | ConvertFrom-SecureString 
$outputPath = "$($env:USERPROFILE)\ITGlueAPI"
New-Item -ItemType Directory -Force -Path $outputPath | %{$_.Attributes = "hidden"}
@"
@{
    ITGlue_Base_URI = '$ITGlue_Base_URI'
    ITGlue_API_Key = '$secureString'
    ITGlue_JSON_Conversion_Depth = '$ITGlue_JSON_Conversion_Depth'
}
"@ | Out-File -FilePath ($outputPath+"\config.psd1") -Force


}



function Import-ITGlueModuleSettings {

    # PLEASE ADD ERROR CHECKING

    if(test-path "$($env:USERPROFILE)\ITGlueAPI") {
        $tmp_config = Import-LocalizedData -BaseDirectory "$($env:USERPROFILE)\ITGlueAPI" -FileName "config.psd1"

        # Send to function to strip potentially superflous slash (/)
        Add-ITGlueBaseURI $tmp_config.ITGlue_Base_URI

        $tmp_config.ITGlue_API_key = ConvertTo-SecureString $tmp_config.ITGlue_API_key

        Set-Variable -Name "ITGlue_API_Key"  -Value $tmp_config.ITGlue_API_key `
                    -Option ReadOnly -Scope global -Force

        Set-Variable -Name "ITGlue_JSON_Conversion_Depth" -Value $tmp_config.ITGlue_JSON_Conversion_Depth `
                    -Scope global -Force 

        # Clean things up
        Remove-Variable "tmp_config"

        Write-Host "Module configuration loaded successfully!" -ForegroundColor Green
    }
    else {
        Write-Host "No configuration file was found." -ForegroundColor Red
        
        Set-Variable -Name "ITGlue_Base_URI" -Value "https://api.itglue.com"  -Option ReadOnly -Scope global -Force
        
        Write-Host "Using https://api.itglue.com as Base URI. Run Add-ITGlueBaseURI to modify."
        Write-Host "Please run Add-ITGlueAPIKey to get started." -ForegroundColor Red
        
        Set-Variable -Name "ITGlue_JSON_Conversion_Depth" -Value 100  -Scope global -Force
    }
}