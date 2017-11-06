# IT-Glue-API-PowerShell-Wrapper
This PowerShell module acts as a wrapper for the IT Glue (http://itglue.com) API.

---

## Introduction

IT Glue's API offers the ability to read, create, and update much of the data within IT Glue's documentation platform. That includes organizations, contacts, configuration items, and more. Full documentation for IT Glue's RESTful API can be found [here](https://api.itglue.com/developer/).

This module serves to abstract away the details of interacting with IT Glue's API endpoints in such a way that is consistent with PowerShell nomenclature. This gives system administrators and PowerShell developers a convenient and familiar way of using IT Glue's API to create documentation scripts, automation, and integrations.


### Function Naming

IT Glue features a REST API that makes use of common HTTP(s) GET, POST, PUT, and DELETE actions. In order to maintain PowerShell best practices, only approved verbs are used. As such, the following mapping should be utilized:

- GET     -> Get-
- POST    -> New-
- PUT     -> Set-
- DELETE  -> Remove-

Additionally, PowerShell's `verb-noun` nomenclature is respected. Each noun is prefixed with `ITGlue` in an attempt to prevent any naming problems.

For example, one might access the `/users/` API endpoint by running the following PowerShell command with the appropriate parameters:

```posh
Get-ITGlueUsers
```

---

## Installation

One can manually download the Master branch and place the "ITGlueAPI" folder into the (default) `C:\Program Files\WindowsPowerShell\Modules` folder.

```posh
Import-Module ITGlueAPI
```


## Initial Setup

The first time you run this module, you will need to configure the base URI and API key that are used to talk with IT Glue. Doing so is as follows:

1. Run `Add-ITGlueBaseURI`. By default, IT Glue's `api.itglue.com` uri is entered. If you have your own API gateway or proxy, you may put in your own custom uri by specifiying the `-uri` parameter, as follows: `Get-ITGlueBaseURI -uri http://myapi.gateway.example.com`.

2. Run `Add-ITGlueAPIKey`. It will prompt you to enter your API key (please refer to IT Glue's documentation [here](https://api.itglue.com/developer/) for generating an API key).

3. [optional] If you would like the IT Glue module to remember your base uri and API key, you can run `Export-ITGlueModuleSettings`. This will create a config file at `%UserProfile%\ITGlueAPI` that securely holds this information. Next time you run `Import-Module`, this configuration will automatically be loaded. 

:warning: Exporting module settings encrypts your API key in a format that can **only be unencrypted with your Windows account**. It makes use of PowerShell's `System.Security.SecureString` type, which uses reversible encrypted tied to your principle. This means that you cannot copy your configuration file to another computer or user account and expect it to work.

:warning: Exporting and importing module settings requires use of the `ConvertTo-SecureString` cmdlet, which is currently unavailable in Linux and Mac PowerShell core ports. Until PS Core 6.0.0 is available, this functionality only works on Windows.


## Usage

Calling an API resource is as simple as running `Get-ITGlue<resourcename>`. The following is a table of supported functions and their corresponding API resources:

| API Resource             | Create                              | Read                                | Update                              | Delete                               |
| ------------------------ | ----------------------------------- | ----------------------------------- | ----------------------------------- | ------------------------------------ |
| Configuration Interfaces | `New-ITGlueConfigurationInterfaces` | `Get-ITGlueConfigurationInterfaces` | `Set-ITGlueConfigurationInterfaces` | -                                    |
| Configuration Statuses   | `New-ITGlueConfigurationStatuses  ` | `Get-ITGlueConfigurationStatuses`   | `Set-ITGlueConfigurationStatuses`   | -                                    |
| Configuration Types      | `New-ITGlueConfigurationTypes`      | `Get-ITGlueConfigurationTypes`      | `Set-ITGlueConfigurationTypes`      | -                                    |
| Configurations           | `New-ITGlueConfigurations`          | `Get-ITGlueConfigurations`          | `Set-ITGlueConfigurations`          | -                                    |
| Contact Types            | `New-ITGlueContactTypes`            | `Get-ITGlueContactTypes`            | `Set-ITGlueContactTypes`            | -                                    |
| Contacts                 | `New-ITGlueContacts`                | `Get-ITGlueContacts`                | `Set-ITGlueContacts`                | -                                    |
| Countries                | -                                   | `Get-ITGlueCountries`               | -                                   | -                                    |
| Favorite Organizations   | `New-ITGlueFavoriteOrganizations`   | `Get-ITGlueFavoriteOrganizations`   | -                                   | `Remove-ITGlueFavoriteOrganizations` |
| Flexible Asset Fields    | `New-ITGlueFlexibleAssetFields`     | `Get-ITGlueFlexibleAssetFields`     | `Set-ITGlueFlexibleAssetFields`     | `Remove-ITGlueFlexibleAssetFields`   |
| Flexible Asset Types     | `New-ITGlueFlexibleAssetTypes`      | `Get-ITGlueFlexibleAssetTypes`      | `Set-ITGlueFlexibleAssetTypes`      | -                                    |
| Flexible Assets          | `New-ITGlueFlexibleAssets`          | `Get-ITGlueFlexibleAssets`          | `Set-ITGlueFlexibleAssets`          | -                                    |
| Locations                | `New-ITGlueLocations`               | `Get-ITGlueLocations`               | `Set-ITGlueLocations`               | -                                    |
| Manufacturers            | `New-ITGlueManufacturers`           | `Get-ITGlueManufacturers`           | `Set-ITGlueManufacturers`           | -                                    |
| Models                   | `New-ITGlueModels`                  | `Get-ITGlueModels`                  | `Set-ITGlueModels`                  | -                                    |
| Operating Systems        | -                                   | `Get-ITGlueOperatingSystems`        | -                                   | -                                    |
| Organization Statuses    | `New-ITGlueOrganizationStatuses`    | `Get-ITGlueOrganizationStatuses`    | `Set-ITGlueOrganizationStatuses`    | -                                    |
| Organization Types       | `New-ITGlueOrganizationTypes`       | `Get-ITGlueOrganizationTypes`       | `Set-ITGlueOrganizationTypes`       | -                                    |
| Organizations            | `New-ITGlueOrganizations`           | `Get-ITGlueOrganizations`           | `Set-ITGlueOrganizations`           | -                                    |
| Platforms                | -                                   | `Get-ITGluePlatforms`               | -                                   | -                                    |
| Regions                  | -                                   | `Get-ITGlueRegions`                 | -                                   | -                                    |
| User Metrics             | -                                   | `Get-ITGlueUserMetrics`             | -                                   | -                                    |
| Users                    | -                                   | `Get-ITGlueUsers`                   | `Set-ITGlueUsers`                   | -                                    |

Note, table entries with `-` indicate that the functionality is not supported by the IT Glue API.

Each `Get-` function will respond with the raw data that IT Glue's API provides. Usually, this data has at least three sub-sections:
 - `data` - The actual information requested (this is what most people care about)
 - `links` - Links to specific aspects of the data
 - `meta` - Information about the number of pages of results are available and other metadata.
 
Each resource allows filters and parameters to be used to specify the desired output from IT Glue's API. Check out the wiki article on [Using Filters and Parameters](https://github.com/itglue/powershellwrapper/wiki/Using-Filters-and-Parameters).

A full list of functions can be retrieved by running `Get-Command -Module ITGlueAPI`. Help info and a list of parameters can be found by running `Get-Help <command name>`, such as:

```posh
Get-Help Get-ITGlueUsers
```

## Wiki :book:

For more information about using this module, as well as examples and advanced functionality, check out our [wiki](https://github.com/itglue/powershellwrapper/wiki/)!
