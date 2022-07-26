Write-Host "Fetching Details : http://169.254.169.254/metadata/instance?api-version=2021-02-01 " -ForegroundColor Yellow

try {
    $Result = Invoke-WebRequest -Headers @{"Metadata"="true"} -Method GET -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01" -ErrorAction Stop

    if (![string]::IsNullOrEmpty($Result.Content)) {
        Write-Host "Json Result: " -ForegroundColor Cyan
        Write-Host "$Result"
        Write-Host ""
        Write-Host "OS Name is $(($Result.Content | ConvertFrom-Json).compute.name)" -ForegroundColor Green
        Write-Host "OS Name is $(($Result.Content | ConvertFrom-Json).compute.offer)" -ForegroundColor Green    
    }
    else {
        Write-Host "Blank Report" -ForegroundColor Cyan        
    }
}

catch {
    Write-Host "Error : $_" -ForegroundColor Red

}