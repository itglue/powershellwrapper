function Get-ITGluePlatforms {
<#
    .SYNOPSIS
        List or show all platforms.

    .DESCRIPTION
        The Get-ITGluePlatforms cmdlet returns a list of supported platforms
        or the details of a single platform from your account.

        This function can call the following endpoints:
            Index = /platforms

            Show =  /platforms/:id

    .PARAMETER filter_name
        Filter by platform name

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
        Get a platform by id

    .EXAMPLE
        Get-ITGluePlatforms

        Returns the first 50 platform results from your ITGlue account

    .EXAMPLE
        Get-ITGluePlatforms -id 12345

        Returns the platform with the defined id

    .EXAMPLE
        Get-ITGluePlatforms -page_number 2 -page_size 10

        Returns the first 10 results from the second page for platforms
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#platforms-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>


    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

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

    $resource_uri = ('/platforms/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
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
