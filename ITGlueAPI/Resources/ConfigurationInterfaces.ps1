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

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
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

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_delete') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -data $Data -QueryParams $query_params
}
