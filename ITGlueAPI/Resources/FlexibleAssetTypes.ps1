function New-ITGlueFlexibleAssetTypes {
<#
    .SYNOPSIS
        Creates one or more flexible asset types

    .DESCRIPTION
        The New-ITGlueFlexibleAssetTypes cmdlet creates one or
        more flexible asset types

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueFlexibleAssetTypes -data $json_object

        Creates a new flexible asset type with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-asset-types-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/flexible_asset_types/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueFlexibleAssetTypes {
<#
    .SYNOPSIS
        List or show all flexible asset types

    .DESCRIPTION
        The Get-ITGlueFlexibleAssetTypes cmdlet returns details on a flexible asset type
        or a list of flexible asset types in your account.

        This function can call the following endpoints:
            Index = /flexible_asset_types

            Show =  /flexible_asset_types/:id

    .PARAMETER filter_name
        Filter by a flexible asset name

    .PARAMETER filter_icon
        Filter by a flexible asset icon

    .PARAMETER filter_enabled
        Filter if a flexible asset is enabled

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'name', 'id', 'created_at', 'updated_at', `
        '-name', '-id', '-created_at', '-updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER include
        Include specified assets

        Allowed values:
        'flexible_asset_fields'

    .PARAMETER id
        A valid flexible asset id in your account

    .EXAMPLE
        Get-ITGlueFlexibleAssetTypes

        Returns the first 50 flexible asset results from your ITGlue account

    .EXAMPLE
        Get-ITGlueFlexibleAssetTypes -id 12345

        Returns the defined flexible asset with the defined id

    .EXAMPLE
        Get-ITGlueFlexibleAssetTypes -page_number 2 -page_size 10

        Returns the first 10 results from the second page for flexible assets
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-asset-types-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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
<#
    .SYNOPSIS
        Updates a flexible asset type

    .DESCRIPTION
        The Set-ITGlueFlexibleAssetTypes cmdlet updates the details of an
        existing flexible asset type in your account.

        Any attributes you don't specify will remain unchanged.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        A valid flexible asset id in your account

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueFlexibleAssetTypes -id 8765309 -data $json_object

        Update a flexible asset type with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#flexible-asset-types-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/flexible_asset_types/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
