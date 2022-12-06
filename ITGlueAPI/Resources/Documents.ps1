function Set-ITGlueDocuments {
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

    return Set-ITGlue -resource_uri $resource_uri -data $data
}
