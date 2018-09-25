function Add-ITGlueAPIKey {
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
    if($ITGlue_API_Key -eq $null) {
        Write-Error "No API key exists. Please run Add-ITGlueAPIKey to add one."
    }
    else {
        $ITGlue_API_Key
    }
}

New-Alias -Name Set-ITGlueAPIKey -Value Add-ITGlueAPIKey