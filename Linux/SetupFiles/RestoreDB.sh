cd /sqldb_backup/backup
echo "changed directory to " $PWD
rm -f *.bak
echo "removed .bak files."
rm -f *.7z
echo "removed .7z files."
cp /sqldb_backup/backups/* .
echo "copied all zip files to backup"
7z -y x "*.7z" -aos
echo "extracted all zip files"
/opt/mssql-tools/bin/sqlcmd -U sa -P Admin@12 -S 127.0.0.1 -i /SetupFiles/CreateDBScript.sql
echo "******************DB Creation Completed******************"
/opt/mssql-tools/bin/sqlcmd -U sa -P Admin@12 -S 127.0.0.1 -i /SetupFiles/RestoreDBScript.sql
echo "******************DB Restore Completed******************"