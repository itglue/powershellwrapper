function New-ITGlueContacts {
<#
    .SYNOPSIS
        Creates one or more contacts

    .DESCRIPTION
        The New-ITGlueContacts cmdlet creates one or more contacts
        under the organization specified

        Can also be used create multiple new contacts in bulk.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER organization_id
        The organization id to create the contact(s) in

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueContacts -organization_id 8756309 -data $json_object

        Create a new contact in the defined organization with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#contacts-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/contacts'

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts' -f $organization_id)
    }

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueContacts {
<#
    .SYNOPSIS
        List or show all contacts

    .DESCRIPTION
        The Get-ITGlueContacts cmdlet lists all or a single contact(s)
        from your account or a defined organization.

        This function can call the following endpoints:
            Index = /contacts
                    /organizations/:organization_id/relationships/contacts

            Show =   /contacts/:id
                    /organizations/:organization_id/relationships/contacts/:id

    .PARAMETER organization_id
        A valid organization Id in your account

    .PARAMETER filter_id
        Filter by contact id

    .PARAMETER filter_first_name
        Filter by contact first name

    .PARAMETER filter_last_name
        Filter by contact last name

    .PARAMETER filter_title
        Filter by contact title

    .PARAMETER filter_contact_type_id
        Filter by contact type id

    .PARAMETER filter_important
        Filter by if contact is important

    .PARAMETER filter_primary_email
        Filter by contact primary email address

    .PARAMETER filter_psa_id
        Filter by a PSA id

    .PARAMETER filter_psa_integration_type
        Filter by a PSA integration type

        Allowed values:
        'manage', 'autotask', 'tigerpaw', 'kaseya-bms', 'pulseway-psa', 'vorex'

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'first_name', 'last_name', 'id', 'created_at', 'updated_at', `
        '-first_name', '-last_name', '-id', '-created_at', '-updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        Define a contact id

    .PARAMETER include
        Include specified assets

        Allowed values:
        'adapters_resources', 'location', 'passwords', 'attachments', 'tickets', 'distinct_remote_contacts',
        'resource_fields, 'user_resource_accesses', 'group_resource_accesses', 'recent_versions',
        'related_items', 'authorized_users'

    .EXAMPLE
        Get-ITGlueContacts

        Returns the first 50 contacts from your ITGlue account

    .EXAMPLE
        Get-ITGlueContacts -organization_id 8765309

        Returns the first 50 contacts from the defined organization

    .EXAMPLE
        Get-ITGlueContacts -page_number 2 -page_size 10

        Returns the first 10 results from the second page for contacts
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#contacts-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_last_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_title = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Boolean]]$filter_important = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_primary_email = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa', Mandatory = $true)]
        [ValidateSet('manage', 'autotask', 'tigerpaw', 'kaseya-bms', 'pulseway-psa', 'vorex')]
        [String]$filter_psa_integration_type = '',

        [Parameter(ParameterSetName = 'index_psa')]
        [String]$filter_psa_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [ValidateSet( 'first_name', 'last_name', 'id', 'created_at', 'updated_at', `
                '-first_name', '-last_name', '-id', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'show')]
        $include = ''
    )

    $resource_uri = ('/contacts/{0}' -f $id)
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships' -f $organization_id) + $resource_uri
    }

    $query_params = @{}

    if (($PSCmdlet.ParameterSetName -eq 'index') -or ($PSCmdlet.ParameterSetName -eq 'index_psa')) {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_first_name) {
            $query_params['filter[first_name]'] = $filter_first_name
        }
        if ($filter_last_name) {
            $query_params['filter[last_name]'] = $filter_last_name
        }
        if ($filter_title) {
            $query_params['filter[title]'] = $filter_title
        }
        if ($filter_contact_type_id) {
            $query_params['filter[contact_type_id]'] = $filter_contact_type_id
        }
        if ($filter_important -eq $true) {
            $query_params['filter[important]'] = '1'
        }
        elseif ($filter_important -eq $false) {
            $query_params['filter[important]'] = '0'
        }
        if ($filter_primary_email) {
            $query_params['filter[primary_email]'] = $filter_primary_email
        }
        if ($filter_psa_integration_type) {
            $query_params['filter[psa_integration_type]'] = $filter_psa_integration_type
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
    if ($PSCmdlet.ParameterSetName -eq 'index_psa') {
        $query_params['filter[psa_id]'] = $filter_psa_id
    }

    if($include) {
        $query_params += @{'include' = $include}
    }

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params
}



