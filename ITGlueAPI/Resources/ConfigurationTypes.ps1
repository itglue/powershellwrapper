function New-ITGlueConfigurationTypes {
<#
    .SYNOPSIS
        Creates a configuration type.

    .DESCRIPTION
        The New-ITGlueConfigurationTypes cmdlet creates a new configuration type.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueConfigurationTypes -data $json_object

        Creates a new configuration type with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configuration-types-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/configuration_types/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueConfigurationTypes {
<#
    .SYNOPSIS
        List or show all configuration type(s).

    .DESCRIPTION
        The Get-ITGlueConfigurationTypes cmdlet lists all or a single
        configuration type(s).

        This function can call the following endpoints:
            Index =  /configuration_types

            Show =   /configuration_types/:id

    .PARAMETER filter_name
        Filter by configuration type name

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
        Define the configuration type by id

    .EXAMPLE
        Get-ITGlueConfigurationTypes

        Returns the first 50 results from your ITGlue account

    .EXAMPLE
        Get-ITGlueConfigurationTypes -id 12345

        Returns the configuration type with the defined id

    .EXAMPLE
        Get-ITGlueConfigurationTypes -page_number 2 -page_size 10

        Returns the first 10 results from the second page for configuration types
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configuration-types-index

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

    $resource_uri = ('/configuration_types/{0}' -f $id)

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



function Set-ITGlueConfigurationTypes {
<#
    .SYNOPSIS
        Updates a configuration type.

    .DESCRIPTION
        The Set-ITGlueConfigurationTypes cmdlet updates a configuration type
        in your account.

        Returns 422 Bad Request error if trying to update an externally synced record.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Define the configuration type by id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueConfigurationTypes -id 8756309 -data $json_object

        Update the defined configuration type with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configuration-types-update

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

    $resource_uri = ('/configuration_types/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
