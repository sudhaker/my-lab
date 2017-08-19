#include <Constants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#Include <Array.au3>

$puttyBin = "C:\Program Files (x86)\PuTTY\PUTTY.EXE"
$filezillaBin = "C:\Program Files\FileZilla FTP Client\filezilla.exe"

If Not FileExists($puttyBin) Then
    MsgBox(4096, "PuTTY", "Does not exist")
    Exit(1)
EndIf

If Not FileExists($filezillaBin) Then
    MsgBox(4096, "FileZilla", "Does not exist")
    Exit(1)
EndIf

;ShellExecute("ssh-keys\id_rsa.ppk")

$UserPwd = ""
;$UserPwd = InputBox ("Enter password", "Please enter your password","","*",180,120)

$totalCount = 8 + 5 + 6 + 14 + 7

; Server, ENV, Func, Node, User, , ,
Local $Servers[$totalCount][9] = [ _
    ["192.168.20.225",  "LAB",      "centos-sudhaker",  "",     "sudhaker", "", "", ""], _
    ["192.168.20.225",  "LAB",      "centos-root",  "",     "root", "", "", ""], _
    ["192.168.20.41",   "LAB",      "build",    "1",    "sudhaker", "", "", ""], _
    ["192.168.20.42",   "LAB",      "build",    "2",    "sudhaker", "", "", ""], _
    ["192.168.20.43",   "LAB",      "build",    "3",    "sudhaker", "", "", ""], _
    ["192.168.20.21",   "LAB",      "esx",  "1",    "root", "", "", ""], _
    ["192.168.20.22",   "LAB",      "esx",  "2",    "root", "", "", ""], _
    ["192.168.20.23",   "LAB",      "esx",  "3",    "root", "", "", ""], _
    ["192.168.20.57",   "SWARM",    "node",     "1",    "sudhaker", "", "", ""], _
    ["192.168.20.58",   "SWARM",    "node",     "2",    "sudhaker", "", "", ""], _
    ["192.168.20.59",   "SWARM",    "node",     "3",    "sudhaker", "", "", ""], _
    ["192.168.20.60",   "SWARM",    "node",     "4",    "sudhaker", "", "", ""], _
    ["192.168.20.61",   "SWARM",    "node",     "5",    "sudhaker", "", "", ""], _
    ["192.168.20.50",   "KUBE",     "master",   "",     "sudhaker", "", "", ""], _
    ["192.168.20.51",   "KUBE",     "node",     "1",    "sudhaker", "", "", ""], _
    ["192.168.20.52",   "KUBE",     "node",     "2",    "sudhaker", "", "", ""], _
    ["192.168.20.53",   "KUBE",     "node",     "3",    "sudhaker", "", "", ""], _
    ["192.168.20.54",   "KUBE",     "osv3",     "",     "sudhaker", "", "", ""], _
    ["192.168.20.55",   "KUBE",     "single",   "",     "sudhaker", "", "", ""], _
    ["192.168.20.65",   "MESOS",    "boot",     "",     "sudhaker", "", "", ""], _
    ["192.168.20.66",   "MESOS",    "master",   "1",    "sudhaker", "", "", ""], _
    ["192.168.20.67",   "MESOS",    "master",   "2",    "sudhaker", "", "", ""], _
    ["192.168.20.68",   "MESOS",    "master",   "3",    "sudhaker", "", "", ""], _
    ["192.168.20.69",   "MESOS",    "agent",    "1",    "sudhaker", "", "", ""], _
    ["192.168.20.70",   "MESOS",    "agent",    "2",    "sudhaker", "", "", ""], _
    ["192.168.20.71",   "MESOS",    "agent",    "3",    "sudhaker", "", "", ""], _
    ["192.168.20.72",   "MESOS",    "agent",    "4",    "sudhaker", "", "", ""], _
    ["192.168.20.73",   "MESOS",    "agent",    "5",    "sudhaker", "", "", ""], _
    ["192.168.20.74",   "MESOS",    "agent",    "6",    "sudhaker", "", "", ""], _
    ["192.168.20.75",   "MESOS",    "agent",    "7",    "sudhaker", "", "", ""], _
    ["192.168.20.76",   "MESOS",    "mini", "1",    "sudhaker", "", "", ""], _
    ["192.168.20.77",   "MESOS",    "mini", "2",    "sudhaker", "", "", ""], _
    ["192.168.20.80",   "MESOS",    "single",   "", "sudhaker", "", "", ""], _
    ["192.168.20.81",   "CDH",      "cm",       "",     "sudhaker", "", "", ""], _
    ["192.168.20.82",   "CDH",      "node",     "1",    "sudhaker", "", "", ""], _
    ["192.168.20.83",   "CDH",      "node",     "2",    "sudhaker", "", "", ""], _
    ["192.168.20.84",   "CDH",      "node",     "3",    "sudhaker", "", "", ""], _
    ["192.168.20.85",   "CDH",      "node",     "4",    "sudhaker", "", "", ""], _
    ["192.168.20.86",   "CDH",      "node",     "5",    "sudhaker", "", "", ""], _
    ["192.168.20.87",   "CDH",      "node",     "6",    "sudhaker", "", "", ""] _
]

