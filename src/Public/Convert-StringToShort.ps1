function Convert-StringToShort {
    <#
    .SYNOPSIS
        returns an abreviate from the string you provide, try to get a 3 letter word
    .EXAMPLE
        PS> Get-ShortEnvironment -StringInput 'Test'
        tst
        PS>_

    .PARAMETER StringInput
        The string of the text file you'd like to make shorter
        If the word your provide is a well known one I try to make the best of it

    #>
    [CmdletBinding()]
    param (
        # this where you provide the string 
        [Parameter(Mandatory = $true)]
        [string]$StringInput
    )
    
    begin {
        # we do nothing here noting to initialise
    }
    
    process {
        if($StringInput.Length -gt 3 )
        {
            Switch ($StringInput)
            {
                "development"{ "dev" }
                "production"{ "prd" }
                "prod"      { "prd" }
                "testing"   { "tst" }
                "test"      { "tst" }
                "staging"   { "stg" }
                "testing"   { "tst" }
                "acceptance"{ "acc" }
                default     { ($StringInput.ToLower() -replace '[aeiouy]').SubString(0,3) }
            }
        }
        else 
        {
            Write-Host $StringInput.ToLower()
        }
    }
    
    end {
        # we do nothing here noting to cleanup
    }
}