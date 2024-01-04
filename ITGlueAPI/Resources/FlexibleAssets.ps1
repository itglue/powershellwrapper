function New-ITGlueFlexibleAssets {
<#
    .SYNOPSIS
        Creates one or more flexible assets

    .DESCRIPTION
        The New-ITGlueFlexibleAssets cmdlet creates one or more
        flexible assets

        If there are any required fields in the flexible asset type,
        they will need to be included in the request.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER organization_id
        The organization id to create the flexible asset in

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueFlexibleAssets -organization_id 8756309 -data $json_object

        Creates a new flexible asset in the defined organization with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-assets-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueFlexibleAssets {
<#
    .SYNOPSIS
        List or show all flexible assets

    .DESCRIPTION
        The Get-ITGlueFlexibleAssets cmdlet returns a list of flexible assets or
        the details of a single flexible assets based on the unique ID of the
        flexible asset type.

        This function can call the following endpoints:
            Index = /flexible_assets

            Show =  /flexible_assets/:id

    .PARAMETER filter_flexible_asset_type_id
        Filter by a flexible asset id

        This is the flexible assets id number you see in the URL under an organizations

    .PARAMETER filter_name
        Filter by a flexible asset name

    .PARAMETER filter_organization_id
        Filter by a organization id

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'name', 'created_at', 'updated_at', `
        '-name', '-created_at', '-updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER include
        Include specified assets

        Allowed values (Index):
        'adapters_resources', 'distinct_remote_assets', 'attachments', 'passwords',
        'user_resource_accesses', 'group_resource_accesses'

        Allowed values (Show):
        'adapters_resources', 'distinct_remote_assets', 'attachments', 'passwords',
        'user_resource_accesses', 'group_resource_accesses', 'recent_versions', 'related_items',
        'authorized_users'

    .PARAMETER id
        Get a flexible asset id

    .EXAMPLE
        Get-ITGlueFlexibleAssets -filter_flexible_asset_type_id 8765309

        Returns the first 50 results for the defined flexible asset.

    .EXAMPLE
        Get-ITGlueFlexibleAssets -filter_flexible_asset_type_id 8765309 -page_number 2 -page_size 10

        Returns the first 10 results from the second page for the defined
        flexible asset.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-assets-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'show')]
        [Parameter(ParameterSetName = 'index')]
        [Switch]$all
    )

    $resource_uri = ('/flexible_assets/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_flexible_asset_type_id) {
            $query_params['filter[flexible_asset_type_id]'] = $filter_flexible_asset_type_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
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

    if ($include) {
        $query_params['include'] = $include
    }

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params -AllResults:$all
}



function Set-ITGlueFlexibleAssets {
<#
    .SYNOPSIS
        Updates one or more flexible assets

    .DESCRIPTION
        The Set-ITGlueFlexibleAssets cmdlet updates one or more flexible assets

        Any traits you don't specify will be deleted.
        Passing a null value will also delete a trait's value.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        The flexible asset id to update

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueFlexibleAssets -id 8756309 -data $json_object

        Updates a defined flexible asset with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-assets-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}



function Remove-ITGlueFlexibleAssets {
<#
    .SYNOPSIS
        Deletes one or more a flexible assets

    .DESCRIPTION
        The Remove-ITGlueFlexibleAssets cmdlet destroys multiple or a single
        flexible asset.

    .PARAMETER id
        The flexible asset id to update

    .EXAMPLE
        Remove-ITGlueFlexibleAssets -id 8756309

        Deletes the defined flexible asset

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-assets-destroy

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$id
    )

    $resource_uri = ('/flexible_assets/{0}' -f $id)

    if ($pscmdlet.ShouldProcess($id)) {
        return Invoke-ITGlueRequest -Method DELETE -ResourceURI $resource_uri
    }

}
