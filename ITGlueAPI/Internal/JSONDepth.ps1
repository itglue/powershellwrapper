function Add-ITGlueJSONDepth {
    <#
.SYNOPSIS
    Sets variable $ITGlue_JSON_Conversion_Depth to supplied value.
.DESCRIPTION
    Sets variable $ITGlue_JSON_Conversion_Depth to supplied value.
.PARAMETER depth
    Specifies the JSON Depth variable for ITGlue.
    Defaults to 100
.EXAMPLE
    C:\PS> Add-ITGlueJSONDepth
.EXAMPLE
    C:\PS> Add-ITGlueJSONDepth -depth 100
.NOTES
#>
    [cmdletbinding()]
    Param (
        [parameter(Mandatory = $false, ValueFromPipeline)]
        [int]$depth = 100
    )
    Write-Verbose "Add-ITGlueJSONDepth: Starting function"
    try {
        Write-Verbose "Add-ITGlueJSONDepth: Attempting to set variable ITGlue_JSON_Conversion_Depth to $depth"
        Set-Variable -Name "ITGlue_JSON_Conversion_Depth" -Value $depth -Scope global -ErrorAction Stop
        Get-ITGlueJSONDepth
    }
    catch {
        Write-Error $_.Exception.Message
    }
}

function Remove-ITGlueJSONDepth {
<#
.SYNOPSIS
    Removes variable $ITGlue_JSON_Conversion_Depth.
.DESCRIPTION
    Removes variable $ITGlue_JSON_Conversion_Depth.
.EXAMPLE
    C:\PS> Remove-ITGlueJSONDepth
.NOTES
#>
    [cmdletbinding()]
    Param (

    )
    Write-Verbose "Remove-ITGlueJSONDepth: Starting function"
    if ($null -eq $ITGlue_JSON_Conversion_Depth) {
        Write-Verbose "Remove-ITGlueJSONDepth: ITGlue_JSON_Conversion_Depth not set"
        Write-Warning "No variable ITGlue_JSON_Conversion_Depth to be removed."
    }
    else {
        Write-Verbose "Remove-ITGlueJSONDepth: Removing ITGlue_JSON_Conversion_Depth variable"
        Remove-Variable -Name "ITGlue_JSON_Conversion_Depth" -Scope global -Force
    }
}

function Get-ITGlueJSONDepth {
<#
.SYNOPSIS
    Gets variable $ITGlue_JSON_Conversion_Depth.
.DESCRIPTION
    Retrieves the variable $ITGlue_JSON_Conversion_Depth, returns error if variable not set.
.EXAMPLE
    C:\PS> Get-ITGlueJSONDepth
.NOTES
#>
    [cmdletbinding()]
    Param (

    )
    Write-Verbose "Get-ITGlueJSONDepth: Starting function"
    if ($null -eq $ITGlue_JSON_Conversion_Depth) {
        Write-Verbose "Get-ITGlueJSONDepth: ITGlue_JSON_Conversion_Depth not set"
        Write-Error "No variable ITGlue_JSON_Conversion_Depth exists. Please run Add-ITGlueJSONDepth to add."
    }
    else {
        Write-Verbose "Get-ITGlueJSONDepth: ITGlue_JSON_Conversion_Depth retrieved"
        $ITGlue_JSON_Conversion_Depth
    }
}
