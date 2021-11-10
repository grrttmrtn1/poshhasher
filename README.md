# poshhasher

## parameters
$file - provide the file to get hash from or want to compare against provided hash

$folder - provide the folder to search within or want hash output from

$search - provide the hash that you're searching for

$hashType - defaults to "Both". Choices are "MD5","SHA256","Both". This sets which hash type to compare against.

##Examples

```
.\poshhasher.ps1 -search '2671285112C2582B2FD3D6D6A45E5B5E5CA29371CFB9D6A1360EB38709937EF4' -folder C:\Users\grrtt\Desktop -hashType SHA256
C:\Users\grrtt\Desktop\Amazon.txt matched SHA256 hash
```
```
.\poshhasher.ps1 -file C:\Users\grrtt\Desktop\Amazon.txt

SHA256                                                           MD5                              FileName
------                                                           ---                              --------
2671285112C2582B2FD3D6D6A45E5B5E5CA29371CFB9D6A1360EB38709937EF4 903429BEAA7FBEE8663345980993C1D5 C:\Users\grrtt\Desktop\Amazon.txt
```

```
.\poshhasher.ps1 -file C:\Users\grrtt\Desktop\Amazon.txt -hashType MD5

FileName                          MD5
--------                          ---
C:\Users\grrtt\Desktop\Amazon.txt 903429BEAA7FBEE8663345980993C1D5
```

```
.\poshhasher.ps1 -file C:\Users\grrtt\Desktop\Amazon.txt -hashType MD5 -search 903429BEAA7FBEE8663345980993C1D5
C:\Users\grrtt\Desktop\Amazon.txt matched MD5 hash
```
