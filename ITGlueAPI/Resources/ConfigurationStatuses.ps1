function New-ITGlueConfigurationStatuses {
<#
    .SYNOPSIS
        Creates a configuration status.

    .DESCRIPTION
        The New-ITGlueConfigurationStatuses cmdlet creates a new configuration
        status in your account.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueConfigurationStatuses -data $json_object

        Creates a new configuration status with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configuration-statuses-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/configuration_statuses/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueConfigurationStatuses {
<#
    .SYNOPSIS
        List or show all configuration(s) statuses.

    .DESCRIPTION
        The Get-ITGlueConfigurationStatuses cmdlet lists all or shows a
        defined configuration(s) status.

        This function can call the following endpoints:
            Index = /configuration_statuses

            Show =  /configuration_statuses/:id

    .PARAMETER filter_name
        Filter by configuration status name

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
        Get a configuration status by id

    .EXAMPLE
        Get-ITGlueConfigurationStatuses

        Returns the first 50 results from your ITGlue account

    .EXAMPLE
        Get-ITGlueConfigurationStatuses -id 12345

        Returns the configuration status with the defined id

    .EXAMPLE
        Get-ITGlueConfigurationStatuses -page_number 2 -page_size 10

        Returns the first 10 results from the second page for configuration status
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configuration-statuses-index

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

    $resource_uri = ('/configuration_statuses/{0}' -f $id)

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



function Set-ITGlueConfigurationStatuses {
<#
    .SYNOPSIS
        Updates a configuration status.

    .DESCRIPTION
        The Set-ITGlueConfigurationStatuses cmdlet updates a configuration
        status in your account.

        Returns 422 Bad Request error if trying to update an externally synced record.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Get a configuration status by id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueConfigurationStatuses -id 8756309 -data $json_object

        Updates the defined configuration status with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configuration-statuses-update

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

    $resource_uri = ('/configuration_statuses/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
