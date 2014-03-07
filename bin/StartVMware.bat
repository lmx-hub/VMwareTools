@echo off 
::"D:\Program Files\VMware\VMware View\Client\bin\wswc.exe" -nonInteractive -serverUrl 192.168.23.250 -userName xxxxxx -password xxxxxx -domainName YFB -desktopName Win8 -desktopLayout multimonitor -desktopProtocol PCoIP
::-desktopLayout windowLarge 
::-desktopLayout fullscreen

@start /b VMwareTools.exe /start