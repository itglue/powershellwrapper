function New-ITGlueConfigurations {
    Param (
        [Nullable[Int]]$organization_id = $null,

        [Parameter(Mandatory=$true)]
        $data
    )

    $resource_uri = "/configurations"

    if($organization_id) {
        $resource_uri = "/organizations/${organization_id}/relationships/configurations"
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




function Get-ITGlueConfigurations {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$id,

        [Parameter(ParameterSetName="index")]
        [String]$filter_name = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$filter_organization_id = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$filter_configuration_type_id = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$filter_configuration_status_id = $null,

        [Parameter(ParameterSetName="index")]
        [String]$filter_serial_number = "",

        [Parameter(ParameterSetName="index")]
        [String]$sort = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName="index")]
        [String]$include = "",

        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$organization_id = $null
    )

    $resource_uri = "/configurations/${id}"

    if($PSCmdlet.ParameterSetName -eq "index") {
        $body = @{
                "filter[name]" = $filter_name
                "filter[serial-number]" = $filter_serial_number
                "sort" = $sort
        }
        if($filter_organization_id) {$body += @{"filter[organization-id]" = $filter_organization_id}}
        if($filter_configuration_type_id) {$body += @{"filter[configuration-type-id]" = $filter_configuration_type_id}}
        if($filter_configuration_status_id) {$body += @{"filter[configuration-status-id]" = $filter_configuration_status_id}}
        if($page_number) {$body += @{"page[number]" = $page_number}}
        if($page_size) {$body += @{"page[size]" = $page_size}}
    }
    else {
        #Parameter set "Show" is selected; switch to nested relationships route
        $resource_uri = "/organizations/${organization_id}/relationships/configurations/${id}"
    }


    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "GET" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers -body $body
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist


    $data = $rest_output.data   
    return $data
}





function Set-ITGlueConfigurations {
    Param (
        [Nullable[Int]]$id = $null,

        [Nullable[Int]]$organization_id = $null,

        [Parameter(Mandatory=$true)]
        $data
    )

    $resource_uri = "/configurations/${id}"

    if($flexible_asset_type_id) {
        $resource_uri = "/organizations/${organization_id}/relationships/configurations/${id}"
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