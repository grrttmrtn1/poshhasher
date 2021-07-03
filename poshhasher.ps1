$algorithm = 'Both'
$file = 'C:\Users\grrtt\Desktop\CarParts.xlsx'

if ($algorithm -eq 'Both') {
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
        $algorithm = (Get-FileHash -Algorithm $algorithm -Path $file).Hash
    }
    $Object
}


#Get-ChildItem -Path C:\Users\grrtt\Desktop | % {Get-FileHash -Algorithm MD5 -Path $_.Fullname; Get-FileHash -Algorithm SHA256 -Path $_.FUllName}
#Get-ChildItem -Path C:\Users\grrtt\Desktop -Recurse | Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}} | Format-Table
Get-ChildItem -Path C:\Users\grrtt\Desktop -Recurse -File| Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}} | Format-Table



if ((Get-ChildItem -Path C:\Users\grrtt\Desktop -Recurse -File| Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}}).MD5 -eq '903429BEAA7FBEE8663345980993C1D5') {
    Write-Host $_.FullName
}


Get-ChildItem -Path C:\Users\grrtt\Desktop -Recurse -File| Where {! $_.PSIsContainer} |Select-Object @{name='FileName';Expression={($_.FullName)}}, @{Name='MD5';Expression={(Get-FileHash $_.FullName -Algorithm MD5).Hash}}, @{Name='SHA256';Expression={(Get-FileHash $_.FullName -Algorithm SHA256).Hash}} | where {$_.MD5 -eq 'test' -or $_.SHA256 -eq '2671285112C2582B2FD3D6D6A45E5B5E5CA29371CFB9D6A1360EB38709937EF4'}
