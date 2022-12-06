function New-ITGlueFlexibleAssets {
    [CmdletBinding(DefaultParameterSetName = 'create')]
    Param (
        [Parameter(ParameterSetName = 'create', Mandatory = $true)]
        [Parameter(ParameterSetName = 'bulk_create', Mandatory = $true)]
        $data,

        [Parameter(ParameterSetName = 'bulk_create', Mandatory = $true)]
        [Int64]$organization_id
    )

    $resource_uri = '/flexible_assets/'

    if ($PSCmdlet.ParameterSetName -eq 'bulk_create') {
        $resource_uri = '/organizations/{0}/relationships/flexible_assets' -f $organization_id
    }

    return New-ITGlue -resource_uri $resource_uri -data $data
}

function Get-ITGlueFlexibleAssets {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_flexible_asset_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'created_at', 'updated_at', `
                '-name', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [String]$include = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/flexible_assets/{0}' -f $id)

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_flexible_asset_type_id) {
            $filter_list['filter[flexible_asset_type_id]'] = $filter_flexible_asset_type_id
        }
        if ($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $filter_list['filter[organization_id]'] = $filter_organization_id
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

    if ($include) {
        $filter_list['include'] = $include
    }

    return Get-ITGlue -resource_uri $resource_uri -filter_list $filter_list
}

function Set-ITGlueFlexibleAssets {
    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/flexible_assets/{0}' -f $id)

    return Set-ITGlue -resource_uri $resource_uri -data $data
}

function Remove-ITGlueFlexibleAssets {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$id
    )

    $resource_uri = ('/flexible_assets/{0}' -f $id)

    if ($pscmdlet.ShouldProcess($id)) {
        return Remove-ITGlue -resource_uri $resource_uri -data $data
    }
}
