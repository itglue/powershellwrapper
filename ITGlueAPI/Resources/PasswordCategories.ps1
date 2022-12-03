function New-ITGluePasswordCategories {
<#
    .SYNOPSIS
        Creates a password category

    .DESCRIPTION
        The New-ITGluePasswordCategories cmdlet creates a new password category
        in your account.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGluePasswordCategories -data $json_object

        Creates a new password category with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#password-categories-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/password_categories/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}

function Get-ITGluePasswordCategories {
<#
    .SYNOPSIS
        List or show all password categories

    .DESCRIPTION
        The Get-ITGluePasswordCategories cmdlet returns a list of password categories
        or the details of a single password category in your account.

        This function can call the following endpoints:
            Index = /password_categories

            Show =  /password_categories/:id

    .PARAMETER filter_name
        Filter by a password category name

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
        Get a password category by id

    .EXAMPLE
        Get-ITGluePasswordCategories

        Returns the first 50 password category results from your ITGlue account

    .EXAMPLE
        Get-ITGluePasswordCategories -id 12345

        Returns the password category with the defined id

    .EXAMPLE
        Get-ITGluePasswordCategories -page_number 2 -page_size 10

        Returns the first 10 results from the second page for password categories
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#password-categories-index

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

    $resource_uri = ('/password_categories/{0}' -f $id)

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

function Set-ITGluePasswordCategories {
<#
    .SYNOPSIS
        Updates a password category

    .DESCRIPTION
        The Set-ITGluePasswordCategories cmdlet updates a password category
        in your account.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Update a password category by id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGluePasswordCategories -id 8756309 -data $json_object

        Updates the defined password category with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#password-categories-update

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

    $resource_uri = ('/password_categories/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
