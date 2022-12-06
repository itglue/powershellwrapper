function New-ITGlueFlexibleAssetTypes {
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/flexible_asset_types/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}
function Get-ITGlueFlexibleAssetTypes {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_icon = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Boolean]]$filter_enabled = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'id', 'created_at', 'updated_at', `
                '-name', '-id', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$include = '',

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/flexible_asset_types/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_icon) {
            $query_params['filter[icon]'] = $filter_icon
        }
        if ($filter_enabled -eq $true) {
            # PS $true returns "True" in string form (uppercase) and ITG's API is case-sensitive, so being explicit
            $query_params['filter[enabled]'] = "1"
        }
        elseif ($filter_enabled -eq $false) {
            $query_params['filter[enabled]'] = "0"
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

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params
}

function Set-ITGlueFlexibleAssetTypes {
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/flexible_asset_types/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
