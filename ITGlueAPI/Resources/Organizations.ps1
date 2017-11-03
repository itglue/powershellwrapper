function Get-ITGlueOrganizations {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [String]$filter_name = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$filter_organization_type_id = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$filter_organization_status_id = $null,

        [Parameter(ParameterSetName="index")]
        [String]$filter_exclude_name = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$filter_exclude_organization_type_id = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$filter_exclude_organization_status_id = $null,

        [Parameter(ParameterSetName="index")]
        [ValidateSet( "name",  "id",  "updated-at",  "organization_status_name",  "organization_type_name", `
                     "-name", "-id", "-updated-at", "-organization_status_name", "-organization_type_name")]
        [String]$sort = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$id = $null
    )

    $resource_uri = "/organizations/${id}"

    if($PSCmdlet.ParameterSetName -eq "index") {
        $body = @{
                "filter[name]" = $filter_name
                "filter[exclude][name]" = $filter_exclude_name
                "sort" = $sort
        }
        if($filter_organization_type_id) {
            $body += @{"filter[organization_type_id]" = $filter_organization_type_id}
        }
        if($filter_organization_type_id) {
            $body += @{"filter[organization_status_id]" = $filter_organization_status_id}
        }
        if($filter_exclude_organization_type_id) {
            $body += @{"filter[exclude][organization_type_id]" = $filter_exclude_organization_type_id}
        }
        if($filter_exclude_organization_type_id) {
            $body += @{"filter[exclude][organization_status_id]" = $filter_exclude_organization_status_id}
        }
        if($page_number) {
            $body += @{"page[number]" = $page_number}
        }
        if($page_size) {
            $body += @{"page[size]" = $page_size}
        }
    }


    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "GET" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}