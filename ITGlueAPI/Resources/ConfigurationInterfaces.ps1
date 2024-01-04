function New-ITGlueConfigurationInterfaces {
<#
    .SYNOPSIS
        Creates one or more configuration interfaces for a particular configuration(s).

    .DESCRIPTION
        The New-ITGlueConfigurationInterfaces cmdlet creates one or more configuration
        interfaces for a particular configuration(s).

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER conf_id
        A valid configuration ID in your account.

        Example: 8765309

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueConfigurationInterfaces -conf_id 8765309 -data $json_object

        Creates a configuration interface for the defined configuration using the structured JSON object

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configuration-interfaces-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Nullable[Int64]]$conf_id = $null,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/configuration_interfaces/'

    if ($conf_id) {
        $resource_uri = ('/configurations/{0}/relationships/configuration_interfaces' -f $conf_id)
    }

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueConfigurationInterfaces {
<#
    .SYNOPSIS
        Retrieve a configuration(s) interface(s).

    .DESCRIPTION
        The Get-ITGlueConfigurationInterfaces cmdlet retrieves a
        configuration(s) interface(s).

        This function can call the following endpoints:
            Index = /configurations/:conf_id/relationships/configuration_interfaces

            Show =  /configuration_interfaces/:id
                    /configurations/:id/relationships/configuration_interfaces/:id

    .PARAMETER conf_id
        A valid configuration ID in your account.

        Example: 8765309

    .PARAMETER filter_id
        Configuration id to filter by

        Example: 8765309

    .PARAMETER filter_ip_address
        IP address to filter by

        Example: 192.168.1.100

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'created_at', 'updated_at', '-created_at', '-updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        A valid configuration interface ID in your account.

        Example: 12345

    .EXAMPLE
        Get-ITGlueConfigurationInterfaces -conf_id 8765309

        Gets an index of all the defined configurations interfaces

    .EXAMPLE
        Get-ITGlueConfigurationInterfaces -conf_id 8765309 -id 12345

        Gets an a defined interface from a defined configuration

    .EXAMPLE
        Get-ITGlueConfigurationInterfaces -conf_id 8765309 -id 12345

        Gets a defined interface from a defined configuration

    .EXAMPLE
        Get-ITGlueConfigurationInterfaces -id 12345

        Gets a defined interface

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configuration-interfaces-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index', Mandatory = $true)]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$conf_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_ip_address = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet('created_at', 'updated_at', `
                '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show', Mandatory = $true)]
        [Nullable[Int64]]$id,

        [Parameter(ParameterSetName = 'show')]
        [Parameter(ParameterSetName = 'index')]
        [Switch]$all
    )

    $resource_uri = ('/configurations/{0}/relationships/configuration_interfaces/' -f $conf_id)

    if ($PsCmdlet.ParameterSetName -eq 'show') {
        if ($null -eq $conf_id) {
            $resource_uri = ('/configuration_interfaces/{0}' -f $id)
        } else {
            $resource_uri = ('/configurations/{0}/relationships/configuration_interfaces/{1}' -f $conf_id, $id)
        }
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_ip_address) {
            $query_params['filter[ip_address]'] = $filter_ip_address
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



function Set-ITGlueConfigurationInterfaces {
<#
    .SYNOPSIS
        Update one or more configuration interfaces.

    .DESCRIPTION
        The Set-ITGlueConfigurationInterfaces cmdlet updates one
        or more configuration interfaces.

        Any attributes you don't specify will remain unchanged.

        This function can call the following endpoints:
            Update =    /configuration_interfaces/:id
                        /configurations/:conf_id/relationships/configuration_interfaces/:id

            Bulk_Update =   /configuration_interfaces
                            /configurations/:conf_id/relationships/configuration_interfaces/:id

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        A valid configuration interface ID in your account.

        Example: 12345

    .PARAMETER conf_id
        A valid configuration ID in your account.

        Example: 8765309

    .PARAMETER filter_id
        Configuration id to filter by

        Example: 8765309

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueConfigurationInterfaces -id 12345 -data $json_object

        Updates an interface for the defined configuration with the structured
        JSON object.

    .EXAMPLE
        Set-ITGlueConfigurationInterfaces -filter_id 8765309 -data $json_object

        Bulk updates interfaces associated to the defined configuration filter
        with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configuration-interfaces-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$conf_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/configuration_interfaces/{0}' -f $id)

    if ($conf_id) {
        $resource_uri = ('/configurations/{0}/relationships/configuration_interfaces/{1}' -f $conf_id, $id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_delete') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -data $Data -QueryParams $query_params
}
