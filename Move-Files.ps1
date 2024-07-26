#Backup files to another location
#
#
#



$startingDirectory = "C:\"
$destinationDirectory = ""

function Get-Files{
    params(
        [Parameter(Mandatory=$true)]
        [String]$workingFileDirecotry
    )

    #get all files in directory
    $Items = Get-ChildItem -Path $workingFileDirectory -File
    
    #send files to upload
    foreach($item in $items){
        Backup-File -fileName $item.Name
    }
}

function Get-Folders{
    params(
        [Parameter(Mandatory=$true)]
        [String]$workingFolderDirectory
    )

    #get all folders in directory
    $Items = Get-ChildItem -Path $workingFolderDirecotry -Directory

    #send all files to backup
    #send all directories to be recursed
    foreach($item in $Items){
        Backup-Folder $item
        Get-Folders $item
        Get-Files $item
    }


}

function Backup-File{
    params(
        [Parameter(Mandatory=$true)]
        [String]$fileName 
    )

    #get full filepath
    #upload file

}


function Backup-Folder{
    params(
       [Parameter(Mandatory=$true)]
       [String]$folderName 
    )

        #check if folder exists in destination
        #if it doesn't create it
}