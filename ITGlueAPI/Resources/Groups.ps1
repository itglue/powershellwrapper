function Get-ITGlueGroups {
<#
    .SYNOPSIS
        List or show all groups

    .DESCRIPTION
        The Get-ITGlueGroups cmdlet returns a list of groups or the
        details of a single group in your account.

        This function can call the following endpoints:
            Index = /groups

            Show =  /groups/:id

    .PARAMETER filter_name
        Filter by a group name

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'name', 'created_at', 'updated_at', `
        '-name', '-created_at', '-updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        Get a group by id

    .EXAMPLE
        Get-ITGlueGroups

        Returns the first 50 group results from your ITGlue account

    .EXAMPLE
        Get-ITGlueGroups -id 12345

        Returns the group with the defined id

    .EXAMPLE
        Get-ITGlueGroups -page_number 2 -page_size 10

        Returns the first 10 results from the second page for groups
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#groups-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'created_at', 'updated_at', `
                '-name', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/groups/{0}' -f $id)

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

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params
}
