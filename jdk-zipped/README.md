### Installing JDK without administrator privileges

Get the latest JDK installer & 7zip executables in a temp folder.

http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
http://www.7-zip.org/download.html or https://github.com/sudhaker/my-lab/tree/master/7zip

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

rmdir /q /s %MYJDK%

```

If running the above commands using a batch file, please change the unpack line as following

```
for /r %MYJDK% %%x in (*.pack) do %MYJDK%\bin\unpack200 -r "%%x" "%%~dx%%~px%%~nx.jar"
```

nJoy!
