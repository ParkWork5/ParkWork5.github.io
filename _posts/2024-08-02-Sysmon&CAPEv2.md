To work around the issues of not being able to gather network traffic from the interface I looked into Sysmon because CAPEv2 supported it. Interestingly I could not find any official documentation for it. First step I tried was enabling it in auxiliary.conf and no luck as the Sysmon results folder was still empty. I also tried installing Sysmon on the guest machine itself and running an analysis but, no luck either.

In search of more documentation I looked at the GitHub issues and found [this](https://github.com/kevoreilly/CAPEv2/issues/1214) issue indirectly explaining how Sysmon was setup with CAPEv2. I went ahead and downloaded Sysmon from Microsoft's website and renamed the 32 and 64 bit versions accordingly and moved them to /opt/CAPEv2/analyzer/windows/bin/. To configure Sysmon I used a configuration by [SwiftOnSecurity](https://github.com/SwiftOnSecurity/sysmon-config) from their GitHub.

|Original Name|New Name|
|-------------|--------|
|sysmon.exe|SMaster32.exe|
|sysmon64.exe|SMaster64.exe|
|sysmonconfig.xml|sysmonconfig-export.xml|  

No luck again and I was thinking about trying to figure out if I needed to add something extra to the exe processing package to run SCP to copy the Sysmon log file. While doing some looking around for that I came across a Sysmon config option in processing.conf. After changing it to "Yes" and running an analysis I could see the Sysmon logs in the analysis folder!

Super excited all I had to do was a little bit more digging to figure it out. Next step is figuring out how to parse the Sysmon logs and only output the networking data. Maybe I can finally use Java again and code something up. 0.0 