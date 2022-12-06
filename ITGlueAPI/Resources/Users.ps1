function Get-ITGlueUsers {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_email = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet('Administrator', 'Manager', 'Editor', 'Creator', 'Lite', 'Read-only')]
        [String]$filter_role_name = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'email', 'reputation', 'id', 'created_at', 'updated-at', `
                '-name', '-email', '-reputation', '-id', '-created_at', '-updated-at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/users/{0}' -f $id)

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if ($filter_email) {
            $filter_list['filter[email]'] = $filter_email
        }
        if ($filter_role_name) {
            $filter_list['filter[role_name]'] = $filter_role_name
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

function Set-ITGlueUsers {
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/users/{0}' -f $id)

    return Set-ITGlue -resource_uri $resource_uri -data $data
}
