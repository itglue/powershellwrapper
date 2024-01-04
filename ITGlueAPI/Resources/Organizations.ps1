function New-ITGlueOrganizations {
<#
    .SYNOPSIS
        Create an organization.

    .DESCRIPTION
        The New-ITGlueOrganizations cmdlet creates an organization.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueOrganizations -data $json_object

        Creates a new organization with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#organizations-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/organizations/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueOrganizations {
<#
    .SYNOPSIS
        List or show all organizations

    .DESCRIPTION
        The Get-ITGlueOrganizations cmdlet returns a list of organizations
        or details for a single organization in your account.

        This function can call the following endpoints:
            Index = /organizations

            Show =  /organizations/:id

    .PARAMETER filter_id
        Filter by an organization id

    .PARAMETER filter_name
        Filter by an organization name

    .PARAMETER filter_organization_type_id
        Filter by an organization type id

    .PARAMETER filter_organization_status_id
        Filter by an organization status id

    .PARAMETER filter_created_at
        Filter by when an organization created

    .PARAMETER filter_updated_at
        Filter by when an organization updated

    .PARAMETER filter_my_glue_account_id
        Filter by a MyGlue id

    .PARAMETER filter_group_id
        Filter by a group id

    .PARAMETER filter_exclude_id
        Filter to excluded a certain organization id

    .PARAMETER filter_exclude_name
        Filter to excluded a certain organization name

    .PARAMETER filter_exclude_organization_type_id
        Filter to excluded a certain organization type id

    .PARAMETER filter_exclude_organization_status_id
        Filter to excluded a certain organization status id

    .PARAMETER filter_range
        Filter organizations by range?

    .PARAMETER filter_range_my_glue_account_id
        Filter MyGLue organization id range?

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'name', 'id', 'updated_at', 'organization_status_name', 'organization_type_name',
        'created_at', 'short_name', 'my_glue_account_id', '-name', '-id', '-updated_at',
        '-organization_status_name', '-organization_type_name', '-created_at',
        '-short_name', '-my_glue_account_id'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        Get an organization by id

    .EXAMPLE
        Get-ITGlueOrganizations

        Returns the first 50 organizations results from your ITGlue account

    .EXAMPLE
        Get-ITGlueOrganizations -id 12345

        Returns the organization with the defined id

    .EXAMPLE
        Get-ITGlueOrganizations -page_number 2 -page_size 10

        Returns the first 10 results from the second page for organizations
        in your ITGlue account

    .NOTES
        As of 2022-12
            Need to figure out the "filter_range***" parameters
            Need to figure out the "filter_group_id" parameter

    .LINK
        https://api.itglue.com/developer/#organizations-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_status_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_created_at = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_updated_at = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_my_glue_account_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_group_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_exclude_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_exclude_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_exclude_organization_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_exclude_organization_status_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_range = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_range_my_glue_account_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'id', 'updated_at', 'organization_status_name', 'organization_type_name', 'created_at', 'short_name', 'my_glue_account_id',`
                '-name', '-id', '-updated_at', '-organization_status_name', '-organization_type_name', '-created_at', '-short_name', '-my_glue_account_id')]
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

    $resource_uri = ('/organizations/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_organization_type_id) {
            $query_params['filter[organization_type_id]'] = $filter_organization_type_id
        }
        if ($filter_organization_status_id) {
            $query_params['filter[organization_status_id]'] = $filter_organization_status_id
        }
        if ($filter_created_at) {
            $query_params['filter[created_at]'] = $filter_created_at
        }
        if ($filter_updated_at) {
            $query_params['filter[updated_at]'] = $filter_updated_at
        }
        if ($filter_my_glue_account_id) {
            $query_params['filter[my_glue_account_id]'] = $filter_my_glue_account_id
        }
        if ($filter_group_id) {
            $query_params['filter[group_id]'] = $filter_group_id
        }
        if ($filter_exclude_id) {
            $query_params['filter[exclude][id]'] = $filter_exclude_id
        }
        if ($filter_exclude_name) {
            $query_params['filter[exclude][name]'] = $filter_exclude_name
        }
        if ($filter_exclude_organization_type_id) {
            $query_params['filter[exclude][organization_type_id]'] = $filter_exclude_organization_type_id
        }
        if ($filter_exclude_organization_type_id) {
            $query_params['filter[exclude][organization_status_id]'] = $filter_exclude_organization_status_id
        }
        if ($filter_range) {
            $query_params['filter[range]'] = $filter_range
        }
        if ($filter_range_my_glue_account_id) {
            $query_params['filter[range][my_glue_account_id]'] = $filter_range_my_glue_account_id
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



function Set-ITGlueOrganizations {
<#
    .SYNOPSIS
        Updates one or more organizations

    .DESCRIPTION
        The Set-ITGlueOrganizations cmdlet updates the details of an
        existing organization or multiple organizations.

        Any attributes you don't specify will remain unchanged.

        Returns 422 Bad Request error if trying to update an externally synced record on
        attributes other than: alert, description, quick_notes

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Update an organization by id

    .PARAMETER filter_id
        Filter by an organization id

    .PARAMETER filter_name
        Filter by an organization name

    .PARAMETER filter_organization_type_id
        Filter by an organization type id

    .PARAMETER filter_organization_status_id
        Filter by an organization status id

    .PARAMETER filter_created_at
        Filter by when an organization created

    .PARAMETER filter_updated_at
        Filter by when an organization updated

    .PARAMETER filter_my_glue_account_id
        Filter by a MyGlue id

    .PARAMETER filter_exclude_id
        Filter to excluded a certain organization id

    .PARAMETER filter_exclude_name
        Filter to excluded a certain organization name

    .PARAMETER filter_exclude_organization_type_id
        Filter to excluded a certain organization type id

    .PARAMETER filter_exclude_organization_status_id
        Filter to excluded a certain organization status id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueOrganizations -id 8765309 -data $json_object

        Updates an organization with the structured JSON object.

    .EXAMPLE
        Set-ITGlueOrganizations -filter_organization_status_id 12345 -data $json_object

        Updates all defined organization with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#organizations-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_organization_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_organization_status_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_created_at = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_updated_at = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_my_glue_account_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_exclude_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_exclude_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_exclude_organization_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_exclude_organization_status_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data

    )

    $resource_uri = ('/organizations/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_update') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if($filter_organization_type_id) {
            $query_params['filter[organization_type_id]'] = $filter_organization_type_id
        }
        if($filter_organization_status_id) {
            $query_params['filter[organization_status_id]'] = $filter_organization_status_id
        }
        if($filter_created_at) {
            $query_params['filter[created_at]'] = $filter_created_at
        }
        if($filter_updated_at) {
            $query_params['filter[updated_at]'] = $filter_updated_at
        }
        if($filter_my_glue_account_id) {
            $query_params['filter[my_glue_account_id]'] = $filter_my_glue_account_id
        }
        if($filter_exclude_id) {
            $query_params['filter[exclude][id]'] = $filter_exclude_id
        }
        if($filter_exclude_name) {
            $query_params['filter[exclude][name]'] = $filter_exclude_name
        }
        if($filter_exclude_organization_type_id) {
            $query_params['filter[exclude][organization_type_id]'] = $filter_exclude_organization_type_id
        }
        if($filter_exclude_organization_status_id) {
            $query_params['filter[exclude][organization_status_id]'] = $filter_exclude_organization_status_id
        }
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}



