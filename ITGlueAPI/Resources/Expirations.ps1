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
        [Nullable[Int64]]$id
    )

    $resource_uri = ('/expirations/{0}' -f $id)
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $organization_id) + $resource_uri
    }

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if ($filter_resource_id) {
            $filter_list['filter[resource_id]'] = $filter_resource_id
        }
        if ($filter_resource_name) {
            $filter_list['filter[resource_name]'] = $filter_resource_name
        }
        if ($filter_resource_type_name) {
            $filter_list['filter[resource_type_name]'] = $filter_resource_type_name
        }
        if ($filter_description) {
            $filter_list['filter[description]'] = $filter_description
        }
        if ($filter_expiration_date) {
            $filter_list['filter[expiration_date]'] = $filter_expiration_date
        }
        if ($filter_organization_id) {
            $filter_list['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_range) {
            $filter_list['filter[range]'] = $filter_range
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
