function New-ITGlueOrganizations {
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/organizations/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}

function Get-ITGlueOrganizations {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_status_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_created_at = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_updated_at = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_my_glue_account_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_group_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_exclude_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_exclude_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_exclude_organization_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_exclude_organization_status_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_range = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_range_my_glue_account_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'id', 'updated_at', 'organization_status_name', 'organization_type_name', 'created_at', 'short_name', 'my_glue_account_id',`
                '-name', '-id', '-updated_at', '-organization_status_name', '-organization_type_name', '-created_at', '-short_name', '-my_glue_account_id')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null,
        
        [Parameter(ParameterSetName = 'show')]
        [Parameter(ParameterSetName = 'index')]
        [Switch]$all
    )

    $resource_uri = ('/organizations/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_organization_type_id) {
            $query_params['filter[organization_type_id]'] = $filter_organization_type_id
        }
        if ($filter_organization_status_id) {
            $query_params['filter[organization_status_id]'] = $filter_organization_status_id
        }
        if ($filter_created_at) {
            $query_params['filter[created_at]'] = $filter_created_at
        }
        if ($filter_updated_at) {
            $query_params['filter[updated_at]'] = $filter_updated_at
        }
        if ($filter_my_glue_account_id) {
            $query_params['filter[my_glue_account_id]'] = $filter_my_glue_account_id
        }
        if ($filter_group_id) {
            $query_params['filter[group_id]'] = $filter_group_id
        }
        if ($filter_exclude_id) {
            $query_params['filter[exclude][id]'] = $filter_exclude_id
        }
        if ($filter_exclude_name) {
            $query_params['filter[exclude][name]'] = $filter_exclude_name
        }
        if ($filter_exclude_organization_type_id) {
            $query_params['filter[exclude][organization_type_id]'] = $filter_exclude_organization_type_id
        }
        if ($filter_exclude_organization_type_id) {
            $query_params['filter[exclude][organization_status_id]'] = $filter_exclude_organization_status_id
        }
        if ($filter_range) {
            $query_params['filter[range]'] = $filter_range
        }
        if ($filter_range_my_glue_account_id) {
            $query_params['filter[range][my_glue_account_id]'] = $filter_range_my_glue_account_id
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

function Set-ITGlueOrganizations {
    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_organization_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_organization_status_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_created_at = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_updated_at = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_my_glue_account_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_exclude_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_exclude_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_exclude_organization_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_exclude_organization_status_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data

    )

    $resource_uri = ('/organizations/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_update') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if($filter_organization_type_id) {
            $query_params['filter[organization_type_id]'] = $filter_organization_type_id
        }
        if($filter_organization_status_id) {
            $query_params['filter[organization_status_id]'] = $filter_organization_status_id
        }
        if($filter_created_at) {
            $query_params['filter[created_at]'] = $filter_created_at
        }
        if($filter_updated_at) {
            $query_params['filter[updated_at]'] = $filter_updated_at
        }
        if($filter_my_glue_account_id) {
            $query_params['filter[my_glue_account_id]'] = $filter_my_glue_account_id
        }
        if($filter_exclude_id) {
            $query_params['filter[exclude][id]'] = $filter_exclude_id
        }
        if($filter_exclude_name) {
            $query_params['filter[exclude][name]'] = $filter_exclude_name
        }
        if($filter_exclude_organization_type_id) {
            $query_params['filter[exclude][organization_type_id]'] = $filter_exclude_organization_type_id
        }
        if($filter_exclude_organization_status_id) {
            $query_params['filter[exclude][organization_status_id]'] = $filter_exclude_organization_status_id
        }
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}

function Remove-ITGlueOrganizations {
    [CmdletBinding(DefaultParameterSetName = 'bulk_destroy')]
    Param (
        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_organization_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_organization_status_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_created_at = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_updated_at = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_my_glue_account_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_exclude_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_exclude_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_exclude_organization_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_exclude_organization_status_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Parameter(Mandatory = $true)]
        $data

    )

    $resource_uri = ('/organizations/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if($filter_organization_type_id) {
            $query_params['filter[organization_type_id]'] = $filter_organization_type_id
        }
        if($filter_organization_status_id) {
            $query_params['filter[organization_status_id]'] = $filter_organization_status_id
        }
        if($filter_created_at) {
            $query_params['filter[created_at]'] = $filter_created_at
        }
        if($filter_updated_at) {
            $query_params['filter[updated_at]'] = $filter_updated_at
        }
        if($filter_my_glue_account_id) {
            $query_params['filter[my_glue_account_id]'] = $filter_my_glue_account_id
        }
        if($filter_exclude_id) {
            $query_params['filter[exclude][id]'] = $filter_exclude_id
        }
        if($filter_exclude_name) {
            $query_params['filter[exclude][name]'] = $filter_exclude_name
        }
        if($filter_exclude_organization_type_id) {
            $query_params['filter[exclude][organization_type_id]'] = $filter_exclude_organization_type_id
        }
        if($filter_exclude_organization_status_id) {
            $query_params['filter[exclude][organization_status_id]'] = $filter_exclude_organization_status_id
        }
    }

    return Invoke-ITGlueRequest -Method DELETE -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}
