function Get-ITGlueExpirations {
<#
    .SYNOPSIS
        List or show all expirations

    .DESCRIPTION
        The Get-ITGlueExpirations cmdlet returns a list of expirations
        for all organizations or for a specified organization.

        This function can call the following endpoints:
            Index = /expirations
                    /organizations/:organization_id/relationships/expirations

            Show =  /expirations/:id
                    /organizations/:organization_id/relationships/expirations/:id

    .PARAMETER organization_id
        A valid organization Id in your account

    .PARAMETER filter_id
        Filter by expiration id

    .PARAMETER filter_resource_id
        Filter by a resource id

    .PARAMETER filter_resource_name
        Filter by a resource name

    .PARAMETER filter_resource_type_name
        Filter by a resource type name

    .PARAMETER filter_description
        Filter expiration description

    .PARAMETER filter_expiration_date
        Filter expiration date

    .PARAMETER filter_organization_id
        Filter by organization name

    .PARAMETER filter_range
        Filter by expiration range

        To filter on a specific range, supply two comma-separated values
        Example:
            “2, 10” is filtering for all that are greater than or equal to 2
            and less than or equal to 10

        Or, an asterisk ( * ) can filter on values either greater than or equal to
            Example:
                “2, *”, or less than or equal to (“*, 10”)

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'id', 'organization_id', 'expiration_date', 'created_at', 'updated_at', `
        '-id', '-organization_id', '-expiration_date', '-created_at', '-updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        A valid organization Id in your account

    .EXAMPLE
        Get-ITGlueExpirations

        Returns the first 50 results from your ITGlue account

    .EXAMPLE
        Get-ITGlueExpirations -id 12345

        Returns the expiration with the defined id

    .EXAMPLE
        Get-ITGlueExpirations -page_number 2 -page_size 10

        Returns the first 10 results from the second page for expirations
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#expirations-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_resource_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_resource_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_resource_type_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_description = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_expiration_date = '',

        [Parameter(ParameterSetName = 'index')]
        [Int64]$filter_organization_id = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_range = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'id', 'organization_id', 'expiration_date', 'created_at', 'updated_at', `
                '-id', '-organization_id', '-expiration_date', '-created_at', '-updated_at')]
        [String]$sort,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(Mandatory = $true, ParameterSetName = 'show')]
        [Nullable[Int64]]$id,

        [Parameter(ParameterSetName = 'show')]
        [Parameter(ParameterSetName = 'index')]
        [Switch]$all
    )

    $resource_uri = ('/expirations/{0}' -f $id)
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $organization_id) + $resource_uri
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_resource_id) {
            $query_params['filter[resource_id]'] = $filter_resource_id
        }
        if ($filter_resource_name) {
            $query_params['filter[resource_name]'] = $filter_resource_name
        }
        if ($filter_resource_type_name) {
            $query_params['filter[resource_type_name]'] = $filter_resource_type_name
        }
        if ($filter_description) {
            $query_params['filter[description]'] = $filter_description
        }
        if ($filter_expiration_date) {
            $query_params['filter[expiration_date]'] = $filter_expiration_date
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_range) {
            $query_params['filter[range]'] = $filter_range
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
