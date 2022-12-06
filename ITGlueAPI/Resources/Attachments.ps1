function New-ITGlueAttachments {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet( 'checklists', 'checklist_templates', 'configurations', 'contacts', 'documents', `
                'domains', 'locations', 'passwords', 'ssl_certificates', 'flexible_assets', 'tickets')]
        [string]$resource_type,

        [Parameter(Mandatory = $true)]
        [int64]$resource_id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/{0}/{1}/relationships/attachments' -f $resource_type, $resource_id)

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -Data $data

}

function Set-ITGlueAttachments {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet( 'checklists', 'checklist_templates', 'configurations', 'contacts', 'documents', `
                'domains', 'locations', 'passwords', 'ssl_certificates', 'flexible_assets', 'tickets')]
        [string]$resource_type,

        [Parameter(Mandatory = $true)]
        [int64]$resource_id,

        [Parameter(Mandatory = $true)]
        [int64]$id,

        [Parameter(Mandatory = $true)]
        $data

    )

    $resource_uri = ('/{0}/{1}/relationships/attachments/{2}' -f $resource_type, $resource_id, $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}

function Remove-ITGlueAttachments {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet( 'checklists', 'checklist_templates', 'configurations', 'contacts', 'documents', `
                'domains', 'locations', 'passwords', 'ssl_certificates', 'flexible_assets', 'tickets')]
        [string]$resource_type,

        [Parameter(Mandatory = $true)]
        [int64]$resource_id,

        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = ('/{0}/{1}/relationships/attachments' -f $resource_type, $resource_id)

    return Invoke-ITGlueRequest -Method DELETE -ResourceURI $resource_uri -Data $data
}
