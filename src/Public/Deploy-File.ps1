function Deploy-File
{
    [CmdletBinding()]
    param (
        # Url of the location of the script
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
    $targetPath = "$env:TEMP\{$correlationId}"
    
    try 
    {
        #Invoke-WebRequest $item -OutFile $($targetPath + $item.Split('/')[-1]) -ErrorAction Stop
        $outFile = $($targetPath + "\$correlationId.ps1")
        Invoke-WebRequest $Url -OutFile $outFile -ErrorAction Stop
        If($Log) { Send-ToLogAnalytics -message "PS1File is downloaded." }
        return $outFile     
    }
    catch {
        If($Log) { Send-ToLogAnalytics -message "Could not download PS1File. $($_.Exception) $($_.ErrorDetails)"  }
        return $false               
    }
}