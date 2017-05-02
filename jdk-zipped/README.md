### Installing JDK without administrator privileges



`7z.exe e jdk-8u131-windows-x64.exe .rsrc\1033\JAVA_CAB9\110 .rsrc\1033\JAVA_CAB10\111`

`7z.exe e 110 -ojdk1.8.0_131`

`7z.exe e 111`
`7z.exe x tools.zip -ojdk1.8.0_131`

`del 110 111 tools.zip`

`for /r %x in (*.pack) do jdk1.8.0_131\bin\unpack200 -r "%x" "%~dx%~px%~nx.jar"`

`7z.exe a -tzip jdk1.8.0_131.zip jdk1.8.0_131`

