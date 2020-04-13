function Add-ProductStates {
<#
.SYNOPSIS
    Adds statuses to a product PSObject.

.DESCRIPTION
    Adds statuses to a product PSObject. If this function is used 
    in a command pipeline it will add properties to the resulting PSObject containing boolean properties. These properties reflect 
    status of Product Enablement and if it is updated. These values are calculated using the State DWORD using bitfields. 

.PARAMETER ProductState
    The value (DWORD) containing the bitflags.

.PARAMETER Products
    PSObject containing object array of Microsoft.Management.Infrastructure.CimInstance#ROOT/SecurityCenter2/AntiVirusProduct

.EXAMPLE
    PS C:\Users\maurice> Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Add-ProductStates

    enabled                  : True
    displayName              : Trend Micro Antivirus+
    instanceGuid             : {AFEE279F-FAE7-BAEE-3A88-4BF7277B8551}
    pathToSignedProductExe   : C:\Program Files\Trend Micro\Titanium\TmWscSvc\wschandler.exe
    pathToSignedReportingExe : C:\Program Files\Trend Micro\Titanium\TmWscSvc\WSCStatusController.exe
    productState             : 266240
    timestamp                : Sun, 12 Apr 2020 15:09:56 GMT
    PSComputerName           : 

    enabled                  : True
    displayName              : Sophos Home
    instanceGuid             : {FFADE7EA-DC92-4602-D6B2-626CD3450A0F}
    pathToSignedProductExe   : C:\Program Files (x86)\Sophos\Sophos Anti-Virus\WSCClient.exe
    pathToSignedReportingExe : C:\Program Files (x86)\Sophos\Sophos Anti-Virus\WSCClient.exe
    productState             : 331776
    timestamp                : Sun, 12 Apr 2020 15:18:39 GMT
    PSComputerName           : 

    enabled                  : False
    displayName              : Windows Defender
    instanceGuid             : {D68DDC3A-831F-4fae-9E44-DA132C1ACF46}
    pathToSignedProductExe   : windowsdefender://
    pathToSignedReportingExe : %ProgramFiles%\Windows Defender\MsMpeng.exe
    productState             : 393472
    timestamp                : Sun, 12 Apr 2020 15:08:57 GMT
    PSComputerName           : 

.EXAMPLE
    PS C:\Users\maurice> $products = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct
    PS C:\Users\maurice> Add-ProductStates -Products $products

    enabled                  : True
    displayName              : Trend Micro Antivirus+
    instanceGuid             : {AFEE279F-FAE7-BAEE-3A88-4BF7277B8551}
    pathToSignedProductExe   : C:\Program Files\Trend Micro\Titanium\TmWscSvc\wschandler.exe
    pathToSignedReportingExe : C:\Program Files\Trend Micro\Titanium\TmWscSvc\WSCStatusController.exe
    productState             : 266240
    timestamp                : Sun, 12 Apr 2020 15:09:56 GMT
    PSComputerName           : 

    enabled                  : True
    displayName              : Sophos Home
    instanceGuid             : {FFADE7EA-DC92-4602-D6B2-626CD3450A0F}
    pathToSignedProductExe   : C:\Program Files (x86)\Sophos\Sophos Anti-Virus\WSCClient.exe
    pathToSignedReportingExe : C:\Program Files (x86)\Sophos\Sophos Anti-Virus\WSCClient.exe
    productState             : 331776
    timestamp                : Sun, 12 Apr 2020 15:18:39 GMT
    PSComputerName           : 

    enabled                  : False
    displayName              : Windows Defender
    instanceGuid             : {D68DDC3A-831F-4fae-9E44-DA132C1ACF46}
    pathToSignedProductExe   : windowsdefender://
    pathToSignedReportingExe : %ProgramFiles%\Windows Defender\MsMpeng.exe
    productState             : 393472
    timestamp                : Sun, 12 Apr 2020 15:08:57 GMT
    PSComputerName           : 

.EXAMPLE
    PS C:\Users\maurice> (Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct)[0].productState | Add-ProductStates

    enabled : True

.EXAMPLE
    PS C:\Users\maurice> $prodState = (Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct)[0].productState
    PS C:\Users\maurice> Add-ProductStates -ProductState $prodState

    enabled : True

.NOTES
    This function utilizes Test-IsProductEnabled, ... To enrich information on State.
#>
    [CmdletBinding()]
    param (
        # This parameter can be passed from pipeline and can contain and array of collections that contain State or productstate members
        [Parameter(ValueFromPipeline)]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $Products,
        # Product State contains a value (DWORD) that contains multiple bitflags and we use the productState flag (0000F000)
        [Parameter(Position = 0, ValueFromPipelineByPropertyName, ValueFromPipeline, HelpMessage = "The value (DWORD) containing the bitflags.")]
        [Alias("STATE")]
        [UInt32]$ProductState
    )

    begin {
        $results = $null
    }
    
    process {
        If ($Products -is [array]) {
            If ($Products.Count -gt 0) {
                If (Get-Member -inputobject $Products[0] -name "productState" -Membertype Properties) {
                    $results += $Products.PSObject.Copy()
                    foreach ($item in $Products) {
                        If($results.Where({$_.instanceGuid -eq $item.instanceGuid}).Properties.name -notmatch "state") {                       
                            $results.Where({$_.instanceGuid -eq $item.instanceGuid}) | 
                                Add-Member -NotePropertyName state -NotePropertyValue $([ProductState]($item.productState -band [ProductFlags]::ProductState))
                        }
                        else {
                            Write-Error 'Could not add state property it already exists...'
                        }
                        If($results.Where({$_.instanceGuid -eq $item.instanceGuid}).Properties.name -notmatch "signatureStatus") {                       
                            $results.Where({$_.instanceGuid -eq $item.instanceGuid}) | 
                                Add-Member -NotePropertyName signatureStatus -NotePropertyValue $([SignatureStatus]($item.productState -band [ProductFlags]::SignatureStatus))
                        }
                        else {
                            Write-Error 'Could not add signatureStatus property it already exists...'
                        }
                    }
                }
            }
        }
        If ($ProductState -and (-not $Products)) {
            If($results.Properties.name -notmatch "enabled") {
                $results += New-Object PSObject -Property @{
                        state = $([ProductState]($item.productState -band [ProductFlags]::ProductState))
                        signatureStatus = $([SignatureStatus]($item.productState -band [ProductFlags]::SignatureStatus))
                }
            }
        }
    }
    
    end {
        If($results) {
            return $results
        }
    }
}