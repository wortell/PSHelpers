Function Deploy-CompressedFile
{
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Url,
 
    [Parameter()]
    [string]
    $CorrelationId,

    # if should be logged to LogAnalytics
    [Parameter()]
    [switch]
    $Log
)   
    $PSDefaultParameterValues = $Global:PSDefaultParameterValues
    $ProgressPreference = "SilentlyContinue" 
    $targetPath = "$env:TEMP\{$correlationId}"
    $fullpathZip = "$env:TEMP\{$correlationId}.zip"
    try
    {
        Invoke-WebRequest $Url -OutFile $fullpathZip -ErrorAction Stop 
        If($Log) { Send-ToLogAnalytics -message "The compressed uninstall package from Azure Blob to the local computer, $fullpathZip" }
    }
    catch
    {
        If($Log) { Send-ToLogAnalytics -message "Uninstall package could not be downloaded $($_.Exception) $($_.ErrorDetails)" }
        return $false
    }
    
    try
    {
        Expand-Archive -Path $fullpathZip -DestinationPath $targetPath -Force -ErrorAction Stop
        If($Log) { Send-ToLogAnalytics -message "Extracted the compressed uninstall package to: $targetPath" }
    }
    catch
    {
        If($Log) { Send-ToLogAnalytics -message "Uninstall package could not be extracted $($_.Exception) $($_.ErrorDetails)" }
       return $false      
    }
    return $true
}
