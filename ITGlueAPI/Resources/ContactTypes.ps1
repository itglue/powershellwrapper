function New-ITGlueContactTypes {
<#
    .SYNOPSIS
        Create a new contact type.

    .DESCRIPTION
        The New-ITGlueContactTypes cmdlet creates a new contact type in
        your account

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueContactTypes -data $json_object

        Creates a new contact type with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#contact-types-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/contact_types/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueContactTypes {
<#
    .SYNOPSIS
        List or show all contact types.

    .DESCRIPTION
        The Get-ITGlueContactTypes cmdlet returns a list of contacts types
        in your account

        This function can call the following endpoints:
            Index = /contact_types

            Show =  /contact_types/:id

    .PARAMETER filter_name
        Filter by a contact type name

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
        Define a contact type id

    .EXAMPLE
        Get-ITGlueContactTypes

        Returns the first 50 contact types from your ITGlue account

    .EXAMPLE
        Get-ITGlueContactTypes -id 8765309

        Returns the details of the defined contact type.

    .EXAMPLE
        Get-ITGlueContactTypes -page_number 2 -page_size 10

        Returns the first 10 results from the second page for contacts types
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#contact-types-index

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

    $resource_uri = ('/contact_types/{0}' -f $id)

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



function Set-ITGlueContactTypes {
<#
    .SYNOPSIS
        Updates a contact type.

    .DESCRIPTION
        The Set-ITGlueContactTypes cmdlet updates a contact type
        in your account.

        Returns 422 Bad Request error if trying to update an externally synced record.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Define the contact type id to update

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueContactTypes -id 8756309 -data $json_object

        Update the defined contact type with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#contact-types-update

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

    $resource_uri = ('/contact_types/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
