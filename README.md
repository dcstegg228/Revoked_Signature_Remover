# Revoked_Signature_Remover
Removes revoked digital signatures using signtool.exe from the Windows SDK. This will allow you to run old or broken software with revoked signatures. 


Requirements:

Windows 8 SDK or higher
.Net Framework 4.0 Developer PAck or higher

https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/
https://dotnet.microsoft.com/en-us/download/dotnet-framework/net48

Instructions:

Edit the run.ps1 file $directoryPath with your target folder.
Edit the run.ps1 file $signtoolPath with the path to signtool.exe


