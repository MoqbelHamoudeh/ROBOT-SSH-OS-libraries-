*** Settings ***
Library            SSHLibrary
Library         OperatingSystem
Suite Setup            Open Connection And Log In
Suite Teardown         Close All Connections


*** Variables ***
${HOST}                test.rebex.net
${USERNAME}            demo
${PASSWORD}            password

*** Keywords ***
Open Connection And Log In
   Open Connection              ${HOST}
   Login                  ${USERNAME}       ${PASSWORD}

*** Test Cases ***


list all files in a directory
   ${output}=    SSHLibrary.List Files In Directory      /
        log to console      ${output}
download files
   ${output}=    SSHLibrary.Get File    /pub/example/KeyGeneratorSmall.png         C:\\test\\test.png
   log      ${output}

validation to check if the file is downloaded on my device
        OperatingSystem.File Should Exist        C:\\test\\test.png

Delete the downloaded file
    Remove File        C:\\test\\test.png
#    check if the file is removed
    OperatingSystem.File Should Not Exist   C:\\test\\test.png


Creating a file
    ${file}=   create file     C:\\test\\test2.txt
    OperatingSystem.File Should Exist       C:\\test\\test2.txt
    log to console         ${file}

Copying a file

    ${output}=      Copy File	    C:\\test\\test2.txt         C:\\newTest\\newfile.txt
    log to console     ${output}

Delete directory
    ${delete_directory}=    OperatingSystem.Empty Directory         C:\\test\\
    log to console  ${delete_directory}

close all connections
    close all connections








