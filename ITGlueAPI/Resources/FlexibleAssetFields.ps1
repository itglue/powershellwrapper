function New-ITGlueFlexibleAssetFields {
<#
    .SYNOPSIS
        Creates one or more flexible asset fields

    .DESCRIPTION
        The New-ITGlueFlexibleAssetFields cmdlet creates one or more
        flexible asset field for a particular flexible asset type.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER flexible_asset_type_id
        The flexible asset type id to create a new field in

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueFlexibleAssetFields -flexible_asset_type_id 8756309 -data $json_object

        Creates a new flexible asset field for the defined id with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-asset-fields-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
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
<#
    .SYNOPSIS
        List or show all flexible assets fields

    .DESCRIPTION
        The Get-ITGlueFlexibleAssetFields cmdlet lists or shows all flexible asset fields
        for a particular flexible asset type.

        This function can call the following endpoints:
            Index = /flexible_asset_types/:fat_id/relationships/flexible_asset_fields

            Show =  /flexible_asset_fields/:id
                    /flexible_asset_types/:id/relationships/flexible_asset_fields/:id

    .PARAMETER flexible_asset_type_id
        A valid Flexible asset Id in your Account

    .PARAMETER filter_id
        Filter by a flexible asset field id

    .PARAMETER filter_name
        Filter by a flexible asset field name

    .PARAMETER filter_icon
        Filter by a flexible asset field icon

    .PARAMETER filter_enabled
        Filter if a flexible asset is enabled

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'created_at', 'updated_at', `
        '-created_at', '-updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        A valid Flexible asset type Id in your Account

    .EXAMPLE
        Get-ITGlueFlexibleAssetFields -flexible_asset_type_id 12345

        Returns all the fields in a flexible asset with the defined id

    .EXAMPLE
        Get-ITGlueFlexibleAssetFields -id 12345

        Returns single field in a flexible asset with the defined id

    .EXAMPLE
        Get-ITGlueFlexibleAssetFields -flexible_asset_type_id 12345 -page_number 2 -page_size 10

        Returns the first 10 results from the second page for flexible asset fields
        from the defined id.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-asset-fields-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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
<#
    .SYNOPSIS
        Updates one or more flexible asset fields

    .DESCRIPTION
        The Set-ITGlueFlexibleAssetFields cmdlet updates the details of one
        or more existing flexible asset fields

        Any attributes you don't specify will remain unchanged.

        Can also be used to bulk update flexible asset fields

        Returns 422 error if trying to change the kind attribute of fields that
        are already in use.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER flexible_asset_type_id
        A valid Flexible asset Id in your Account

    .PARAMETER id
        Id of a flexible asset field

    .PARAMETER filter_id
        Filter by a flexible asset field id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueFlexibleAssetFields -id 8756309 -data $json_object

        Updates a defined flexible asset field with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-asset-fields-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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
<#
    .SYNOPSIS
        Delete a flexible asset field.

    .DESCRIPTION
        The Remove-ITGlueFlexibleAssetFields cmdlet deletes a flexible asset field.

        Note that this action will cause data loss if the field is already in use.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer


    .PARAMETER id
        Id of a flexible asset field

    .PARAMETER flexible_asset_type_id
        A valid Flexible asset Id in your Account

    .EXAMPLE
        Remove-ITGlueFlexibleAssetFields -id 8756309

        Deletes a defined flexible asset field and any data associated to that
        field.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-asset-fields-destroy

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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
