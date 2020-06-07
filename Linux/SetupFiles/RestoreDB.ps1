function check7zInstalled{
$7Zip = $true;
try {
$7ZipPath = Resolve-Path -Path ((Get-Item -Path HKLM:\SOFTWARE\7-Zip -ErrorAction SilentlyContinue).GetValue("Path") + '\7z.exe');
Write-Host "7z alredy Installed.." $7ZipPath
Write-Host "Restoring db..." 
restoreDb
}
catch {
Write-Host "7z Not Installed.."
Write-Host "Installing 7z..."
./Download7z.ps1
Write-Host "7z Installation done..."
Write-Host "Restoring db..."
restoreDb
}
}

function restoreDb{
del c:/sqldb_backup/backup/*.bak
Write-Host "******************Removed .bak files.******************"
del c:/sqldb_backup/backup/*.7z
Write-Host "******************Removed .7z files.******************"
copy c:/sqldb_backup/backups/* /sqldb_backup/backup
Write-Host "******************Copied all zip files to backup.******************"
cd 'C:\Program Files\7-Zip\'
Write-Host "******************Extracting all files.******************"
.\7z.exe -y x C:\sqldb_backup\backup\*.7z -oC:\sqldb_backup\backup\ *.*
Write-Host "******************Extracton done. Starting DB Creation.******************"""
cd 'C:\SetupFiles'
sqlcmd -S 127.0.0.1 -E -d master -i .\CreateDBScript.sql
Write-Host "******************DB Creation completed******************"
sqlcmd -S 127.0.0.1 -E -d master -i .\RestoreDBScript.sql
"******************DB Restore Completed******************"
}
check7zInstalled