function New-ITGlueManufacturers {
<#
    .SYNOPSIS
        Create a new manufacturer

    .DESCRIPTION
        The New-ITGlueManufacturers cmdlet creates a new manufacturer.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueManufacturers -data $json_object

        Creates a new manufacturers with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#manufacturers-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/manufacturers/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueManufacturers {
<#
    .SYNOPSIS
        List or show all manufacturers

    .DESCRIPTION
        The Get-ITGlueManufacturers cmdlet returns a manufacturer name
        or a list of manufacturers in your account.

        This function can call the following endpoints:
            Index = /manufacturers

            Show =  /manufacturers/:id

    .PARAMETER filter_name
        Filter by a manufacturers name

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
        Get a manufacturer by id

    .EXAMPLE
        Get-ITGlueManufacturers

        Returns the first 50 manufacturer results from your ITGlue account

    .EXAMPLE
        Get-ITGlueManufacturers -id 12345

        Returns the manufacturer with the defined id

    .EXAMPLE
        Get-ITGlueManufacturers -page_number 2 -page_size 10

        Returns the first 10 results from the second page for manufacturers
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#manufacturers-index

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

    $resource_uri = ('/manufacturers/{0}' -f $id)

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



function Set-ITGlueManufacturers {
<#
    .SYNOPSIS
        Updates a manufacturer

    .DESCRIPTION
        The New-ITGlueManufacturers cmdlet updates a manufacturer.

        Returns 422 Bad Request error if trying to update an externally synced record.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        The id of the manufacturer to update

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueManufacturers -id 8765309 -data $json_object

        Updates the defined manufacturer with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#manufacturers-update

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

    $resource_uri = ('/manufacturers/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
