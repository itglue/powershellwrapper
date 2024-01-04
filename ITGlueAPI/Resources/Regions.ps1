function Get-ITGlueRegions {
<#
    .SYNOPSIS
        List or show all regions

    .DESCRIPTION
        The Get-ITGlueRegions cmdlet returns a list of supported regions
        or the details of a single support region.

        This function can call the following endpoints:
            Index = /regions
                    /countries/:id/relationships/regions

            Show =  /regions/:id
                    /countries/:id/relationships/regions/:id

    .PARAMETER country_id
        Get regions by country id

    .PARAMETER filter_name
        Filter by region name

    .PARAMETER filter_iso
        Filter by region iso abbreviation

    .PARAMETER filter_country_id
        Filter by country id

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
        Get a region by id

    .EXAMPLE
        Get-ITGlueRegions

        Returns the first 50 region results from your ITGlue account

    .EXAMPLE
        Get-ITGlueRegions -id 12345

        Returns the region with the defined id

    .EXAMPLE
        Get-ITGlueRegions -page_number 2 -page_size 10

        Returns the first 10 results from the second page for regions
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#regions-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$country_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_iso = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int]]$filter_country_id = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'id', 'created_at', 'updated_at', `
                '-name', '-id', '-created_at', '-updated_at')]
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

    $resource_uri = ('/regions/{0}' -f $id)
    if ($country_id) {
        $resource_uri = ('/countries/{0}/relationships' -f $country_id) + $resource_uri
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_iso) {
            $query_params['filter[iso]'] = $filter_iso
        }
        if ($filter_country_id) {
            $query_params['filter[country_id]'] = $filter_country_id
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