; RENDER GUI
Opt("TrayMenuMode", 9)

Local $count = 0
Local $puttyMenuItems[$totalCount]
Local $filezillaMenuItems[$totalCount]

$lastGroup = ""
For $i = 0 To UBound($Servers) - 1
    $thisGroup = $Servers[$i][1]
    If $Servers[$i][3] == "" Then
       $thisItem = $Servers[$i][2]
    Else
       $thisItem = $Servers[$i][2] & "-N" & $Servers[$i][3]
    EndIf
    If $thisGroup <> $lastGroup Then
        If ($i <> 0) Then
            TrayCreateItem("")
        EndIf
        $serversMenuPutty = TrayCreateMenu($thisGroup & " - PuTTY")
        $serversMenuFileZilla = TrayCreateMenu($thisGroup & " - FileZilla")
    EndIf
    $puttyMenuItems[$count] = TrayCreateItem($thisItem, $serversMenuPutty)
    $filezillaMenuItems[$count] = TrayCreateItem($thisItem, $serversMenuFileZilla)
    $lastGroup = $thisGroup
    $count += 1
Next

TrayCreateItem("")
$exititem = TrayCreateItem("Exit")

TraySetState()

While 1
    $msg = TrayGetMsg()
    Select
        Case $msg = 0
            ContinueLoop
        Case $msg = $exititem
            ExitLoop
        Case Else
            $idx = _ArraySearch($puttyMenuItems, $msg)
            If $idx <> -1 Then
                $host = $Servers[$idx][0]
                $UserName = $Servers[$idx][4]
                TrayItemSetState($puttyMenuItems[$idx], $TRAY_UNCHECKED)
                If $UserName == "" Then
                    Run($puttyBin & " -ssh " & $host, @ScriptDir)
                Else
                    If $UserPwd == "" Then
                        Run($puttyBin & " -ssh " & $UserName & "@" & $host, @ScriptDir)
                    Else
                        Run($puttyBin & " -ssh -pw " & $UserPwd & " " & $UserName & "@" & $host, @ScriptDir)
                    EndIf
                EndIf
            EndIf
            $idx = _ArraySearch($filezillaMenuItems, $msg)
            If $idx <> -1 Then
                $host = $Servers[$idx][0]
                $UserName = $Servers[$idx][4]
                TrayItemSetState($filezillaMenuItems[$idx], $TRAY_UNCHECKED)
                If $UserName == "" Then
                    Run($filezillaBin & " sftp://" & $host, @ScriptDir)
                Else
                    If $UserPwd == "" Then
                        Run($filezillaBin & " sftp://" & $UserName & "@" & $host, @ScriptDir)
                    Else
                        Run($filezillaBin & " sftp://" & $UserName & ":" & $UserPwd & "@" & $host, @ScriptDir)
                    EndIf
                EndIf
            EndIf
    EndSelect
WEnd

Exit