function Set-ITGlueContacts {
<#
    .SYNOPSIS
        Updates one or more contacts

    .DESCRIPTION
        The Set-ITGlueContacts cmdlet updates the details of one
        or more specified contacts

        Returns 422 Bad Request error if trying to update an externally synced record.

        Any attributes you don't specify will remain unchanged.

        This function can call the following endpoints:
            Update = /contacts/:id
                    /organizations/:organization_id/relationships/contacts/:id

            Bulk_Update =  /contacts

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Define a contact id

    .PARAMETER organization_id
        A valid organization Id in your account

    .PARAMETER filter_id
        Filter by contact id

    .PARAMETER filter_first_name
        Filter by contact first name

    .PARAMETER filter_last_name
        Filter by contact last name

    .PARAMETER filter_title
        Filter by contact title

    .PARAMETER filter_contact_type_id
        Filter by contact type id

    .PARAMETER filter_important
        Filter by if contact is important

    .PARAMETER filter_primary_email
        Filter by contact primary email address

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueContacts -id 8756309 -data $json_object

        Updates the defined contact with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#contacts-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_last_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_title = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Boolean]]$filter_important = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [String]$filter_primary_email = '',

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data

    )

    $resource_uri = ('/contacts/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts/{1}' -f $organization_id, $id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_update') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_first_name) {
            $query_params['filter[first_name]'] = $filter_first_name
        }
        if ($filter_last_name) {
            $query_params['filter[last_name]'] = $filter_last_name
        }
        if ($filter_title) {
            $query_params['filter[title]'] = $filter_title
        }
        if ($filter_contact_type_id) {
            $query_params['filter[contact_type_id]'] = $filter_contact_type_id
        }
        if ($filter_important -eq $true) {
            $query_params['filter[important]'] = '1'
        }
        elseif ($filter_import -eq $false) {
            $query_params['filter[important]'] = '0'
        }
        if ($filter_primary_email) {
            $query_params['filter[primary_email]'] = $filter_primary_email
        }
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}



function Remove-ITGlueContacts {
<#
    .SYNOPSIS
        Deletes one or more contacts

    .DESCRIPTION
        The Remove-ITGlueContacts cmdlet deletes one or more specified contacts

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER filter_id
        Filter by contact id

    .PARAMETER filter_first_name
        Filter by contact first name

    .PARAMETER filter_last_name
        Filter by contact last name

    .PARAMETER filter_title
        Filter by contact title

    .PARAMETER filter_contact_type_id
        Filter by contact type id

    .PARAMETER filter_important
        Filter by if contact is important

    .PARAMETER filter_primary_email
        Filter by contact primary email address

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Remove-ITGlueContacts -filter_contact_type_id 8756309 -data $json_object

        Deletes contacts with the defined type id with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#contacts-bulk-destroy

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'bulk_destroy')]
    Param (
        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_first_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_last_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_title = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_contact_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Boolean]]$filter_important = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_primary_email = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/contacts/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/organizations/{0}/relationships/contacts/{1}' -f $organization_id, $id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_first_name) {
            $query_params['filter[first_name]'] = $filter_first_name
        }
        if ($filter_last_name) {
            $query_params['filter[last_name]'] = $filter_last_name
        }
        if ($filter_title) {
            $query_params['filter[title]'] = $filter_title
        }
        if ($filter_contact_type_id) {
            $query_params['filter[contact_type_id]'] = $filter_contact_type_id
        }
        if ($filter_important -eq $true) {
            $query_params['filter[important]'] = '1'
        }
        elseif ($filter_important -eq $false) {
            $query_params['filter[important]'] = '0'
        }
        if ($filter_primary_email) {
            $query_params['filter[primary_email]'] = $filter_primary_email
        }
    }

    return Invoke-ITGlueRequest -Method DELETE -RequestURI $resource_uri -Data $data -QueryParams $query_params
}
