### Installing JDK without administrator privileges

```

set INSTALL=jdk-8u131-windows-x64.exe
set MYJDK=jdk1.8.0_131

7z.exe e %INSTALL% .rsrc\1033\JAVA_CAB9\110 .rsrc\1033\JAVA_CAB10\111

7z.exe e 110 -o%MYJDK%

7z.exe e 111
7z.exe x tools.zip -o%MYJDK%

del 110 111 tools.zip

for /r %MYJDK% %x in (*.pack) do %MYJDK%\bin\unpack200 -r "%x" "%~dx%~px%~nx.jar"

7z.exe a -tzip %MYJDK%.zip %MYJDK%

rmdir /q /s jdk1.8.0_131

```
