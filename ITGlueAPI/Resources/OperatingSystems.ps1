function Get-ITGlueOperatingSystems {
<#
    .SYNOPSIS
        List or show all operating systems.

    .DESCRIPTION
        The Get-ITGlueOperatingSystems cmdlet returns a list of supported operating systems
        or the details of a defined operating system.

        This function can call the following endpoints:
            Index = /operating_systems

            Show =  /operating_systems/:id

    .PARAMETER filter_name
        Filter by operating system name

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
        Get an operating system by id

    .EXAMPLE
        Get-ITGlueOperatingSystems

        Returns the first 50 operating system results from your ITGlue account

    .EXAMPLE
        Get-ITGlueOperatingSystems -id 12345

        Returns the operating systems with the defined id

    .EXAMPLE
        Get-ITGlueOperatingSystems -page_number 2 -page_size 10

        Returns the first 10 results from the second page for operating systems
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#operating-systems-index

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

    $resource_uri = ('/operating_systems/{0}' -f $id)

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
