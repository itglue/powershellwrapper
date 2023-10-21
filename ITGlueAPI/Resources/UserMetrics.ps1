function Get-ITGlueUserMetrics {
<#
    .SYNOPSIS
        Lists all user metrics

    .DESCRIPTION
        The Get-ITGlueUserMetrics cmdlet lists all user metrics

    .PARAMETER filter_user_id
        Filter by user id

    .PARAMETER filter_organization_id
        Filter for users metrics by organization id

    .PARAMETER filter_resource_type
        Filter for user metrics by resource type

        Example:
            'Configurations','Passwords','Active Directory'

    .PARAMETER filter_date
        Filter for users metrics by a date range

        The specified string must be a date range and comma-separated `start_date, end_date`.
        The dates are UTC.

        Use `*` for unspecified `start_date` or `end_date`.

        Date ranges longer than a week may be disallowed for performance reasons.

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'id', 'created', 'viewed', 'edited', 'deleted', 'date', `
        '-id', '-created', '-viewed', '-edited', '-deleted', '-date'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .EXAMPLE
        Get-ITGlueUserMetrics

        Returns the first 50 user metric results from your ITGlue account

    .EXAMPLE
        Get-ITGlueUserMetrics -filter_user_id 12345

        Returns the user metric for the user with the defined id

    .EXAMPLE
        Get-ITGlueUserMetrics -page_number 2 -page_size 10

        Returns the first 10 results from the second page for user metrics
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#accounts-user-metrics-daily-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_user_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_resource_type = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_date = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'id', 'created', 'viewed', 'edited', 'deleted', 'date', `
                '-id', '-created', '-viewed', '-edited', '-deleted', '-date')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null
    )

    $resource_uri = '/user_metrics'

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_user_id) {
            $query_params['filter[user_id]'] = $filter_user_id
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_resource_type) {
            $query_params['filter[resource_type]'] = $filter_resource_type
        }
        if ($filter_date) {
            $query_params['filter[date]'] = $filter_date
        }
        if ($sort) {
            $query_params['sort'] = $sort
        }
        if ($page_number) {
            $query_params['page[number]'] = $page_number
        }
        if ($page_size) {
            $query_params['page[size]'] = $page_size
        }
    }

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params
}
