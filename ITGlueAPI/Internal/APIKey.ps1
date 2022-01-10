function Add-ITGlueAPIKey {
<#
.SYNOPSIS
    Sets your API key used to authenticate all API calls.

.DESCRIPTION
    The Add-ITGlueAPIKey cmdlet sets your API key which is used to authenticate all API calls made to ITGlue.
    Once the API key is defined by Add-ITGlueAPIKey, it is encrypted.

    ITGlue API keys are generated via the ITGlue web interface at Account > Settings > API Keys.

    Most ITGlueAPI functions cleanup the API key from headers after commands are run so that it doesn't persist.

.PARAMETER Api_Key
    Define your API key that was generated from ITGlue.

.EXAMPLE
    Add-ITGlueAPIKey

    Prompts to enter in the API Key

.EXAMPLE
    Add-ITGlueAPIKey -Api_key 'your_api_key'

    The ITGlue API will use the string entered into the [ -Api_Key ] parameter.

.EXAMPLE
    '123.123' | Add-ITGlueAPIKey

    The Add-ITGlueAPIKey function will use the string passed into it as its API key.

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [Alias('ApiKey')]
        [string]$Api_Key
    )
    if ($Api_Key) {
        $x_api_key = ConvertTo-SecureString $Api_Key -AsPlainText -Force

        Set-Variable -Name "ITGlue_API_Key" -Value $x_api_key -Option ReadOnly -Scope global -Force
    }
    else {
        Write-Host "Please enter your API key:"
        $x_api_key = Read-Host -AsSecureString

        Set-Variable -Name "ITGlue_API_Key" -Value $x_api_key -Option ReadOnly -Scope global -Force
    }
}

function Remove-ITGlueAPIKey {
    Remove-Variable -Name "ITGlue_API_Key" -Scope global -Force
}

function Get-ITGlueAPIKey {
    if($null -eq $ITGlue_API_Key) {
        Write-Error "No API key exists. Please run Add-ITGlueAPIKey to add one."
    }
    else {
        $ITGlue_API_Key
    }
}

New-Alias -Name Set-ITGlueAPIKey -Value Add-ITGlueAPIKey
