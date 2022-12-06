function New-ITGlueLocations {
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$org_id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/organizations/{0}/relationships/locations/' -f $org_id)

    return New-ITGlue -resource_uri $resource_uri -data $data
}
function Get-ITGlueLocations {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$org_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$filter_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_city = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$filter_region_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$filter_country_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa', Mandatory = $true)]
        [ValidateSet('manage', 'autotask', 'tigerpaw', 'kaseya-bms', 'pulseway-psa', 'vorex')]
        [String]$filter_psa_integration_type = '',

        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_psa_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [ValidateSet( 'name', 'id', 'created_at', 'updated_at', `
                '-name', '-id', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[int64]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'show')]
        [String]$include = ''
    )

    $resource_uri = ('/locations/{0}' -f $id)
    if ($org_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $org_id) + $resource_uri
    }

    $filter_list = @{}

    if (($PSCmdlet.ParameterSetName -eq 'index') -or ($PSCmdlet.ParameterSetName -eq 'index_psa')) {
        if ($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if ($filter_city) {
            $filter_list['filter[city]'] = $filter_city
        }
        if ($filter_region_id) {
            $filter_list['filter[region_id]'] = $filter_region_id
        }
        if ($filter_country_id) {
            $filter_list['filter[country_id]'] = $filter_country_id
        }
        if ($filter_psa_integration_type) {
            $filter_list['filter[psa_integration_type]'] = $filter_psa_integration_type
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
    if ($PSCmdlet.ParameterSetName -eq 'index_psa') {
        $filter_list['filter[psa_id]'] = $filter_psa_id
    }

    if($include) {
        $filter_list['include'] = $include
    }


    return Get-ITGlue -resource_uri $resource_uri -filter_list $filter_list
}

function Set-ITGlueLocations {
    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$org_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_city = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_region_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_country_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/locations/{0}' -f $id)

    if ($org_id) {
        $resource_uri = ('organizations/{0}/relationships/locations/{1}' -f $org_id, $id)
    }

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_update') {
        if($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if($filter_city) {
            $filter_list['filter[city]'] = $filter_city
        }
        if($filter_region_id) {
            $filter_list['filter[region_id]'] = $filter_region_id
        }
        if($filter_country_id) {
            $filter_list['filter[country_id]'] = $filter_country_id
        }
    }

    return Set-ITGlue -resource_uri $resource_uri -data $data -filter_list $filter_list
}

function Remove-ITGlueLocations {
    [CmdletBinding(DefaultParameterSetName = 'bulk_destroy')]
    Param (
        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_city = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_region_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_country_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/locations/')

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if($filter_city) {
            $filter_list['filter[city]'] = $filter_city
        }
        if($filter_region_id) {
            $filter_list['filter[region_id]'] = $filter_region_id
        }
        if($filter_country_id) {
            $filter_list['filter[country_id]'] = $filter_country_id
        }
    }

    return Remove-ITGlue -resource_uri $resource_uri -data $data -filter_list $filter_list
}
