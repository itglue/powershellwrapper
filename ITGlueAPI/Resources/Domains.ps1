function Get-ITGlueDomains {
<#
    .SYNOPSIS
        List or show all domains

    .DESCRIPTION
        The Get-ITGlueDomains cmdlet list or show all domains in
        your account or from a specified organization

        This function can call the following endpoints:
            Index = /domains
                    /organizations/:org_id/relationships/domains

    .PARAMETER organization_id
        A valid organization Id in your Account

    .PARAMETER filter_id
        The domain id to filter for

    .PARAMETER filter_organization_id
        The organization id to filter for

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'created_at', 'updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER include
        Include specified assets

        Allowed values:
        'passwords', 'attachments', 'user_resource_accesses', 'group_resource_accesses'

    .EXAMPLE
        Get-ITGlueDomains

        Returns the first 50 results from your ITGlue account

    .EXAMPLE
        Get-ITGlueDomains -organization_id 12345

        Returns the domains from the defined organization id

    .EXAMPLE
        Get-ITGlueDomains -page_number 2 -page_size 10

        Returns the first 10 results from the second page for domains
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#domains-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_id = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet('created_at', 'updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet('passwords', 'attachments', 'user_resource_accesses', 'group_resource_accesses')]
        [String]$include = ''
    )

    $resource_uri = '/domains'
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/domains' -f $organization_id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
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
