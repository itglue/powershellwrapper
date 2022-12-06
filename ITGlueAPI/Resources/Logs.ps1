function Get-ITGlueLogs {
<#
    .SYNOPSIS
        Get all activity logs of the account for the most recent 30 days.

    .DESCRIPTION
        The Get-ITGlueLogs cmdlet gets all activity logs of the account for the most recent 30 days.

        This endpoint is limited to 5 pages of results. If more results are desired,
        setting a larger page [size] will increase the number of results per page.

        To iterate over even more results, use filter [created_at] (with created_at sort)
        to fetch a subset of results based on timestamp, then use the last timestamp
        in the last page the start date in the filter for the next request.

    .PARAMETER sort
        Sort the order of the returned data

        Allowed values:
        'created_at','-created_at'

    .PARAMETER page_number
        The page number to return data from

        This endpoint is limited to 5 pages of results.

    .PARAMETER page_size
        The number of results to return with each page

        By default ITGlues API returned the first 50 items.

        Allowed values:
        1 - 1000

    .EXAMPLE
        Get-ITGlueLogs

        Pulls the first 50 activity logs from the last 30 days with data
        being sorted newest to oldest.

    .EXAMPLE
        Get-ITGlueLogs -sort -created_at

        Pulls the first 50 activity logs from the last 30 days with data
        being sorted oldest to newest.

    .EXAMPLE
        Get-ITGlueLogs -page_number 2

        Pulls the first 50 activity logs starting from page 2 from the last 30 days
        with data being sorted newest to oldest.

    .NOTES
        As of 2022-11
            Need to add in the "filter[created_at]" parameter

    .LINK
        https://api.itglue.com/developer/#logs

    .LINK
        https://github.com/itglue/powershellwrapper

#>

        [CmdletBinding(DefaultParameterSetName = 'index')]
        Param (
            [Parameter(ParameterSetName = 'index')]
            [ValidateSet( 'created_at','-created_at' )]
            [String]$sort = '',

            [Parameter(ParameterSetName = 'index')]
            [Nullable[Int64]]$page_number = $null,

            [Parameter(ParameterSetName = 'index')]
            [ValidateRange ( 1, 1000 )]
            [Nullable[int]]$page_size = $null
        )

        $resource_uri = '/logs'

        $filter_list = @{}

        if ($PSCmdlet.ParameterSetName -eq 'index') {
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
