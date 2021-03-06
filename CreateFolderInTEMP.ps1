#Description: Create a folder in temp, create a log file name it, add a line with date as a prefix.
#Author: Ashwani k
#Version History: 1.0
#Date: 30/April/2018

# ----------------DECLARE GLOBAL VARIABLES AND CONSONANTS-----------------------

$SCRIPT_DIR = split-path -parent $MyInvocation.MyCommand.Definition
$LOG_DIR = "$env:systemdrive\temp\PsLogs"
$LOG_FILENAME = "Log$(Get-Date -Format yyyyMMdd).log"
$LOG_FILE = "$Logdir\$Logfilename"
$TIMESTAMP = "[$(Get-Date -Format yyyy-MM-dd$([char]32)HH:mm:ss)]"

# ----------------FUNCTIONS LIBRARY-----------------------------------

function Write-Log {
  param(
        [string]$msg, 
        [string]$type="LOG"
       )
  Out-File -FilePath $LOG_FILE -InputObject "$Timestamp [$type] $msg"  -Append 
}


# ----------------MAIN SCRIPT-----------------------------------

$server_name = "VM00002413"
$server_name = $server_name.tolower()



if(-not (Test-Path $LOG_DIR)){New-Item -Path $LOG_DIR -ItemType directory -Force}

if(-not (Test-Path $LOG_FILE)){New-Item -ItemType file -Path $LOG_FILE}

#Step 1 : collecting service info from a target server

$target_server = "192.189.09.09"

write-log "Trying to connect the service data from the $target_server"

try{
     Invoke-Command -ComputerName $target_server -ScriptBlock {Get-Service} -ErrorAction stop

}
catch{
    write-log -msg "Issue occured while connecting a remote server $target_server" -type ERROR
}

# ----------------OUTPUT STARTS HERE---------------------------------------------




