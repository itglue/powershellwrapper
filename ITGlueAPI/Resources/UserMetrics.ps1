function Get-ITGlueUserMetrics {
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
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'index')]
        [Switch]$all
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

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params -AllResults:$all
}
