function New-ITGlueOrganizationTypes {
<#
    .SYNOPSIS
        Creates an organization type

    .DESCRIPTION
        The New-ITGlueOrganizationTypes cmdlet creates a new organization type
        in your account.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueOrganizationTypes -data $json_object

        Creates a new organization type with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#organization-types-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/organization_types/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueOrganizationTypes {
<#
    .SYNOPSIS
        List or show all organization types

    .DESCRIPTION
        The Get-ITGlueOrganizationTypes cmdlet returns a list of organization types
        or the details of a single organization type in your account.

        This function can call the following endpoints:
            Index = /organization_types

            Show =  /organization_types/:id

    .PARAMETER filter_name
        Filter by organization type name

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
        Get a organization type by id

    .EXAMPLE
        Get-ITGlueOrganizationTypes

        Returns the first 50 organization type results from your ITGlue account

    .EXAMPLE
        Get-ITGlueOrganizationTypes -id 12345

        Returns the organization type with the defined id

    .EXAMPLE
        Get-ITGlueOrganizationTypes -page_number 2 -page_size 10

        Returns the first 10 results from the second page for organization types
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#organization-types-index

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

    $resource_uri = ('/organization_types/{0}' -f $id)

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

function Set-ITGlueOrganizationTypes {
<#
    .SYNOPSIS
        Updates an organization type

    .DESCRIPTION
        The Set-ITGlueOrganizationTypes cmdlet updates an organization type
        in your account.

        Returns 422 Bad Request error if trying to update an externally synced record.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Update an organization type by id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueOrganizationTypes -id 8756309 -data $json_object

        Update the defined organization type with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#organization-types-update

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

    $resource_uri = ('/organization_types/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
