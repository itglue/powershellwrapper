function Get-ITGlueExpirations {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_resource_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_resource_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_resource_type_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_description = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_expiration_date = '',

        [Parameter(ParameterSetName = 'index')]
        [Int64]$filter_organization_id = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_range = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'id', 'organization_id', 'expiration_date', 'created_at', 'updated_at', `
                '-id', '-organization_id', '-expiration_date', '-created_at', '-updated_at')]
        [String]$sort,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(Mandatory = $true, ParameterSetName = 'show')]
        [Nullable[Int64]]$id,

        [Parameter(ParameterSetName = 'show')]
        [Parameter(ParameterSetName = 'index')]
        [Switch]$all
    )

    $resource_uri = ('/expirations/{0}' -f $id)
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $organization_id) + $resource_uri
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_resource_id) {
            $query_params['filter[resource_id]'] = $filter_resource_id
        }
        if ($filter_resource_name) {
            $query_params['filter[resource_name]'] = $filter_resource_name
        }
        if ($filter_resource_type_name) {
            $query_params['filter[resource_type_name]'] = $filter_resource_type_name
        }
        if ($filter_description) {
            $query_params['filter[description]'] = $filter_description
        }
        if ($filter_expiration_date) {
            $query_params['filter[expiration_date]'] = $filter_expiration_date
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_range) {
            $query_params['filter[range]'] = $filter_range
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
