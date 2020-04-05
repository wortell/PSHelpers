<#
.SYNOPSIS
Compare PS Objects and return them with a clear equality sign
.DESCRIPTION
This function is used for comparison to see if an object needs to be updated
.PARAMETER ReferenceObject
Reference object is the data of the object as present or persistent
.PARAMETER DifferenceObject
Difference object is data that is or is expected to be altered
.EXAMPLE
Compare-PSObject -ReferenceObject $PSObject1  -ReferenceObject $PSObject2
.NOTES
NAME: Compare-PSObject
#>

function Compare-PSObject {

    [CmdletBinding()]
    param (
        # Reference value is the Online available
        [Parameter(Mandatory)]
        [psobject]$ReferenceObject,

        # Difference  template is the template that will be uploaded
        [Parameter(Mandatory)]
        [psobject]$DifferenceObject
    )

    process {
        $objprops = $ReferenceObject | Get-Member -MemberType Property, NoteProperty | ForEach-Object Name
        $objprops += $DifferenceObject | Get-Member -MemberType Property, NoteProperty | ForEach-Object Name
        $objprops = $objprops | Sort-Object -Unique | Select-Object

        $diffs = @()

        foreach ($objprop in $objprops) {
            $diff = Compare-Object $ReferenceObject $DifferenceObject -Property $objprop
            if ($diff) {
                $diffprops = @{
                    PropertyName = $objprop
                    RefValue     = ($diff | Where-Object { $_.SideIndicator -eq '<=' } | ForEach-Object $($objprop))
                    DiffValue    = ($diff | Where-Object { $_.SideIndicator -eq '=>' } | ForEach-Object $($objprop))
                }
                $diffs += New-Object PSObject -Property $diffprops
            }
        }
        if ($diffs) {
            return ($diffs | Select-Object PropertyName, RefValue, DiffValue)
        }
    }
}