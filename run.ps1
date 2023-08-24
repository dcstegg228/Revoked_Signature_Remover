# Define the directory to check
$directoryPath = "C:\path\To\Your\Messed\Up\Program\Root\Folder"

# Path to signtool.exe
$signtoolPath = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\signtool.exe"

function Remove-Signature($filePath) {
    & $signtoolPath remove /s $filePath
    if ($?) {
        Write-Output "Successfully removed signature from: $filePath"
    } else {
        Write-Output "Failed to remove signature from: $filePath"
    }
}

$files = Get-ChildItem -Path $directoryPath -Recurse -File 

foreach ($file in $files) {
    try {
        $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $file.FullName

        # If we have a null certificate or missing thumbprint, it's likely not signed
        if ($null -eq $cert -or $null -eq $cert.Thumbprint) {
            continue
        }

        $chain = New-Object System.Security.Cryptography.X509Certificates.X509Chain
        $isChainValid = $chain.Build($cert)

        if ($isChainValid) {
            continue
           
        }
        if ($chain.ChainStatus.status -contains "Revoked") {
            Remove-Signature $file.FullName
        }
    } catch {
        continue
    }
}