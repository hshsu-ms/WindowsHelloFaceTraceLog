@echo off

setlocal

net time \\%ComputerName% | findstr at
set username

set _dir=%~dp0

@echo.
@echo ===============================================
@echo Windows version and build
reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v BuildLabEx
reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild
reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v CurrentMajorVersionNumber
reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v CurrentMinorVersionNumber

@echo ===============================================
@echo Query analog provider regkeys recursively
REG QUERY HKLM\Software\Microsoft\Analog /s

@echo ===============================================
@echo Query FrameServer regkeys recursively
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows Media Foundation\FrameServer" /s

@echo ===============================================
@echo Query WinBio regkeys recursively
REG query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WinBio" /s

@echo ===============================================
@echo Query Kinect regkeys recursively
REG QUERY "HKLM\SOFTWARE\Microsoft\Kinect" /s

@echo ===============================================
@echo Query DLP regkeys recursively
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\EFS\EdpCredentials" /s

@echo ===============================================
@echo Query for PassportForWork policies
REG QUERY "HKLM\SOFTWARE\Microsoft\Policies\PassportForWork\Biometrics" /s

@echo ===============================================
@echo Query for FaceLogon
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\FaceLogon" /s

@echo ===============================================
@echo Query for Greetings
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Greetings" /s

@echo ===============================================
@echo Query for SessionData
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData" /s

@echo ===============================================
@echo Query status of SensorDataService:
sc query sensordataservice

@echo.
@echo ===============================================
@echo Query status of Win Bio Service:
sc query wbiosrvc

@echo.
@echo ===============================================
@echo Query status of KinectService:
sc query kinectmonitor

@echo ===============================================
@echo Query user Sphinx setting
REG QUERY HKEY_CURRENT_USER\SOFTWARE\Microsoft\BioAuth\FaceAuth /v EnableSphinx

@echo ===============================================
@echo Query Network Configuration
ipconfig /all
@echo.

@echo ===============================================
@echo Query PCI Devices (to look for USB Controllers)
%_dir%DevCon.exe find *PCI* | findstr "Host Controller"
@echo.

@echo ===============================================
@echo Query Microsoft USB Devices (to look for Kinect)
%_dir%DevCon.exe find *USB\VID_045E*
@echo.

@echo ===============================================
@echo Query Wake status
call powercfg /LASTWAKE
@echo.
