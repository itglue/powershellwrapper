function New-ITGlueConfigurations {
<#
    .SYNOPSIS
        Creates one or more configurations

    .DESCRIPTION
        The New-ITGlueConfigurations cmdlet creates one or more
        configurations under a defined organization.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER organization_id
        A valid organization Id in your Account

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueConfigurations -organization_id 8756309 -data $json_object

        Creates a configuration in the defined organization with the
        with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configurations-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/configurations'

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/configurations' -f $organization_id)
    }

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueConfigurations {
<#
    .SYNOPSIS
        List all configurations in an account or organization

    .DESCRIPTION
        The Get-ITGlueConfigurations cmdlet lists all configurations
        in an account or organization

        This function can call the following endpoints:
            Index = /configurations
                    /organizations/:organization_id/relationships/configurations

            Show =  /configurations/:id
                    /organizations/:organization_id/relationships/configurations/:id

    .PARAMETER id
        A valid configuration Id

    .PARAMETER filter_archived
        Filter for archived

        Allowed values:
        'true', 'false', '1', '0'

    .PARAMETER organization_id
        A valid organization Id in your account

    .PARAMETER filter_id
        Filter by configuration id

    .PARAMETER filter_name
        Filter by configuration name

    .PARAMETER filter_organization_id
        Filter by organization name

    .PARAMETER filter_configuration_type_id
        Filter by configuration type id

    .PARAMETER filter_configuration_status_id
        Filter by configuration status id

    .PARAMETER filter_contact_id
        Filter by contact id

    .PARAMETER filter_serial_number
        Filter by a configurations serial number

    .PARAMETER filter_psa_id
        Filter by a PSA id

    .PARAMETER filter_psa_integration_type
        Filter by a PSA integration type

        Allowed values:
        'manage', 'autotask', 'tigerpaw', 'kaseya-bms', 'pulseway-psa', 'vorex'

    .PARAMETER filter_rmm_id
        Filter by a RMM id

    .PARAMETER filter_rmm_integration_type
        Filter by a RMM integration type

        Allowed values:
        'addigy', 'aem', 'atera', 'auvik', 'managed-workplace', `
        'continuum', 'jamf-pro', 'kaseya-vsa', 'automate', 'log-me-in',`
        'msp-rmm', 'meraki', 'msp-n-central', 'ninja-rmm', 'panorama9', `
        'pulseway-rmm', 'syncro', 'watchman-monitoring'

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'name', 'id', 'created_at', 'updated-at', `
        '-name', '-id', '-created_at', '-updated-at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER include
        Include specified assets

        Allowed values:
        'adapters_resources', 'configuration_interfaces', 'rmm_records', 'passwords',
        'attachments, tickets', 'user_resource_accesses', 'group_resource_accesses'

    .EXAMPLE
        Get-ITGlueConfigurations

        Returns the first 50 configurations from your ITGlue account

    .EXAMPLE
        Get-ITGlueConfigurations -filter_organization_id 10000855

        Returns the first 50 configurations from the defined organization

    .EXAMPLE
        Get-ITGlueConfigurations -page_number 2 -page_size 10

        Returns the first 10 results from the second page for configurations
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configurations-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Nullable[bool]]$filter_archived = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Nullable[Int64]]$filter_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Nullable[Int64]]$filter_configuration_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Nullable[Int64]]$filter_configuration_status_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Nullable[Int64]]$filter_contact_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [String]$filter_serial_number = '',

        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [String]$filter_psa_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa', Mandatory = $true)]
        [Parameter(ParameterSetName = 'index_rmm_psa', Mandatory = $true)]
        [ValidateSet('manage', 'autotask', 'tigerpaw', 'kaseya-bms', 'pulseway-psa', 'vorex')]
        [String]$filter_psa_integration_type = '',

        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [String]$filter_rmm_id = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm', Mandatory = $true)]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa', Mandatory = $true)]
        [ValidateSet('addigy', 'aem', 'atera', 'auvik', 'managed-workplace', `
                'continuum', 'jamf-pro', 'kaseya-vsa', 'automate', 'log-me-in',`
                'msp-rmm', 'meraki', 'msp-n-central', 'ninja-rmm', 'panorama9', `
                'pulseway-rmm', 'syncro', 'watchman-monitoring')]
        [String]$filter_rmm_integration_type = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [ValidateSet('name', 'id', 'created_at', 'updated-at', `
                '-name', '-id', '-created_at', '-updated-at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Parameter(ParameterSetName = 'show')]
        [String]$include = '',

        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'index_rmm')]
        [Parameter(ParameterSetName = 'index_psa')]
        [Parameter(ParameterSetName = 'index_rmm_psa')]
        [Parameter(ParameterSetName = 'show')]
        [Switch]$all
    )

    if($organization_id) {
        #Switch to nested relationships route
        $resource_uri = ('/organizations/{0}/relationships/configurations/{1}' -f $organization_id, $id)
    }
    else {
        $resource_uri = ('/configurations/{0}' -f $id)
    }

    $query_params = @{}

    if (($PSCmdlet.ParameterSetName -eq 'index') -or `
        ($PSCmdlet.ParameterSetName -eq 'index_rmm') -or `
        ($PSCmdlet.ParameterSetName -eq 'index_psa') -or `
        ($PSCmdlet.ParameterSetName -eq 'index_rmm_psa')) {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_archived) {
            $query_params['filter[archived]'] = $filter_archived
        }
        if ($filter_configuration_type_id) {
            $query_params['filter[configuration_type_id]'] = $filter_configuration_type_id
        }
        if ($filter_configuration_status_id) {
            $query_params['filter[configuration_status_id]'] = $filter_configuration_status_id
        }
        if ($filter_contact_id) {
            $query_params['filter[contact_id]'] = $filter_contact_id
        }
        if ($filter_serial_number) {
            $query_params['filter[serial_number]'] = $filter_serial_number
        }
        if ($filter_rmm_integration_type) {
            $query_params['filter[rmm_integration_type]'] = $filter_rmm_integration_type
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
    if (($PSCmdlet.ParameterSetName -eq 'index_rmm') -or ($PSCmdlet.ParameterSetName -eq 'index_rmm_psa')) {
        $query_params['filter[rmm_id]'] = $filter_rmm_id
    }
    if (($PSCmdlet.ParameterSetName -eq 'index_psa') -or ($PSCmdlet.ParameterSetName -eq 'index_rmm_psa')) {
        $query_params['filter[psa_id]'] = $filter_psa_id
    }

    if($include) {
        $query_params['include'] = $include
    }

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params -AllResults:$all
}



function Set-ITGlueConfigurations {
<#
    .SYNOPSIS
        Updates one or more configurations

    .DESCRIPTION
        The Set-ITGlueConfigurations cmdlet updates the details
        of one or more existing configurations

        Any attributes you don't specify will remain unchanged.

        This function can call the following endpoints:
            Update = /configurations/:id
                    /organizations/:organization_id/relationships/configurations/:id

            Bulk_Update =  /configurations

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        A valid configuration Id

    .PARAMETER organization_id
        A valid organization Id in your account

    .PARAMETER filter_id
        Filter by configuration id

    .PARAMETER filter_name
        Filter by configuration name

    .PARAMETER filter_organization_id
        Filter by organization name

    .PARAMETER filter_configuration_type_id
        Filter by configuration type id

    .PARAMETER filter_configuration_status_id
        Filter by configuration status id

    .PARAMETER filter_contact_id
        Filter by contact id

    .PARAMETER filter_serial_number
        Filter by a configurations serial number

    .PARAMETER filter_psa_id
        Filter by a PSA id

    .PARAMETER filter_psa_integration_type
        Filter by a PSA integration type

        Allowed values:
        'manage', 'autotask', 'tigerpaw', 'kaseya-bms', 'pulseway-psa', 'vorex'

    .PARAMETER filter_rmm_id
        Filter by a RMM id

    .PARAMETER filter_rmm_integration_type
        Filter by a RMM integration type

        Allowed values:
        'addigy', 'aem', 'atera', 'auvik', 'managed-workplace', `
        'continuum', 'jamf-pro', 'kaseya-vsa', 'automate', 'log-me-in',`
        'msp-rmm', 'meraki', 'msp-n-central', 'ninja-rmm', 'panorama9', `
        'pulseway-rmm', 'syncro', 'watchman-monitoring'

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueConfigurations -id 12345 -organization_id 10000855 -data $json_object

        Updates a defined configuration in the defined organization with
        the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configurations-update

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
        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [Nullable[Int64]]$filter_configuration_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [Nullable[Int64]]$filter_configuration_status_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [Nullable[Int64]]$filter_contact_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [String]$filter_serial_number = '',

        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [String]$filter_psa_id = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_psa', Mandatory = $true)]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa', Mandatory = $true)]
        [ValidateSet('manage', 'autotask', 'tigerpaw', 'kaseya-bms', 'pulseway-psa', 'vorex')]
        [String]$filter_psa_integration_type = '',

        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [String]$filter_rmm_id = '',

        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(ParameterSetName = 'bulk_update_rmm', Mandatory = $true)]
        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa', Mandatory = $true)]
        [ValidateSet('addigy', 'aem', 'atera', 'auvik', 'managed-workplace', `
                'continuum', 'jamf-pro', 'kaseya-vsa', 'automate', 'log-me-in',`
                'msp-rmm', 'meraki', 'msp-n-central', 'ninja-rmm', 'panorama9', `
                'pulseway-rmm', 'syncro', 'watchman-monitoring')]
        [String]$filter_rmm_integration_type = '',

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(ParameterSetName = 'bulk_update_rmm')]
        [Parameter(ParameterSetName = 'bulk_update_psa')]
        [Parameter(ParameterSetName = 'bulk_update_rmm_psa')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/configurations/{0}' -f $id)

    if ($flexible_asset_type_id) {
        $resource_uri = ('/organizations/{0}/relationships/configurations/{1}' -f $organization_id, $id)
    }

    $query_params = @{}

    if (($PSCmdlet.ParameterSetName -eq 'bulk_update') -or `
        ($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm') -or `
        ($PSCmdlet.ParameterSetName -eq 'bulk_update_psa') -or `
        ($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm_psa')) {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_configuration_type_id) {
            $query_params['filter[configuration_type_id]'] = $filter_configuration_type_id
        }
        if ($filter_configuration_status_id) {
            $query_params['filter[configuration_status_id]'] = $filter_configuration_status_id
        }
        if ($filter_contact_id) {
            $query_params['filter[contact_id]'] = $filter_contact_id
        }
        if ($filter_serial_number) {
            $query_params['filter[serial_number]'] = $filter_serial_number
        }
        if ($filter_rmm_id) {
            $query_params['filter[rmm_id]'] = $filter_rmm_id
        }
        if ($filter_rmm_integration_type) {
            $query_params['filter[rmm_integration_type]'] = $filter_rmm_integration_type
        }
    }
    if (($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm') -or ($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm_psa')) {
        $query_params['filter[rmm_id]'] = $filter_rmm_id
    }
    if (($PSCmdlet.ParameterSetName -eq 'bulk_update_psa') -or ($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm_psa')) {
        $query_params['filter[psa_id]'] = $filter_psa_id
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}



function Remove-ITGlueConfigurations {
<#
    .SYNOPSIS
        Deletes one or more configurations

    .DESCRIPTION
        The Remove-ITGlueConfigurations cmdlet deletes one or
        more specified configurations

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        A valid configuration Id

    .PARAMETER filter_id
        Filter by configuration id

    .PARAMETER filter_name
        Filter by configuration name

    .PARAMETER filter_organization_id
        Filter by organization name

    .PARAMETER filter_configuration_type_id
        Filter by configuration type id

    .PARAMETER filter_configuration_status_id
        Filter by configuration status id

    .PARAMETER filter_contact_id
        Filter by contact id

    .PARAMETER filter_serial_number
        Filter by a configurations serial number

    .PARAMETER filter_rmm_id
        Filter by a RMM id

    .PARAMETER filter_rmm_integration_type
        Filter by a RMM integration type

        Allowed values:
        'addigy', 'aem', 'atera', 'auvik', 'managed-workplace', `
        'continuum', 'jamf-pro', 'kaseya-vsa', 'automate', 'log-me-in',`
        'msp-rmm', 'meraki', 'msp-n-central', 'ninja-rmm', 'panorama9', `
        'pulseway-rmm', 'syncro', 'watchman-monitoring'

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Remove-ITGlueConfigurations -id 12345 -data $json_object

        Deletes a defined configuration with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#configurations-bulk-destroy

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'bulk_delete')]
    Param (
        [Parameter(ParameterSetName = 'delete', Mandatory = $true)]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'bulk_delete')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'bulk_delete')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'bulk_delete')]
        [Nullable[Int64]]$filter_organization_id = $null,

        [Parameter(ParameterSetName = 'bulk_delete')]
        [Nullable[Int64]]$filter_configuration_type_id = $null,

        [Parameter(ParameterSetName = 'bulk_delete')]
        [Nullable[Int64]]$filter_configuration_status_id = $null,

        [Parameter(ParameterSetName = 'bulk_delete')]
        [Nullable[Int64]]$filter_contact_id = $null,

        [Parameter(ParameterSetName = 'bulk_delete')]
        [String]$filter_serial_number = '',

        [Parameter(ParameterSetName = 'bulk_delete')]
        [String]$filter_rmm_id = '',

        [Parameter(ParameterSetName = 'bulk_delete')]
        [ValidateSet('addigy', 'aem', 'atera', 'auvik', 'managed-workplace', `
                'continuum', 'jamf-pro', 'kaseya-vsa', 'automate', 'log-me-in',`
                'msp-rmm', 'meraki', 'msp-n-central', 'ninja-rmm', 'panorama9', `
                'pulseway-rmm', 'syncro', 'watchman-monitoring')]
        [String]$filter_rmm_integration_type = '',

        [Parameter(ParameterSetName = 'bulk_delete', Mandatory = $true)]
        $data
    )

    $resource_uri = '/configurations/'

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_delete') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $query_params['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $query_params['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_configuration_type_id) {
            $query_params['filter[configuration_type_id]'] = $filter_configuration_type_id
        }
        if ($filter_configuration_status_id) {
            $query_params['filter[configuration_status_id]'] = $filter_configuration_status_id
        }
        if ($filter_contact_id) {
            $query_params['filter[contact_id]'] = $filter_contact_id
        }
        if ($filter_serial_number) {
            $query_params['filter[serial_number]'] = $filter_serial_number
        }
        if ($filter_rmm_id) {
            $query_params['filter[rmm_id]'] = $filter_rmm_id
        }
        if ($filter_rmm_integration_type) {
            $query_params['filter[rmm_integration_type]'] = $filter_rmm_integration_type
        }
    } elseif ($PSCmdlet.ParameterSetName -eq 'delete') {
        $data = @(
            @{
                type = 'configurations'
                attributes = @{
                    id = $id
                }
            }
        )
    }

    return Invoke-ITGlueRequest -Method DELETE -RequestURI $resource_uri -Data $data -QueryParams $query_params
}
