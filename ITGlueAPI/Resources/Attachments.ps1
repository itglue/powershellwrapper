function New-ITGlueAttachments {
<#
    .SYNOPSIS
        Adds an attachment to one or more assets

    .DESCRIPTION
        The New-ITGlueAttachments cmdlet adds an attachment
        to one or more assets

        Attachments are uploaded by including media data on the asset the attachment
        is associated with. Attachments can be encoded and passed in JSON format for
        direct upload, in which case the file has to be strict encoded.

        Note that the name of the attachment will be taken from the file_name attribute
        placed in the JSON body.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER resource_type
        The resource type of the parent resource

        Allowed values:
        'checklists', 'checklist_templates', 'configurations', 'contacts', 'documents',
        'domains', 'locations', 'passwords', 'ssl_certificates', 'flexible_assets', 'tickets'

    .PARAMETER resource_id
        The resource id of the parent resource.

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        New-ITGlueAttachments -resource_type passwords -resource_id 8756309 -data $json_object

        Creates an attachment to a password with the defined id using the structured JSON object

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#attachments-create

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

    $resource_uri = ('/{0}/{1}/relationships/attachments' -f $resource_type, $resource_id)

    return Invoke-ITGlueRequest -Method GET -ResourceURI $resource_uri -Data $data

}



function Set-ITGlueAttachments {
<#
    .SYNOPSIS
        Updates the details of an existing attachment

    .DESCRIPTION
        The Set-ITGlueAttachments cmdlet updates the details of
        an existing attachment

        Only the attachment name that is displayed on the asset view
        screen can be changed.

        The original file_name can't be changed.

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER resource_type
        The resource type of the parent resource

        Allowed values:
        'checklists', 'checklist_templates', 'configurations', 'contacts', 'documents',
        'domains', 'locations', 'passwords', 'ssl_certificates', 'flexible_assets', 'tickets'

    .PARAMETER resource_id
        The resource id of the parent resource.

    .PARAMETER id
        The resource id of the existing attachment

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Set-ITGlueAttachments -resource_type passwords -resource_id 8756309 -id 8756309 -data $json_object

        Updates an attachment to a password with the defined id using the structured JSON object

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#attachments-update

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

    $resource_uri = ('/{0}/{1}/relationships/attachments/{2}' -f $resource_type, $resource_id, $id)

    return Invoke-ITGlueRequest -Method PATCH -ResourceURI $resource_uri -Data $data
}



function Remove-ITGlueAttachments {
<#
    .SYNOPSIS
        Deletes one or more specified attachments

    .DESCRIPTION
        The Remove-ITGlueAttachments cmdlet deletes one
        or more specified attachments

        Examples of JSON objects can be found under ITGlues developer documentation
            https://api.itglue.com/developer

    .PARAMETER resource_type
        The resource type of the parent resource

        Allowed values:
        'checklists', 'checklist_templates', 'configurations', 'contacts', 'documents',
        'domains', 'locations', 'passwords', 'ssl_certificates', 'flexible_assets', 'tickets'

    .PARAMETER resource_id
        The resource id of the parent resource.

    .PARAMETER data
        JSON object or array depending on bulk changes or not

    .EXAMPLE
        Remove-ITGlueAttachments -resource_type passwords -resource_id 8756309 -data $json_object

        Using the defined JSON object this deletes an attachment from a
        password with the defined id

    .NOTES
        N\A

    .LINK
        https://api.itglue.com/developer/#attachments-bulk-destroy

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

    $resource_uri = ('/{0}/{1}/relationships/attachments' -f $resource_type, $resource_id)

    return Invoke-ITGlueRequest -Method DELETE -ResourceURI $resource_uri -Data $data
}
