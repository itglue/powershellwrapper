function Add-ITGlueBaseURI {
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