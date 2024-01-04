function Get-ITGlueCountries {
<#
    .SYNOPSIS
        Returns a list of supported countries.

    .DESCRIPTION
        The Get-ITGlueCountries cmdlet returns a list of supported countries
        as well or details of one of the supported countries.

        This function can call the following endpoints:
            Index = /countries

            Show =  /countries/:id

    .PARAMETER filter_name
        Filter by country name

    .PARAMETER filter_iso
        Filter by country iso abbreviation

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
        Get a country by id

    .EXAMPLE
        Get-ITGlueCountries

        Returns the first 50 results from your ITGlue account

    .EXAMPLE
        Get-ITGlueCountries -id 12345

        Returns the country details with the defined id

    .EXAMPLE
        Get-ITGlueCountries -page_number 2 -page_size 10

        Returns the first 10 results from the second page for countries
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#countries-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = "index")]
    Param (
        [Parameter(ParameterSetName = "index")]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = "index")]
        [String]$filter_iso = '',

        [Parameter(ParameterSetName = "index")]
        [ValidateSet( 'name', 'id', 'created_at', 'updated_at', `
                '-name', '-id', '-created_at', '-updated_at')]
        [String]$sort = "",

        [Parameter(ParameterSetName = "index")]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = "index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = "show")]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'show')]
        [Parameter(ParameterSetName = 'index')]
        [Switch]$all
    )

    $resource_uri = ('/countries/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq "index") {
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_iso) {
            $query_params['filter[iso]'] = $filter_iso
        }
        if ($sort) {
            $query_params['sort'] = $sort
        }
        if ($page_number) {
            $query_params["page[number]"] = $page_number
        }
        if ($page_size) {
            $query_params["page[size]"] = $page_size
        }
    }

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params -AllResults:$all
}
