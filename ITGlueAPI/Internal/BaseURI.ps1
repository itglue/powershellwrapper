function Add-ITGlueBaseURI {
<#
.SYNOPSIS
    Sets the base URI for the ITGlue API connection.

.DESCRIPTION
    The Add-ITGlueBaseURI cmdlet sets the base URI which is later used to construct the full URI for all API calls to ITGlue.

.PARAMETER base_uri
    Define the base URI for the ITGlue API connection using ITGlue's URI's or a custom URI.

.PARAMETER data_center
    ITGlue's URI connection point that can be one of the predefined data centers. The accepted values for this parameter are:
    [ US , EU , AU ]
    US = https://api.itglue.com
        EU = https://api.eu.itglue.com
        AU = https://api.au.itglue.com

.EXAMPLE
    Add-ITGlueBaseURI

    The base URI will use https://api.itglue.com which is ITGlue's US data center.

.EXAMPLE
    Add-ITGlueBaseURI -base_uri http://myapi.gateway.example.com

    A custom API gateway of http://myapi.gateway.example.com will be used for all API calls to ITGlue.

.EXAMPLE
    Add-ITGlueBaseURI -data_center AU

    The base URI will be https://api.au.itglue.com which is ITGlue's Australia data center.

#>

    [cmdletbinding()]
    Param (
        [parameter(ValueFromPipeline)]
        [string]$base_uri = 'https://api.itglue.com',

        [Alias('locale','dc')]
        [ValidateSet( 'US', 'EU', 'AU')]
        [String]$data_center = ''
    )

    # Trim superfluous forward slash from address (if applicable)
    if($base_uri[$base_uri.Length-1] -eq "/") {
        $base_uri = $base_uri.Substring(0,$base_uri.Length-1)
    }

    switch ($data_center) {
        'US' {$base_uri = 'https://api.itglue.com'}
        'EU' {$base_uri = 'https://api.eu.itglue.com'}
        'AU' {$base_uri = 'https://api.au.itglue.com'}
        Default {}
    }

    Set-Variable -Name "ITGlue_Base_URI" -Value $base_uri -Option ReadOnly -Scope global -Force
}

function Remove-ITGlueBaseURI {
    Remove-Variable -Name "ITGlue_Base_URI" -Scope global -Force
}

function Get-ITGlueBaseURI {
    $ITGlue_Base_URI
}

New-Alias -Name Set-ITGlueBaseURI -Value Add-ITGlueBaseURI