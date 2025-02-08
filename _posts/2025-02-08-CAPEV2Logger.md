## Parsing Sysmon and PowerShell Logs

After setting up Sysmon in CAPEV2 I needed a away to parse the wall of text that Sysmon produced so, I can figure out what is going on. Below is a link to a GitHub repo where I used Java to parse the Sysmon logs by event id and it creates a separate folder for each event. Runs super fast and in the future gives me a way to easily remove benign Windows events and CAPEV2 triggered events when i go to start tuning things. I do also have a guide for setting up Sysmon on CAPEV2 as well below.

Then I setup PowerShell logging using curtain based on the link from the CAPEV2 manual. Super simple I enabled it in auxiliary.conf and it worked out of the box. PowerShell logs were found in the curtain folder of the analysis results. 
When looking at the PowerShell logs and the Sysmon parser i realized it also worked for the PowerShell logs and I did not have to write any additional code. I just changed some of the variables to generic names.

Next on the list is figuring out how to run code on the guest machine during analysis that does additional actions. This should be my the answer to getting networking data and generating PCAP files with tcpdump.

Java based Windows Log [Parser](https://github.com/ParkWork5/MultiWindowsLogParser)

[Sysmon + CAPEV2](https://parkwork5.github.io/2024/08/02/Sysmon&CAPEV2.html) 

Mandiant Article for [PowerShell Logs](https://cloud.google.com/blog/topics/threat-intelligence/greater-visibility/)
