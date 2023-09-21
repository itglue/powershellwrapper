function New-ITGlueConfigurationTypes {
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/configuration_types/'

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}

function Get-ITGlueConfigurationTypes {
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

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -QueryParams $query_params -AllResults:$all
}

function Set-ITGlueConfigurationTypes {
    Param (
        [Parameter(Mandatory = $true)]
        [Int64]$id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/configuration_types/{0}' -f $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
