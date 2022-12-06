function New-ITGlueRelatedItems {
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

    $resource_uri = ('/{0}/{1}/relationships/related_items' -f $resource_type, $resource_id)

    return Invoke-ITGlueRequest -Method POST -ResourceURI $resource_uri -Data $data
}

function Set-ITGlueRelatedItems {
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

    $resource_uri = ('/{0}/{1}/relationships/related_items/{2}' -f $resource_type, $resource_id, $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}

function Remove-ITGlueRelatedItems {
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

    $resource_uri = ('/{0}/{1}/relationships/related_items' -f $resource_type, $resource_id)

    return Invoke-ITGlueRequest -Method DELETE -ResourceURI $resource_uri -Data $data
}
