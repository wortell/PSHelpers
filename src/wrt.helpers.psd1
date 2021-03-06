
# Module manifest for module 'wrt.helpers'

# Generated by: Maurice de Jong

# Generated on: 04/04/2020


@{

    # Script module or binary module file associated with this manifest.
    RootModule           = 'wrt.helpers.psm1'

    # Version number of this module.

    ModuleVersion        = '1.0.8'

    # Supported PSEditions
    CompatiblePSEditions = 'Core', 'Desktop'

    # ID used to uniquely identify this module
    GUID                 = '30878e0b-9b7e-4aa6-84ff-aa019693cd25'

    # Author of this module
    Author               = 'Maurice de Jong'

    # Company or vendor of this module
    CompanyName          = 'Wortell Enterprise Security BV.'

    # Copyright statement for this module
    Copyright            = 'Copyright (c) 2020 Wortell Enterprise Security BV.'
    # https://opensource.stackexchange.com/questions/2121/mit-license-and-all-rights-reserved ??

    # Description of the functionality provided by this module
    Description          = 'This PowerShell module contains multiple helper functions to help reduce redundant code for our projects and day to day usage.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion    = '5.1'

    # Name of the PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = 'Amd64'

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules      = @(
    #     @{
    #         ModuleName    = ''
    #         ModuleVersion = ''
    #     }
    # )

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = @(
        'Add-ProductStates'
        'Deploy-CompressedFile',
        'Deploy-File',
        'Find-File',
        'Remove-RegistryKey',
        'Remove-RegistryValue',
        'Search-Registry',
        'Send-MessageToLocalUsers',
        'Send-ToLogAnalytics',
        'Test-IsProductEnabled',
        'Test-RegistryValue'
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport      = @()

    # Variables to export from this module
    # VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport      = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = @(
                'helper',
                'productstate',
                'registry'
            )

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/wortell/PSHelpers/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://wortell.github.io/PSHelpers/'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = 'Added Resolve-ProductState'

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}
