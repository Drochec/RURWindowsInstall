#Set-ExecutionPolicy Unrestricted -Scope CurrentUser

Write-Output "Odstran?n� p?edinstalovan�ch aplikac�`n"
Get-ChildItem -Recurse *.ps*1 | Unblock-File

.\Debloat-Windows-10-master\scripts\remove-default-apps.ps1
.\Debloat-Windows-10-master\scripts\remove-default-apps.ps1

Write-Output "P?id�v�m u�ivatele`n"
$adminpass = ConvertTo-SecureString "1357ruradmin" -AsPlainText -Force
$pass = ConvertTo-SecureString "chasmen" -AsPlainText -Force
New-LocalUser -Name "R.U.R. Admin" -Password $adminpass -PasswordNeverExpires
New-LocalUser -Name "R.U.R" -Password $pass -PasswordNeverExpires
Add-LocalGroupMember -Group "Administrators" -Member "R.U.R. Admin"
Add-LocalGroupMember -Group "Users" -Member "R.U.R"

Write-Output "Instaluji spr�vce bal�k?`n"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "Instaluji z�kladn� software`n"
choco install arduino microsoft-teams microsoft-teams.install microsoft-edge vscode googlechrome gimp vlc 7zip python

Write-Output "Instaluji Visual Studio"
./vs_community.exe --addProductLang Cs-cz --add Microsoft.VisualStudio.Workload.ManagedDesktop -p | Out-Null
#P?�d� ?esk� jazyk, nainstaluje bal�k pro v�voj desktop aplikac� .NET (Visual Basic, C#, atd.)

Write-Output "`n!Instalace dale pot?ebuj� potvrzen�!`n"

Write-Output "Instaluji Programovac� prost?ed� pro EV3`n"
./EV3.exe | Out-Null

Set-ExecutionPolicy Restricted -Force -Scope CurrentUser

Write-Output "V�echna instalace hotova aktivujte Windows a Office"
& '.\KMS Digital Online Activation Suite v7.5 ENG\KMS_Suite.cmd'

