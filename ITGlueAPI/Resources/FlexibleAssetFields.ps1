function New-ITGlueFlexibleAssetFields {
    Param (
        [Nullable[Int64]]$flexible_asset_type_id = $null,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/flexible_asset_fields/'

    if ($flexible_asset_type_id) {
        $resource_uri = ('/flexible_asset_types/{0}/relationships/flexible_asset_fields' -f $flexible_asset_type_id)
    }

    return Invoke-ITGlueRequest -Method POST -RequestURI $resource_uri -Data $data
}

function Get-ITGlueFlexibleAssetFields {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$flexible_asset_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_icon = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[bool]]$filter_enabled = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'created_at', 'updated_at', `
                '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/flexible_asset_fields/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/flexible_asset_types/{0}/relationships/flexible_asset_fields/{1}' -f $flexible_asset_type_id, $id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_icon) {
            $query_params['filter[icon]'] = $filter_icon
        }
        if ($null -ne $filter_enabled) {
            $query_params['filter[enabled]'] = $filter_enabled
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
    elseif ($null -eq $flexible_asset_type_id) {
        #Parameter set "Show" is selected and no flexible asset type id is specified; switch from nested relationships route
        $resource_uri = ('/flexible_asset_fields/{0}' -f $id)
    }

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params
}

function Set-ITGlueFlexibleAssetFields {
    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$flexible_asset_type_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/flexible_asset_fields/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/flexible_asset_types/{0}/relationships/flexible_asset_fields/{1}' -f $flexible_asset_type_id, $id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_update') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}

function Remove-ITGlueFlexibleAssetFields {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$id,

        [Nullable[Int64]]$flexible_asset_type_id = $null
    )

    $resource_uri = ('/flexible_asset_fields/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/flexible_asset_types/{0}/relationships/flexible_asset_fields/{1}' -f $flexible_asset_type_id, $id)
    }

    if ($pscmdlet.ShouldProcess($id)) {
        return Invoke-ITGlueRequest -Method DELETE -ResourceURI $resource_uri
    }
}
