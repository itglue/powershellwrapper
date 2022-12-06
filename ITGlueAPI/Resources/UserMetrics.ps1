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
        [Nullable[int]]$page_size = $null
    )

    $resource_uri = '/user_metrics'

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_user_id) {
            $filter_list['filter[user_id]'] = $filter_user_id
        }
        if ($filter_organization_id) {
            $filter_list['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_resource_type) {
            $filter_list['filter[resource_type]'] = $filter_resource_type
        }
        if ($filter_date) {
            $filter_list['filter[date]'] = $filter_date
        }
        if ($sort) {
            $filter_list['sort'] = $sort
        }
        if ($page_number) {
            $filter_list['page[number]'] = $page_number
        }
        if ($page_size) {
            $filter_list['page[size]'] = $page_size
        }
    }

    return Get-ITGlue -resource_uri $resource_uri -filter_list $filter_list
}
