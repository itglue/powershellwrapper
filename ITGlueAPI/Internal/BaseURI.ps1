function Add-ITGlueBaseURI {
<#
    .SYNOPSIS
        Sets the base URI for the ITGlue API connection.

    .DESCRIPTION
        The Add-ITGlueBaseURI cmdlet sets the base URI which is used
        to construct the full URI for all API calls.

    .PARAMETER base_uri
        Sets the base URI for the ITGlue API connection. Helpful
        if using a custom API gateway.

        The default value is 'https://api.itglue.com'

    .PARAMETER data_center
        Defines the data center to use which in turn defines which
        base API URL is used.

        Allowed values:
        'US', 'EU', 'AU'

            'US' = 'https://api.itglue.com'
            'EU' = 'https://api.eu.itglue.com'
            'AU' = 'https://api.au.itglue.com'

    .EXAMPLE
        Add-ITGlueBaseURI

        The base URI will use https://api.itglue.com

    .EXAMPLE
        Add-ITGlueBaseURI -base_uri 'https://my.gateway.com'

        The base URI will use https://my.gateway.com

    .EXAMPLE
        'https://my.gateway.com' | Add-ITGlueBaseURI

        The base URI will use https://my.gateway.com

    .EXAMPLE
        Add-ITGlueBaseURI -data_center EU

        The base URI will use https://api.eu.itglue.com

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [parameter(ValueFromPipeline)]
        [string]$base_uri = 'https://api.itglue.com',

        [Alias('locale','dc')]
        [ValidateSet( 'US', 'EU', 'AU')]
        [String]$data_center = ''
    )

    process{

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

}



function Get-ITGlueBaseURI {
<#
    .SYNOPSIS
        Shows the ITGlue base URI

    .DESCRIPTION
        The Get-ITGlueBaseURI cmdlet shows the ITGlue base URI from
        the global variable

    .EXAMPLE
        Get-ITGlueBaseURI

        Shows the ITGlue base URI value defined in the global variable

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param ()

    if ($ITGlue_Base_URI){
        $ITGlue_Base_URI
    }
    else{
        Write-Warning "The ITGlue base URI is not set. Run Add-ITGlueBaseURI to set the base URI."
    }

}



function Remove-ITGlueBaseURI {
<#
    .SYNOPSIS
        Removes the ITGlue base URI global variable.

    .DESCRIPTION
        The Remove-ITGlueBaseURI cmdlet removes the ITGlue base URI from
        the global variable.

    .EXAMPLE
        Remove-ITGlueBaseURI

        Removes the ITGlue base URI value from the global variable

    .NOTES
        N\A

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding(SupportsShouldProcess)]
    Param ()

    if ($ITGlue_Base_URI) {
        Remove-Variable -Name "ITGlue_Base_URI" -Scope global -Force -WhatIf:$WhatIfPreference
    }
    else{
        Write-Verbose "The ITGlue base URI variable is not set. Nothing to remove"
    }

}



New-Alias -Name Set-ITGlueBaseURI -Value Add-ITGlueBaseURI