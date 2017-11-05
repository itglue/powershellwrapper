function New-ITGlueFlexibleAssetFields {
    Param (
        [Nullable[Int]]$flexible_asset_type_id = $null,

        [Parameter(Mandatory=$true)]
        $data
    )

    $resource_uri = "/flexible_asset_fields/"

    if($flexible_asset_type_id) {
        $resource_uri = "/flexible_asset_types/${flexible_asset_type_id}/relationships/flexible_asset_fields"
    }

    $body = ConvertTo-Json $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "POST" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}




function Get-ITGlueFlexibleAssetFields {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$flexible_asset_type_id = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$id = $null
    )
    
    $resource_uri = "/flexible_asset_fields/${id}"

    if($flexible_asset_type_id) {
        $resource_uri = "/flexible_asset_types/${flexible_asset_type_id}/relationships/flexible_asset_fields/${id}"
    }

    if($PSCmdlet.ParameterSetName -eq "index") {
        $body = @{}
        if($page_number) {$body += @{"page[number]" = $page_number}}
        if($page_size) {$body += @{"page[size]" = $page_size}}
    }
    elseif ($flexible_asset_type_id -eq $null){
        #Parameter set "Show" is selected and no flexible asset type id is specified; switch from nested relationships route
        $resource_uri = "/flexible_asset_fields/${id}"
    }


    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "GET" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}





function Set-ITGlueFlexibleAssetFields {
    Param (
        [Nullable[Int]]$flexible_asset_type_id = $null,

        [Nullable[Int]]$id = $null,

        [Parameter(Mandatory=$true)]
        $data
    )

    $resource_uri = "/flexible_asset_fields/${id}"

    if($flexible_asset_type_id) {
        $resource_uri = "/flexible_asset_types/${flexible_asset_type_id}/relationships/flexible_asset_fields/${id}"
    }

    $body = ConvertTo-Json $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "PATCH" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}






function Remove-ITGlueFlexibleAssetFields {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    Param (
        [Parameter(Mandatory=$true)]
        [Int]$id,

        [Nullable[Int]]$flexible_asset_type_id = $null
    )

    $resource_uri = "/flexible_asset_fields/${id}"

    if($flexible_asset_type_id) {
        $resource_uri = "/flexible_asset_types/${flexible_asset_type_id}/relationships/flexible_asset_fields/${id}"
    }

    if ($pscmdlet.ShouldProcess($id)) {

        $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
        $rest_output = Invoke-RestMethod -method "DELETE" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                         -ErrorAction Stop -ErrorVariable $web_error
        $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

        $data = @{}
        $data = $rest_output 
        return $data
    }
}
