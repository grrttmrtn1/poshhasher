param (
    [string]$file, 
    [string]$folder,   
    [string]$search,
    [ValidateSet("MD5","SHA256","Both")]
    [string]$hashType = "Both",
    [ValidateSet($false, $true)]
    [bool]$verbose = $false,
    [ValidateSet($false, $true)]
    [bool]$recursive = $true,
    [ValidateSet($false, $true)]
    [bool]$debug = $false
)


if ([string]::IsNullOrWhiteSpace($search))
{
    if (![string]::IsNullOrWhiteSpace($file))
    {
        if ($hashType -eq 'Both') {
            $Object = New-Object PSObject -Property @{
                FileName = $file
                MD5 = (Get-FileHash -Algorithm MD5 -Path $file).Hash
                SHA256 = (Get-FileHash -Algorithm SHA256 -Path $file).Hash
                }
                $Object
        }
        else {
            $Object = New-Object PSObject -Property @{ 
                FileName = $file
                $hashType = (Get-FileHash -Algorithm $hashType -Path $file).Hash
            }
            $Object
        }
    }
    elseif (![string]::IsNullOrWhiteSpace($folder))
    {
        if ($hashType -eq 'Both') 
        {
            Get-ChildItem -Path $folder -Recurse -File| Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}}
        }
        else 
        {
            Get-ChildItem -Path $folder -Recurse -File| % {Get-FileHash $_.Fullname -Algorithm $hashType}
        }
    }
    else 
    {
        throw 'Not enough input to arguments. Need a folder(-folder) or file(-file)'
    }
}
else
{
    if (![string]::IsNullOrWhiteSpace($file))
    {
        if ($hashType -eq 'Both') 
        {
            if ((Get-FileHash -Algorithm SHA256 -Path $file).Hash -eq $search) 
            {
                Write-Host "$($file) matched SHA256 hash"
            }
            elseif ((Get-FileHash -Algorithm MD5 -Path $file).Hash -eq $search)
            {
                Write-Host "$($file) matched MD5 hash"
            }
            else
            {
                Write-Host "$($file) did not match hash provided"
            }
        }
        else 
        {
            if ((Get-FileHash -Algorithm $hashType -Path $file).Hash -eq $search)
            {
                Write-Host "$($file) matched $($hashType) hash"
            }
            else 
            {
                Write-Host "$($file) did not match hash provided"
            }
        }
    }
    elseif (![string]::IsNullOrWhiteSpace($folder))
    {
        if ($hashType -eq 'Both') 
        {
            
        }
        else 
        {
            
        }
    }
    else 
    {
        throw 'Not enough input to arguments. Need a folder(-folder) or file(-file)'
    }
}


#Get-ChildItem -Path C:\Users\grrtt\Desktop | % {Get-FileHash -Algorithm MD5 -Path $_.Fullname; Get-FileHash -Algorithm SHA256 -Path $_.FUllName}
#Get-ChildItem -Path C:\Users\grrtt\Desktop -Recurse | Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}} | Format-Table
#Get-ChildItem -Path C:\Users\grrtt\Desktop -Recurse -File| Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}} | Format-Table



#if ((Get-ChildItem -Path C:\Users\grrtt\Desktop -Recurse -File| Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}}).MD5 -eq '903429BEAA7FBEE8663345980993C1D5') {
#    Write-Host $_.FullName
#}

#this was working
#Get-ChildItem -Path C:\Users\grrtt\Desktop -Recurse -File| Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}} | where {$_.MD5 -eq 'test' -or $_.SHA256 -eq '2671285112C2582B2FD3D6D6A45E5B5E5CA29371CFB9D6A1360EB38709937EF4'}
