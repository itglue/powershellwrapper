function Get-ITGluePlatforms {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'id', 'created_at', 'updated_at', `
                '-name', '-id', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/platforms/{0}' -f $id)

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_name) {
            $filter_list['filter[name]'] = $filter_name
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
