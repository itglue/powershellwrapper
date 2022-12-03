function New-ITGlueModels {
<#
    .SYNOPSIS
        Creates one or more models

    .DESCRIPTION
        The New-ITGlueModels cmdlet creates one or more models
        in your account or for a particular manufacturer.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER manufacturer_id
        The manufacturer id to create the model under

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueModels -data $json_object

        Creates a new model with the structured JSON object.

    .EXAMPLE
        New-ITGlueModels -manufacturer_id 8756309 -data $json_object

        Creates a new model associated to the defined model with the
        structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#models-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [cmdletbinding()]
    Param (
        [Nullable[Int64]]$manufacturer_id = $null,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/models/'

    if ($manufacturer_id) {
        $resource_uri = ('/manufacturers/{0}/relationships/models' -f $manufacturer_id)
    }

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}



function Get-ITGlueModels {
<#
    .SYNOPSIS
        List or show all models

    .DESCRIPTION
        The Get-ITGlueModels cmdlet returns a list of model names for all
        manufacturers or for a specified manufacturer.

        This function can call the following endpoints:
            Index = /models

            Show =  /manufacturers/:id/relationships/models

    .PARAMETER manufacturer_id
        Get models under the defined manufacturer id

    .PARAMETER filter_id
        Filter models by id

    .PARAMETER sort
        Sort results by a defined value

        Allowed values:
        'id', 'name', 'manufacturer_id', 'created_at', 'updated_at', `
        '-id', '-name', '-manufacturer_id', '-created_at', '-updated_at'

    .PARAMETER page_number
        Return results starting from the defined number

    .PARAMETER page_size
        Number of results to return per page

    .PARAMETER id
        Get a model by id

    .EXAMPLE
        Get-ITGlueModels

        Returns the first 50 model results from your ITGlue account

    .EXAMPLE
        Get-ITGlueModels -id 12345

        Returns the model with the defined id

    .EXAMPLE
        Get-ITGlueModels -page_number 2 -page_size 10

        Returns the first 10 results from the second page for models
        in your ITGlue account

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#models-index

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$manufacturer_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'id', 'name', 'manufacturer_id', 'created_at', 'updated_at', `
                '-id', '-name', '-manufacturer_id', '-created_at', '-updated_at')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/models/{0}' -f $id)
    if ($manufacturer_id) {
        $resource_uri = ('/manufacturers/{0}/relationships' -f $manufacturer_id) + $resource_uri
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
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



function Set-ITGlueModels {
<#
    .SYNOPSIS
        Updates one or more models

    .DESCRIPTION
        The Set-ITGlueModels cmdlet updates an existing model or
        set of models in your account.

        Returns 422 Bad Request error if trying to update an externally synced record.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER id
        Update a model by id

    .PARAMETER manufacturer_id
        Update models under the defined manufacturer id

    .PARAMETER filter_id
        Filter models by id

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueModels -id 8756309 -data $json_object

        Updates the defined model with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#models-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Nullable[Int64]]$manufacturer_id = $null,

        [Parameter(ParameterSetName = 'bulk_update')]
        [Nullable[Int64]]$filter_id = $null,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/models/{0}' -f $id)

    if ($manufacturer_id) {
        $resource_uri = ('/manufacturers/{0}/relationships/models/{1}' -f $manufacturer_id, $id)
    }

    $query_params = @{}

    if ($PSCmdlet.ParameterSetName -eq 'bulk_update') {
        if ($filter_id) {
            $query_params['filter[id]'] = $filter_id
        }
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data -QueryParams $query_params
}
