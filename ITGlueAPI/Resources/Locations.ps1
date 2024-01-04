function New-ITGlueLocations {
<#
    .SYNOPSIS
        Creates one or more locations

    .DESCRIPTION
        The New-ITGlueLocations cmdlet creates one or more
        locations for specified organization.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER org_id
        The valid organization id in your account

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueLocations -org_id 8756309 -data $json_object

        Creates a new location under the defined organization with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#locations-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$org_id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/organizations/{0}/relationships/locations/' -f $org_id)

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueLocations {
<#
    .SYNOPSIS
        List or show all location

    .DESCRIPTION
        The Get-ITGlueLocations cmdlet returns a list of locations for
        all organizations or for a specified organization.

        This function can call the following endpoints:
            Index = /locations
                    /organizations/:org_id/relationships/locations

            Show =  /locations/:id
                    /organizations/:id/relationships/locations/:id

    .PARAMETER org_id
        The valid organization id in your account

    .PARAMETER filter_id
        Filter by a location id

    .PARAMETER filter_name
        Filter by a location name

    .PARAMETER filter_city
        Filter by a location city

    .PARAMETER filter_region_id
        Filter by a location region id

    .PARAMETER filter_country_id
        Filter by a location country id

    .PARAMETER filter_psa_integration_type
        Filter by a psa integration type

        Allowed values:
        'manage', 'autotask', 'tigerpaw', 'kaseya-bms', 'pulseway-psa', 'vorex'

    .PARAMETER filter_psa_id
        Filter by a psa integration id

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'name', 'id', 'created_at', 'updated_at', `
        '-name', '-id', '-created_at', '-updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        Get a location by id

    .PARAMETER include
        Include specified assets

        Allowed values(Index):
        'adapters_resources', 'attachments', 'passwords', 'user_resource_accesses',
        'group_resource_accesses'

        Allowed values(Show):
        'adapters_resources', 'attachments', 'passwords', 'user_resource_accesses',
        'group_resource_accesses', 'recent_versions', 'related_items', 'authorized_users'

    .EXAMPLE
        Get-ITGlueLocations

        Returns the first 50 location results from your ITGlue account

    .EXAMPLE
        Get-ITGlueLocations -id 12345

        Returns the location with the defined id

    .EXAMPLE
        Get-ITGlueLocations -page_number 2 -page_size 10

        Returns the first 10 results from the second page for locations
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#locations-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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
        [String]$include = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'show')]
        [Switch]$all
    )

    $resource_uri = ('/locations/{0}' -f $id)
    if ($org_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $org_id) + $resource_uri
    }

    $query_params = @{}

    if (($PSCmdlet.ParameterSetName -eq 'index') -or ($PSCmdlet.ParameterSetName -eq 'index_psa')) {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_city) {
            $query_params['filter[city]'] = $filter_city
        }
        if ($filter_region_id) {
            $query_params['filter[region_id]'] = $filter_region_id
        }
        if ($filter_country_id) {
            $query_params['filter[country_id]'] = $filter_country_id
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
        $query_params['include'] = $include
    }


    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params -AllResults:$all
}



function Set-ITGlueLocations {
<#
    .SYNOPSIS
        Updates one or more a locations

    .DESCRIPTION
        The Set-ITGlueLocations cmdlet updates the details of
        an existing location or locations.

        Any attributes you don't specify will remain unchanged.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Get a location by id

    .PARAMETER org_id
        The valid organization id in your account

    .PARAMETER filter_id
        Filter by a location id

    .PARAMETER filter_name
        Filter by a location name

    .PARAMETER filter_city
        Filter by a location city

    .PARAMETER filter_region_id
        Filter by a location region id

    .PARAMETER filter_country_id
        Filter by a location country id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueLocations -id 8765309 -data $json_object

        Updates the defined location with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#locations-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_update') {
        if($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if($filter_city) {
            $query_params['filter[city]'] = $filter_city
        }
        if($filter_region_id) {
            $query_params['filter[region_id]'] = $filter_region_id
        }
        if($filter_country_id) {
            $query_params['filter[country_id]'] = $filter_country_id
        }
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}



function Remove-ITGlueLocations {
<#
    .SYNOPSIS
        Deletes one or more locations

    .DESCRIPTION
        The Set-ITGlueLocations cmdlet deletes one or more
        specified locations

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER filter_id
        Filter by a location id

    .PARAMETER filter_name
        Filter by a location name

    .PARAMETER filter_city
        Filter by a location city

    .PARAMETER filter_region_id
        Filter by a location region id

    .PARAMETER filter_country_id
        Filter by a location country id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueLocations -id 8765309 -data $json_object

        Updates the defined location with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#locations-bulk-destroy

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if($filter_city) {
            $query_params['filter[city]'] = $filter_city
        }
        if($filter_region_id) {
            $query_params['filter[region_id]'] = $filter_region_id
        }
        if($filter_country_id) {
            $query_params['filter[country_id]'] = $filter_country_id
        }
    }

    return Invoke-ITGlueRequest -Method DELETE -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}
