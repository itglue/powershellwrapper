function Add-ITGlueBaseURI {
    [cmdletbinding()]
    Param (
        [parameter(ValueFromPipeline)]
        [string]$base_uri = "http://api.itglue.com"
    )

    # Trim superflous forward slash from address (if applicable)
    if($base_uri[$base_uri.Length-1] -eq "/") {
        $base_uri = $base_uri.Substring(0,$base_uri.Length-1)
    }


    Set-Variable -Name "ITGlue_Base_URI" -Value $base_uri  -Option ReadOnly -Scope global -Force
}


function Remove-ITGlueBaseURI {
    Remove-Variable -Name "ITGlue_Base_URI"  -Force 
}

function Get-ITGlueBaseURI {
    $ITGlue_Base_URI
}

New-Alias -Name Set-ITGlueBaseURI -Value Add-ITGlueBaseURI