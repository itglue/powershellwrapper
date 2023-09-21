function New-ITGlueContacts {
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/contacts'

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts' -f $organization_id)
    }

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}

function Get-ITGlueContacts {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_last_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_title = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Boolean]]$filter_important = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_primary_email = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa', Mandatory = $true)]
        [ValidateSet('manage', 'autotask', 'tigerpaw', 'kaseya-bms', 'pulseway-psa', 'vorex')]
        [String]$filter_psa_integration_type = '',

        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_psa_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [ValidateSet( 'first_name', 'last_name', 'id', 'created_at', 'updated_at', `
                '-first_name', '-last_name', '-id', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'show')]
        $include = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'show')]
        [Switch]$all
    )

    $resource_uri = ('/contacts/{0}' -f $id)
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $organization_id) + $resource_uri
    }

    $query_params = @{}

    if (($PSCmdlet.ParameterSetName -eq 'index') -or ($PSCmdlet.ParameterSetName -eq 'index_psa')) {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_first_name) {
            $query_params['filter[first_name]'] = $filter_first_name
        }
        if ($filter_last_name) {
            $query_params['filter[last_name]'] = $filter_last_name
        }
        if ($filter_title) {
            $query_params['filter[title]'] = $filter_title
        }
        if ($filter_contact_type_id) {
            $query_params['filter[contact_type_id]'] = $filter_contact_type_id
        }
        if ($filter_important -eq $true) {
            $query_params['filter[important]'] = '1'
        }
        elseif ($filter_important -eq $false) {
            $query_params['filter[important]'] = '0'
        }
        if ($filter_primary_email) {
            $query_params['filter[primary_email]'] = $filter_primary_email
        }
        if ($filter_psa_integration_type) {
            $query_params['filter[psa_integration_type]'] = $filter_psa_integration_type
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
    if ($PSCmdlet.ParameterSetName -eq 'index_psa') {
        $query_params['filter[psa_id]'] = $filter_psa_id
    }

    if($include) {
        $query_params += @{'include' = $include}
    }

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params -AllResults:$all
}

function Set-ITGlueContacts {
    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_last_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_title = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Boolean]]$filter_important = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_primary_email = '',

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data

    )

    $resource_uri = ('/contacts/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts/{1}' -f $organization_id, $id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_update') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_first_name) {
            $query_params['filter[first_name]'] = $filter_first_name
        }
        if ($filter_last_name) {
            $query_params['filter[last_name]'] = $filter_last_name
        }
        if ($filter_title) {
            $query_params['filter[title]'] = $filter_title
        }
        if ($filter_contact_type_id) {
            $query_params['filter[contact_type_id]'] = $filter_contact_type_id
        }
        if ($filter_important -eq $true) {
            $query_params['filter[important]'] = '1'
        }
        elseif ($filter_import -eq $false) {
            $query_params['filter[important]'] = '0'
        }
        if ($filter_primary_email) {
            $query_params['filter[primary_email]'] = $filter_primary_email
        }
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}

function Remove-ITGlueContacts {
    [CmdletBinding(DefaultParameterSetName = 'bulk_destroy')]
    Param (
        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_last_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_title = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Boolean]]$filter_important = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_primary_email = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/contacts/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts/{1}' -f $organization_id, $id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_first_name) {
            $query_params['filter[first_name]'] = $filter_first_name
        }
        if ($filter_last_name) {
            $query_params['filter[last_name]'] = $filter_last_name
        }
        if ($filter_title) {
            $query_params['filter[title]'] = $filter_title
        }
        if ($filter_contact_type_id) {
            $query_params['filter[contact_type_id]'] = $filter_contact_type_id
        }
        if ($filter_important -eq $true) {
            $query_params['filter[important]'] = '1'
        }
        elseif ($filter_important -eq $false) {
            $query_params['filter[important]'] = '0'
        }
        if ($filter_primary_email) {
            $query_params['filter[primary_email]'] = $filter_primary_email
        }
    }

    return Invoke-ITGlueRequest -Method DELETE -RequestURI $resource_uri -Data $data -QueryParams $query_params
}
