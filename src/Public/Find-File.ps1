Function Find-File
{
    [CmdletBinding()]
    param (
        
        # Specifies a path to one location. Unlike the Path parameter, the value of the LiteralPath parameter is
        # used exactly as it is typed. No characters are interpreted as wildcards. If the path includes escape characters,
        # enclose it in single quotation marks. Single quotation marks tell Windows PowerShell not to interpret any
        # characters as escape sequences.
        [Parameter(Mandatory=$true,
                   Position=0,
                   ParameterSetName="LiteralPath",
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="Literal path to one location.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string]
        $LiteralPath,

        #filename to search recursively in LiteralPath for
        [Parameter()]
        [string]
        $filename,

        # if should be logged to LogAnalytics
        [Parameter()]
        [switch]
        $Log
    )
    $PSDefaultParameterValues = $Global:PSDefaultParameterValues
    try 
    {
        $filefound = Get-ChildItem -Path $LiteralPath -Filter $filename -Recurse -ErrorAction Stop
        $result = $filefound[0].FullName
    }
    catch 
    {
        If($Log) { Write-LogAnalyticsMessage -message "Could not locate $filename in $LiteralPath " }
    }
    return $result
}