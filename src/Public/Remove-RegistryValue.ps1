<#
.SYNOPSIS
    Removes a  value from the registry
.DESCRIPTION
    Removes a  value from the registry and returns true or false if successfull or not
.EXAMPLE
    PS C:\> Remove-Registry -Path "HKLM:\testkey" -Value "testValue"
    Removes the value testValue from HKLM:\testkey
.NOTES
    General notes
.OUTPUTS
    Boolean value which corresponds to the outcome
#>
function Remove-RegistryValue 
{
    param (
        # the path to the value
        [Parameter()]
        [string]
        $Path,

        # the name of the value
        [Parameter()]
        [string]
        $Value,

        # if should be logged to LogAnalytics
        [Parameter()]
        [switch]
        $Log
    )
    $PSDefaultParameterValues = $Global:PSDefaultParameterValues
    If(Test-Path $Path)
    {
        If(Test-RegistryValue -Path $Path -Value $RegistryValue)
        {
            try 
            {
                Remove-ItemProperty -Path $Path -Name $RegistryValue -ErrorAction Stop
                If($Log) { Send-ToLogAnalytics -message "Removed $Path in path $RegistryPath." }
            }
            catch 
            {
                If($Log) { Send-ToLogAnalytics -message "Could not remove $Path in path $RegistryPath. $($_.Exception) $($_.ErrorDetails)" }
            }
        }
    }
}