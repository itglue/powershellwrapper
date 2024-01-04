function New-ITGluePasswords {
<#
    .SYNOPSIS
        Creates oen or more a passwords

    .DESCRIPTION
        The New-ITGluePasswords cmdlet creates one or more passwords
        under the organization specified in the ID parameter.

        To show passwords your API key needs to have the "Password Access" permission

        You can create general and embedded passwords with this endpoint

        If the resource-id and resource-type attributes are NOT provided, IT Glue assumes
        the password is a general password.

        If the resource-id and resource-type attributes are provided, IT Glue assumes
        the password is an embedded password.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER organization_id
        A valid organization Id in your account

    .PARAMETER show_password
        Define if the password should be shown or not

        By default ITGlue hides the passwords from the returned data
        and this function enables the password for display.

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGluePasswords -organization_id 8756309 -data $json_object

        Creates a new password in the defined organization with the structured JSON object.

        The password IS returned in the results

    .EXAMPLE
        New-ITGluePasswords -organization_id 8756309 -show_password $false -data $json_object

        Creates a new password in the defined organization with the structured JSON object.

        The password is NOT returned in the results

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#passwords-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Boolean]$show_password = $true, # Passwords API defaults to $false

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/passwords/'

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords' -f $organization_id)
    }

    $query_params = @{'show_password'=$show_password}

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}



function Get-ITGluePasswords {
<#
    .SYNOPSIS
        List or show all passwords

    .DESCRIPTION
        The Get-ITGluePasswords cmdlet returns a list of passwords for all organizations,
        a specified organization, or the details of a single password.

        To show passwords your API key needs to have the "Password Access" permission

        This function can call the following endpoints:
            Index = /passwords
                    /organizations/:organization_id/relationships/passwords

            Show =  /passwords/:id
                    /organizations/:organization_id/relationships/passwords/:id

    .PARAMETER organization_id
        A valid organization Id in your account

    .PARAMETER filter_id
        Filter by password id

    .PARAMETER filter_name
        Filter by password name

    .PARAMETER filter_archived
        Filter by if the password is archived

    .PARAMETER filter_organization_id
        Filter for passwords by organization id

    .PARAMETER filter_password_category_id
        Filter by passwords category id

    .PARAMETER filter_url
        Filter by password url

    .PARAMETER filter_cached_resource_name
        Filter by a passwords cached resource name

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'name', 'username', 'id', 'created_at', 'updated-at', `
        '-name', '-username', '-id', '-created_at', '-updated-at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        Get a password by id

    .PARAMETER show_password
        Returns the password in the results

    .PARAMETER include
        Include specified assets

        Allowed values(Index):
        'attachments', 'rotatable_password', 'updater', 'user_resource_accesses',
        'group_resource_accesses'

        Allowed values(Show):
        'attachments', 'rotatable_password', 'updater', 'user_resource_accesses',
        'group_resource_accesses', 'recent_versions', 'related_items', 'authorized_users'

    .EXAMPLE
        Get-ITGluePasswords

        Returns the first 50 password results from your ITGlue account

    .EXAMPLE
        Get-ITGluePasswords -id 12345

        Returns the password with the defined id

    .EXAMPLE
        Get-ITGluePasswords -page_number 2 -page_size 10

        Returns the first 10 results from the second page for passwords
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#passwords-index

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
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[bool]]$filter_archived = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_password_category_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_url = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_cached_resource_name = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'username', 'id', 'created_at', 'updated-at', `
                '-name', '-username', '-id', '-created_at', '-updated-at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int64]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'show')]
        [Boolean]$show_password = $true, # Passwords API defaults to $true

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        $include = '',

        [Parameter(ParameterSetName = 'show')]
        [Parameter(ParameterSetName = 'index')]
        [Switch]$all
    )

    $resource_uri = ('/passwords/{0}' -f $id)

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords/{1}' -f $organization_id, $id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_archived) {
            $query_params['filter[archived]'] = $filter_archived
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_password_category_id) {
            $query_params['filter[password_category_id]'] = $filter_password_category_id
        }
        if ($filter_url) {
            $query_params['filter[url]'] = $filter_url
        }
        if ($filter_cached_resource_name) {
            $query_params['filter[cached_resource_name]'] = $filter_cached_resource_name
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
    elseif ($null -eq $organization_id) {
        #Parameter set "Show" is selected and no organization id is specified; switch from nested relationships route
        $resource_uri = ('/passwords/{0}' -f $id)
    }

    $query_params['show_password'] = $show_password
    if($include) {
        $query_params['include'] = $include
    }

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params -AllResults:$all
}



function Set-ITGluePasswords {
<#
    .SYNOPSIS
        Updates one or more passwords

    .DESCRIPTION
        The Set-ITGluePasswords cmdlet updates the details of an
        existing password or the details of multiple passwords.

        To show passwords your API key needs to have the "Password Access" permission

        Any attributes you don't specify will remain unchanged.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER organization_id
        A valid organization Id in your account

    .PARAMETER id
        Update a password by id

    .PARAMETER show_password
        Define if the password should be shown or not

        By default ITGlue hides the passwords from the returned data

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGluePasswords -id 8756309 -data $json_object

        Updates the password in the defined organization with the structured JSON object.

        The password is NOT returned in the results

    .EXAMPLE
        Set-ITGluePasswords -id 8756309 -show_password $true -data $json_object

        Updates the password in the defined organization with the structured JSON object.

        The password IS returned in the results

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#passwords-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Boolean]$show_password = $false, # Passwords API defaults to $false

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/passwords/{0}' -f $id)

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/passwords/{1}' -f $organization_id, $id)
    }

    $query_params = @{'show_password'=$show_password}

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}



function Remove-ITGluePasswords {
<#
    .SYNOPSIS
        Deletes one or more passwords

    .DESCRIPTION
        The Remove-ITGluePasswords cmdlet destroys one or more
        passwords specified by ID.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Delete a password by id

    .PARAMETER filter_id
        Filter by password id

    .PARAMETER filter_name
        Filter by password name

    .PARAMETER filter_organization_id
        Filter for passwords by organization id

    .PARAMETER filter_password_category_id
        Filter by passwords category id

    .PARAMETER filter_url
        Filter by password url

    .PARAMETER filter_cached_resource_name
        Filter by a passwords cached resource name

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Remove-ITGluePasswords -id 8756309

        Deletes the defined password

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#passwords-destroy

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'destroy')]
    Param (
        [Parameter(ParameterSetName = 'destroy')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [Nullable[Int64]]$filter_password_category_id = $null,

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_url = '',

        [Parameter(ParameterSetName = 'bulk_destroy')]
        [String]$filter_cached_resource_name = '',

        [Parameter(ParameterSetName = 'bulk_destroy', Mandatory = $true)]
        $data
    )

    $resource_uri = ('/passwords/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_destroy') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_password_category_id) {
            $query_params['filter[password_category_id]'] = $filter_password_category_id
        }
        if ($filter_url) {
            $query_params['filter[url]'] = $filter_url
        }
        if ($filter_cached_resource_name) {
            $query_params['filter[cached_resource_name]'] = $filter_cached_resource_name
        }
    }

    return Invoke-ITGlueRequest -Method DELETE -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}
