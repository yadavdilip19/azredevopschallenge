function Get-KeyValue {

    param (
        [Parameter(Mandatory = $True)]
        [string]$StringInput
        
    )
    
    ### Formatting Json string to correct format
    $StringInput = $StringInput | ConvertFrom-Json | ConvertTo-Json -Compress -Depth 100
    
    ### initializing result object

    $Resultobject = "" | select keys, value

    ### formatting input string
    $FormattedStringArray = $StringInput -replace "{", "" -replace "}", "" -replace "`"","" -replace " ","" -split ":".Trim() | where {![string]::IsNullOrWhiteSpace($_) -and $_ -ne $null}
    
    $Resultobject.keys = $($FormattedStringArray[0..$($FormattedStringArray.Length - 2)]) -join "/"
    $Resultobject.value = $($FormattedStringArray[$FormattedStringArray.Length - 1])

    Return $Resultobject
     
}



#Input
$input_ = '{"a":{"b":{"c":{"z":"y"}}}}'


#Calling Function and passing input
Get-KeyValue -StringInput $input_