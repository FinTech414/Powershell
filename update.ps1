
// Move files to temp location 
if {not exists folder "C:\Temp"}
	wait cmd.exe /C mkdir C:\Temp
endif

delete __createfile
createfile until _end_

#Define update criteria.

$Criteria = "IsInstalled=0 and Type='Software'"


#Search for relevant updates.

$Searcher = New-Object -ComObject Microsoft.Update.Searcher

$SearchResult = $Searcher.Search($Criteria).Updates


#Download updates.

$Session = New-Object -ComObject Microsoft.Update.Session

$Downloader = $Session.CreateUpdateDownloader()

$Downloader.Updates = $SearchResult

$Downloader.Download()


#Install updates.

$Installer = New-Object -ComObject Microsoft.Update.Installer

$Installer.Updates = $SearchResult

$Result = $Installer.Install()


_end_

delete update.ps1
copy __createfile update.ps1
delete "C:\Temp\update.ps1"
move update.ps1 "C:\Temp\update.ps1"
wait powershell.exe C:\Temp\update.ps1

