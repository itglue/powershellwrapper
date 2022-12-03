function New-ITGlueOrganizationStatuses {
<#
    .SYNOPSIS
        Create an organization status.

    .DESCRIPTION
        The New-ITGlueOrganizationStatuses cmdlet creates a new organization
        status in your account

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueOrganizationStatuses -data $json_object

        Creates a new organization status with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#organization-statuses-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/organization_statuses/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueOrganizationStatuses {
<#
    .SYNOPSIS
        List or show all organization statuses

    .DESCRIPTION
        The Get-ITGlueOrganizationStatuses cmdlet returns a list of organization
        statuses or the details of a single organization status in your account.

        This function can call the following endpoints:
            Index = /organization_statuses

            Show =  /organization_statuses/:id

    .PARAMETER filter_name
        Filter by organization status name

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
        Get an organization status by id

    .EXAMPLE
        Get-ITGlueOrganizationStatuses

        Returns the first 50 organization statuses results from your ITGlue account

    .EXAMPLE
        Get-ITGlueOrganizationStatuses -id 12345

        Returns the organization statuses with the defined id

    .EXAMPLE
        Get-ITGlueOrganizationStatuses -page_number 2 -page_size 10

        Returns the first 10 results from the second page for organization statuses
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#organization-statuses-index

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
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/organization_statuses/{0}' -f $id)

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



function Set-ITGlueOrganizationStatuses {
<#
    .SYNOPSIS
        Updates an organization status

    .DESCRIPTION
        The Set-ITGlueOrganizationStatuses cmdlet updates an organization status
        in your account.

        Returns 422 Bad Request error if trying to update an externally synced record.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Update an organization status by id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueOrganizationStatuses -id 8756309 -data $json_object

        Using the defined body this creates an attachment to a password with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#organization-statuses-update

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

    $resource_uri = ('/organization_statuses/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
