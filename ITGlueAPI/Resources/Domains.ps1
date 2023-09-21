function Get-ITGlueDomains {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_id = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet('created_at', 'updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet('passwords', 'attachments', 'user_resource_accesses', 'group_resource_accesses')]
        [String]$include = '',

        [Parameter(ParameterSetName = 'index')]
        [Switch]$all
    )

    $resource_uri = '/domains'
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/domains' -f $organization_id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
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

    if($include) {
        $query_params['include'] = $include
    }

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params -AllResults:$all
}
