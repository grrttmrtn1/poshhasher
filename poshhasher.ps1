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
            $getHashes = Get-ChildItem -Path $folder -Recurse -File| Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}} | where {$_.MD5 -eq $search -or $_.SHA256 -eq $search}
            if ($getHashes -eq $null) 
            {
                Write-Host "No files matched the hash provided in $($folder)"
            }
            else 
            {
                if ($search -eq $getHashes.MD5) 
                {
                    $hashMatched = 'MD5'
                }
                else 
                {
                    $hashMatched = 'SHA256'
                }
                Write-Host "$($getHashes.FileName) matched $($hashMatched) hash"
            }
        }
        else 
        {
            $getHashes = Get-ChildItem -Path $folder -Recurse -File| Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name=$hashType;Expression={(Get-FileHash $_.FullName -Algorithm $hashType).Hash}} | where {$_.$hashType -eq $search}
            if ($getHashes -eq $null)
            {
                Write-Host "No files matched the hash provided in $($folder)"
            }
            else 
            {
                Write-Host "$($getHashes.FileName) matched $($hashType) hash"
            }
        }
    }
    else 
    {
        throw 'Not enough input to arguments. Need a folder(-folder) or file(-file)'
    }
}
