function Get-ITGlueUserMetrics {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$filter_user_id = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$filter_organization_id = $null,

        [Parameter(ParameterSetName="index")]
        [String]$filter_resource_type = "",

        [Parameter(ParameterSetName="index")]
        [String]$filter_date = "",

        [Parameter(ParameterSetName="index")]
        [ValidateSet( "created",  "viewed",  "edited",  "deleted", "date", `
                     "-created", "-viewed", "-edited", "-deleted","-date")]
        [String]$sort = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null
    )

    $resource_uri = "/user_metrics"

    if($PSCmdlet.ParameterSetName -eq "index") {
        $body = @{
                "filter[resource_type]" = $filter_resource_type
                "filter[date]" = $filter_date
                "sort" = $sort
        }
        if($filter_user_id) {
            $body += @{"filter[user_id]" = $filter_user_id}
        }
        if($filter_organization_id) {
            $body += @{"filter[organization_id]" = $filter_organization_id}
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