#==========================================================================================================
# Remove-MostFiles
# ---------------------------------------------------------------------------------------------------------
# RH Updates: 
# 22/07/10 Creation
#==========================================================================================================


# ---------------------------------------------------------------------------------------------------------
# Delete oldest files in a directory but keep a specified number of file (the newest)
# Pass the folder path, the file extenstion keep, number of files to retain 
# For example the following will look into C:\temp folder and keep 2 of the newest files with *.svclog extension
# "C:\temp" "*.svclog" 2
# ---------------------------------------------------------------------------------------------------------
function Remove-MostFiles
{
    if($args.Count -ne 3)
    {
        throw "Incorrect number of arguments passed to function"    
    }

    $backuplocationpath = $args[0]
    $fileExtensionToInclude = $args[1] 
    $fileCountToKeep = $args[2]

    # sort files by modified date and then delete all but the number specified, so left with the 2 newest 
    get-childitem $backuplocationpath -include $fileExtensionToInclude -recurse | sort-object -descending LastWriteTime | select-object -skip $fileCountToKeep | remove-item -force
}

export-modulemember -function Remove-MostFiles
