function Get-ITGlueUsers {
<#
    .SYNOPSIS
        List or show all users

    .DESCRIPTION
        The Get-ITGlueUsers cmdlet returns a list of the users
        or the details of a single user in your account.

        This function can call the following endpoints:
            Index = /users

            Show =  /users/:id

    .PARAMETER filter_name
        Filter by user name

    .PARAMETER filter_email
        Filter by user email address

    .PARAMETER filter_role_name
        Filter by a users role

        Allowed values:
            'Administrator', 'Manager', 'Editor', 'Creator', 'Lite', 'Read-only'

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'name', 'email', 'reputation', 'id', 'created_at', 'updated-at', `
        '-name', '-email', '-reputation', '-id', '-created_at', '-updated-at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        Get a user by id

    .EXAMPLE
        Get-ITGlueUsers

        Returns the first 50 user results from your ITGlue account

    .EXAMPLE
        Get-ITGlueUsers -id 12345

        Returns the user with the defined id

    .EXAMPLE
        Get-ITGlueUsers -page_number 2 -page_size 10

        Returns the first 10 results from the second page for users
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#accounts-users-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_email = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet('Administrator', 'Manager', 'Editor', 'Creator', 'Lite', 'Read-only')]
        [String]$filter_role_name = '',

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'email', 'reputation', 'id', 'created_at', 'updated-at', `
                '-name', '-email', '-reputation', '-id', '-created_at', '-updated-at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/users/{0}' -f $id)

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_email) {
            $query_params['filter[email]'] = $filter_email
        }
        if ($filter_role_name) {
            $query_params['filter[role_name]'] = $filter_role_name
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



function Set-ITGlueUsers {
<#
    .SYNOPSIS
        Updates the name or profile picture of an existing user.

    .DESCRIPTION
        The Set-ITGlueUsers cmdlet updates the name or profile picture (avatar)
        of an existing user.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Update by user id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueUsers -id 8756309 -data $json_object

        Updates the defined user with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#accounts-users-update

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

    $resource_uri = ('/users/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
