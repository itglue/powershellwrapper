function New-ITGlueConfigurations {
    Param (
        [Nullable[Int64]]$organization_id = $null,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/configurations'

    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/configurations' -f $organization_id)
    }

    return New-ITGlue -resource_uri $resource_uri -data $data
}

function Get-ITGlueConfigurations {
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
        [String]$include = ''
    )

    if($organization_id) {
        #Switch to nested relationships route
        $resource_uri = ('/organizations/{0}/relationships/configurations/{1}' -f $organization_id, $id)
    }
    else {
        $resource_uri = ('/configurations/{0}' -f $id)
    }

    $filter_list = @{}

    if (($PSCmdlet.ParameterSetName -eq 'index') -or `
        ($PSCmdlet.ParameterSetName -eq 'index_rmm') -or `
        ($PSCmdlet.ParameterSetName -eq 'index_psa') -or `
        ($PSCmdlet.ParameterSetName -eq 'index_rmm_psa')) {
        if ($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $filter_list['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_archived) {
            $filter_list['filter[archived]'] = $filter_archived
        }
        if ($filter_configuration_type_id) {
            $filter_list['filter[configuration_type_id]'] = $filter_configuration_type_id
        }
        if ($filter_configuration_status_id) {
            $filter_list['filter[configuration_status_id]'] = $filter_configuration_status_id
        }
        if ($filter_contact_id) {
            $filter_list['filter[contact_id]'] = $filter_contact_id
        }
        if ($filter_serial_number) {
            $filter_list['filter[serial_number]'] = $filter_serial_number
        }
        if ($filter_rmm_integration_type) {
            $filter_list['filter[rmm_integration_type]'] = $filter_rmm_integration_type
        }
        if ($filter_psa_integration_type) {
            $filter_list['filter[psa_integration_type]'] = $filter_psa_integration_type
        }
        if ($sort) {
            $filter_list['sort'] = $sort
        }
        if ($page_number) {
            $filter_list['page[number]'] = $page_number
        }
        if ($page_size) {
            $filter_list['page[size]'] = $page_size
        }
    }
    if (($PSCmdlet.ParameterSetName -eq 'index_rmm') -or ($PSCmdlet.ParameterSetName -eq 'index_rmm_psa')) {
        $filter_list['filter[rmm_id]'] = $filter_rmm_id
    }
    if (($PSCmdlet.ParameterSetName -eq 'index_psa') -or ($PSCmdlet.ParameterSetName -eq 'index_rmm_psa')) {
        $filter_list['filter[psa_id]'] = $filter_psa_id
    }

    if($include) {
        $filter_list['include'] = $include
    }

    return Get-ITGlue -resource_uri $resource_uri -filter_list $filter_list
}

function Set-ITGlueConfigurations {
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

    $filter_list = @{}

    if (($PSCmdlet.ParameterSetName -eq 'bulk_update') -or `
        ($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm') -or `
        ($PSCmdlet.ParameterSetName -eq 'bulk_update_psa') -or `
        ($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm_psa')) {
        if ($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $filter_list['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_configuration_type_id) {
            $filter_list['filter[configuration_type_id]'] = $filter_configuration_type_id
        }
        if ($filter_configuration_status_id) {
            $filter_list['filter[configuration_status_id]'] = $filter_configuration_status_id
        }
        if ($filter_contact_id) {
            $filter_list['filter[contact_id]'] = $filter_contact_id
        }
        if ($filter_serial_number) {
            $filter_list['filter[serial_number]'] = $filter_serial_number
        }
        if ($filter_rmm_id) {
            $filter_list['filter[rmm_id]'] = $filter_rmm_id
        }
        if ($filter_rmm_integration_type) {
            $filter_list['filter[rmm_integration_type]'] = $filter_rmm_integration_type
        }
    }
    if (($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm') -or ($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm_psa')) {
        $filter_list['filter[rmm_id]'] = $filter_rmm_id
    }
    if (($PSCmdlet.ParameterSetName -eq 'bulk_update_psa') -or ($PSCmdlet.ParameterSetName -eq 'bulk_update_rmm_psa')) {
        $filter_list['filter[psa_id]'] = $filter_psa_id
    }

    return Set-ITGlue -resource_uri $resource_uri -data $data -filter_list $filter_list
}

function Remove-ITGlueConfigurations {
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

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_delete') {
        if ($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if ($filter_name) {
            $filter_list['filter[name]'] = $filter_name
        }
        if ($filter_organization_id) {
            $filter_list['filter[organization_id]'] = $filter_organization_id
        }
        if ($filter_configuration_type_id) {
            $filter_list['filter[configuration_type_id]'] = $filter_configuration_type_id
        }
        if ($filter_configuration_status_id) {
            $filter_list['filter[configuration_status_id]'] = $filter_configuration_status_id
        }
        if ($filter_contact_id) {
            $filter_list['filter[contact_id]'] = $filter_contact_id
        }
        if ($filter_serial_number) {
            $filter_list['filter[serial_number]'] = $filter_serial_number
        }
        if ($filter_rmm_id) {
            $filter_list['filter[rmm_id]'] = $filter_rmm_id
        }
        if ($filter_rmm_integration_type) {
            $filter_list['filter[rmm_integration_type]'] = $filter_rmm_integration_type
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

    return Remove-ITGlue -resource_uri $resource_uri -data $data -filter_list $filter_list
}
