function Set-ITGlueDocuments {
<#
    .SYNOPSIS
        Updates one or more documents

    .DESCRIPTION
        The Set-ITGlueDocuments cmdlet updates one or more existing documents

        Any attributes you don't specify will remain unchanged.

        This function can call the following endpoints:
            Update =    /documents/:id
                        /organizations/:organization_id/relationships/documents/:id

            Bulk_Update =  /documents

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER organization_id
        A valid organization Id in your Account

    .PARAMETER id
        The document id to update

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueDocuments -id 8756309 -data $json_object

        Updates the defined document with the structured JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#documents-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

    [CmdletBinding(DefaultParameterSetName = 'update')]
    Param (
        [Parameter(ParameterSetName = 'update')]
        [int64]$organization_id,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(Mandatory = $true)]
        [int64]$id,

        [Parameter(ParameterSetName = 'update')]
        [Parameter(ParameterSetName = 'bulk_update')]
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/documents/{0}' -f $id)
    if ($organization_id) {
        $resource_uri = ('/organizations/{0}/relationships/documents/{1}' -f $organization_id, $id)
    }

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}
