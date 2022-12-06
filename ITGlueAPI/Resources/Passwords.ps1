function New-ITGluePasswords {
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Boolean]$show_password = $true, # Passwords API defaults to $false

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/passwords/'

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords' -f $organization_id)
    }

    if (!$show_password) {
        $resource_uri = $resource_uri + ('?show_password=false') # using $False in PS results in 'False' (uppercase false), so explicitly writing out 'false' is needed
    }

    return New-ITGlue -resource_uri $resource_uri -data $data
}

function Get-ITGluePasswords {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[bool]]$filter_archived = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_password_category_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_url = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_cached_resource_name = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'username', 'id', 'created_at', 'updated-at', `
                '-name', '-username', '-id', '-created_at', '-updated-at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int64]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'show')]
        [Boolean]$show_password = $true, # Passwords API defaults to $true

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        $include = ''
    )

    $resource_uri = ('/passwords/{0}' -f $id)

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords/{1}' -f $organization_id, $id)
    }

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if ($filter_archived) {
            $filter_list['filter[archived]'] = $filter_archived
        }
        if ($filter_organization_id) {
            $filter_list['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_password_category_id) {
            $filter_list['filter[password_category_id]'] = $filter_password_category_id
        }
        if ($filter_url) {
            $filter_list['filter[url]'] = $filter_url
        }
        if ($filter_cached_resource_name) {
            $filter_list['filter[cached_resource_name]'] = $filter_cached_resource_name
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
    elseif ($null -eq $organization_id) {
        #Parameter set "Show" is selected and no organization id is specified; switch from nested relationships route
        $resource_uri = ('/passwords/{0}' -f $id)
    }

    if (!$show_password) {
        $filter_list['show_password'] = 'false' # using $False in PS results in 'False' (uppercase false), so explicitly writing out 'false' is needed
    }

    if($include) {
        $filter_list['include'] = $include
    }

    return Get-ITGlue -resource_uri $resource_uri -filter_list $filter_list
}

function Set-ITGluePasswords {
    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Boolean]$show_password = $false, # Passwords API defaults to $false

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/passwords/{0}' -f $id)

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords/{1}' -f $organization_id, $id)
    }

    if ($show_password) {
        $resource_uri = $resource_uri + ('?show_password=true') # using $True in PS results in 'True' (uppercase T), so explicitly writing out 'true' is needed
    }

    return Set-ITGlue -resource_uri $resource_uri -data $data
}

function Remove-ITGluePasswords {
    [CmdletBinding(DefaultParameterSetName = 'destroy')]
    Param (
        [Parameter(ParameterSetName = 'destroy')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_password_category_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_url = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_cached_resource_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy', Mandatory = $true)]
        $data
    )

    $resource_uri = ('/passwords/{0}' -f $id)

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if ($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $filter_list['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_password_category_id) {
            $filter_list['filter[password_category_id]'] = $filter_password_category_id
        }
        if ($filter_url) {
            $filter_list['filter[url]'] = $filter_url
        }
        if ($filter_cached_resource_name) {
            $filter_list['filter[cached_resource_name]'] = $filter_cached_resource_name
        }
    }

    return Remove-ITGlue -resource_uri $resource_uri -data $data -filter_list $filter_list
}
