function New-ITGlueConfigurationInterfaces {
    Param (
        [Nullable[Int64]]$conf_id = $null,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/configuration_interfaces/'

    if ($conf_id) {
        $resource_uri = ('/configurations/{0}/relationships/configuration_interfaces' -f $conf_id)
    }

    return New-ITGlue -resource_uri $resource_uri -data $data
}

function Get-ITGlueConfigurationInterfaces {
    [CmdletBinding(DefaultParametersetName = 'index')]
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
        [Nullable[Int64]]$id
    )

    $resource_uri = ('/configurations/{0}/relationships/configuration_interfaces/' -f $conf_id)

    if ($PsCmdlet.ParameterSetName -eq 'show') {
        if ($null -eq $conf_id) {
            $resource_uri = ('/configuration_interfaces/{0}' -f $id)
        } else {
            $resource_uri = ('/configurations/{0}/relationships/configuration_interfaces/{1}' -f $conf_id, $id)
        }
    }

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
        if ($filter_ip_address) {
            $filter_list['filter[ip_address]'] = $filter_ip_address
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

    return Get-ITGlue -resource_uri $resource_uri -filter_list $filter_list
}

function Set-ITGlueConfigurationInterfaces {
    [CmdletBinding(DefaultParametersetName = 'update')]
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

    $filter_list = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_delete') {
        if ($filter_id) {
            $filter_list['filter[id]'] = $filter_id
        }
    }

    return Set-ITGlue -resource_uri $resource_uri -data $data -filter_list $filter_list
}