function Remove-ITGlueOrganizations {
<#
    .SYNOPSIS
        Deletes one or more organizations

    .DESCRIPTION
        The Remove-ITGlueOrganizations cmdlet marks organizations identified by the
        specified organization IDs for deletion

        Because it can be a long procedure to delete organizations,
        removal from the system may not happen immediately.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER filter_id
        Filter by an organization id

    .PARAMETER filter_name
        Filter by an organization name

    .PARAMETER filter_organization_type_id
        Filter by an organization type id

    .PARAMETER filter_organization_status_id
        Filter by an organization status id

    .PARAMETER filter_created_at
        Filter by when an organization created

    .PARAMETER filter_updated_at
        Filter by when an organization updated

    .PARAMETER filter_my_glue_account_id
        Filter by a MyGlue id

    .PARAMETER filter_exclude_id
        Filter to excluded a certain organization id

    .PARAMETER filter_exclude_name
        Filter to excluded a certain organization name

    .PARAMETER filter_exclude_organization_type_id
        Filter to excluded a certain organization type id

    .PARAMETER filter_exclude_organization_status_id
        Filter to excluded a certain organization status id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Remove-ITGlueOrganizations -data $json_object

        Deletes all defined organization with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#organizations-bulk-destroy

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
        [Nullable[Int64]]$filter_organization_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_organization_status_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_created_at = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_updated_at = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_my_glue_account_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_exclude_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_exclude_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_exclude_organization_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_exclude_organization_status_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Parameter(Mandatory = $true)]
        $data

    )

    $resource_uri = ('/organizations/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if($filter_organization_type_id) {
            $query_params['filter[organization_type_id]'] = $filter_organization_type_id
        }
        if($filter_organization_status_id) {
            $query_params['filter[organization_status_id]'] = $filter_organization_status_id
        }
        if($filter_created_at) {
            $query_params['filter[created_at]'] = $filter_created_at
        }
        if($filter_updated_at) {
            $query_params['filter[updated_at]'] = $filter_updated_at
        }
        if($filter_my_glue_account_id) {
            $query_params['filter[my_glue_account_id]'] = $filter_my_glue_account_id
        }
        if($filter_exclude_id) {
            $query_params['filter[exclude][id]'] = $filter_exclude_id
        }
        if($filter_exclude_name) {
            $query_params['filter[exclude][name]'] = $filter_exclude_name
        }
        if($filter_exclude_organization_type_id) {
            $query_params['filter[exclude][organization_type_id]'] = $filter_exclude_organization_type_id
        }
        if($filter_exclude_organization_status_id) {
            $query_params['filter[exclude][organization_status_id]'] = $filter_exclude_organization_status_id
        }
    }

    return Invoke-ITGlueRequest -Method DELETE -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}
