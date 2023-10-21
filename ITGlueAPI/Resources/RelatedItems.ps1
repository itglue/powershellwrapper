function New-ITGlueRelatedItems {
<#
    .SYNOPSIS
        Creates one or more related items

    .DESCRIPTION
        The New-ITGlueRelatedItems cmdlet creates one or more related items.

        The create action is directional from source item to destination item(s).

        The source item is the item that matches the resource_type and resource_id in the URL.

        The destination item(s) are the items that match the destination_type
        and destination_id in the JSON object.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER resource_type
        The resource type of the parent resource

        Allowed values:
        'checklists', 'checklist_templates', 'configurations', 'contacts', 'documents', `
        'domains', 'locations', 'passwords', 'ssl_certificates', 'flexible_assets', 'tickets'

    .PARAMETER resource_id
        The resource id of the parent resource.

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueRelatedItems -resource_type passwords -resource_id 8756309 -data $json_object

        Creates a new related password to the defined resource id with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#related-items-create

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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
<#
    .SYNOPSIS
        Updates a related item for a particular resource

    .DESCRIPTION
        The Set-ITGlueRelatedItems cmdlet updates a related item for
        a particular resource.

        Only the related item notes that are displayed on the
        asset view screen can be changed.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER resource_type
        The resource type of the parent resource

        Allowed values:
        'checklists', 'checklist_templates', 'configurations', 'contacts', 'documents', `
        'domains', 'locations', 'passwords', 'ssl_certificates', 'flexible_assets', 'tickets'

    .PARAMETER resource_id
        The resource id of the parent resource.

    .PARAMETER id
        The id of the related item

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueRelatedItems -resource_type passwords -resource_id 8756309 -id 12345 -data $json_object

        Updates the defined related item on the defined resource with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#related-items-update

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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
<#
    .SYNOPSIS
        Deletes one or more related items

    .DESCRIPTION
        The Remove-ITGlueRelatedItems cmdlet deletes one or more specified
        related items

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER resource_type
        The resource type of the parent resource

        Allowed values:
        'checklists', 'checklist_templates', 'configurations', 'contacts', 'documents', `
        'domains', 'locations', 'passwords', 'ssl_certificates', 'flexible_assets', 'tickets'

    .PARAMETER resource_id
        The id of the related item

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Remove-ITGlueRelatedItems -resource_type passwords -resource_id 8756309 -data $json_object

        Deletes the defined related item on the defined resource with the structured
        JSON object.

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#related-items-bulk-destroy

    .LINK
        https://github.com/itglue/powershellwrapper

#>

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
