Looking at the MalwareBazar feed i grabbed a couple pieces of malware I thought would be interesting based on their name. One was an AutoIT script and the other some .NET malware that is from the Formbook family.

![DIE](/assets/images/05/AutoIT/AutoITDIE.png)


![DIEofFormbook](/assets/images/05/Formbook/DIEOGFormbook.png)

|Name|Malware Type|MalBzr|
|----|------|------------|
|f01a9a5bf10d65ce8fab.exe|AutoIT Script|[Link](https://bazaar.abuse.ch/sample/f01a9a5bf10d65ce8fab82786c9d972c441037392fdef2b0cb12609033454316/)|
|NEW ORDER 73449174_.exe|Formbook|[Link](https://bazaar.abuse.ch/sample/252608d720abcc726d09543d3f3d2f81d887f9ba844dde8b4fb6611674c253e0/)|

## AutoIT into Compiled Executable

The first piece of malware I found was identified as an AutoIT script. Based on their [website](https://www.autoitscript.com/site/autoit/) it is a general purpose scripting language used to automate the Window's GUI and other scripting tasks. 

After running through CAPEv2 and looking at the results the script will run Microsoft Edge and then loads accounts.google[.]com. It loops this behavior until the end of the simulation.  

<div style="background-color: rgb(18, 18, 18);">
```
Event ID: 22
User: S-1-5-18
ProcessId: 9224
Image: C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe
QueryStatus: 0
RuleName: -
ProcessGuid: {55189b26-87e1-66c9-9102-000000008e00}
QueryResults: ::ffff:192.178.50.36;
UtcTime: 2024-08-24 07:13:43.974
QueryName: www.google.com
#####################################################################################
Event ID: 22
User: S-1-5-18
ProcessId: 9224
Image: C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe
QueryStatus: 0
RuleName: -
ProcessGuid: {55189b26-87e1-66c9-9102-000000008e00}
QueryResults: ::ffff:74.125.136.84;
UtcTime: 2024-08-24 07:13:35.995
QueryName: accounts.google.com
```
</div>

![ChromeSearch](/assets/images/05/AutoIT/SearchesForChrome.jpg)

When loading it in IDA and poking around it seems like I was also looking at AutoIT itself in the executable. AutoIT does compiling AutoIT scripts into a standalone executable. There was also an anti debugger bit of code that prevents X64dbg from running and I saw it in IDA as well.

![AutoITX64dgb](/assets/images/05/AutoIT/x64error.png)
 
![AutoITIDA](/assets/images/05/AutoIT/AntiDebug.png)

After some Googling I came across a AutoIT script extractor on a Digitalsleuth's [Github](https://github.com/digitalsleuth/autoit-extractor). It extracted the AutoIT script with ease.

![AutoITExtractor](/assets/images/05/AutoIT/AutoItExtractor.png)

![AutoITP1](/assets/images/05/AutoIT/ScriptP1.png)
		
![AutoITP2](/assets/images/05/AutoIT/ScriptP2.png)

The AutoIT script determines if a browser is installed on the device and visits the Google account page if any of the browsers are found. That it is for this sample. I am not sure if I safely setup dummy Google account with MFA and see if something cool happens once it sees an actual account. It seems to me like this is one piece of a process.

Looking at the Malware Bazaar page there are a few urls it mentions that have been hosting the malware. Their respective pages on urlhaus.abuse[.]ch show that the ips have been serving malware for 14 days at the time of writing. Looking at one of the ips on Censys i can see that they are hosting an Nginx web server and an ssh server. Grabbing the ssh cert fingerprint and searching with that there are the two other ips we know about and a fourth one 31.41.244[.]10 is not listed.

![Cenesys1IP](/assets/images/05/AutoIT/CensysOneIP.png)

![CenesysAllIPs](/assets/images/05/AutoIT/CensysAllIPs.png)

Like the other ips it hosts an Nginx web server and ssh server.


## Formbook Malware


The second piece of malware is from the Formbook family of malware. After watching this video about how it works the main things I am looking for in the program are:

	1. Load bitmap image holding obfuscated 1st stage.
	2. Perform de-obfuscation operations.(If any)
	3. Loading the byte code of the bitmap.
	4. Executing the byte code.
	

Following the road map I found the image that was being loaded in my case Polygan.png shown in the code and in the resources section. 

![FormbookResourceLoad](/assets/images/05/Formbook/NewOrderMain.png) 

![FormbookResource](/assets/images/05/Formbook/PhotoLocation.png) 

Next figuring out where the image is going. There is one function being called Hz8w.Pm3o0Q at the end of main is taking the list that has the image stored within it as an argument. Looking at that function it is using GetManifestResourceStream to load the resource into an array called o0A5Rz. Following o0A5Rz there are a few lines related to decryption and finally something be called to in the array.

![Formbook2ndFunctionP1](/assets/images/05/Formbook/Pm3o0QP1.png) 

![Formbook2ndFunctionP2](/assets/images/05/Formbook/Pm3o0QP2.png) 

After setting a break point on when the NewLateBinding.LateCall Dnspy allows you to dump anything in memory. Looking at the o0A5Rz array there is the:

![FormbookByteArray](/assets/images/05/Formbook/ArrayWithBitmap.png) 

Found the byte array that holds the next stage in the second element of the array. Now that it is dumped after a right click DIE confirmed a working executable was dumped.

![FormbookStage1DIE](/assets/images/05/Formbook/DIE_Stage1.png) 

Although DIE does not detect any obfuscation when looking at the dumped executable it is clearly obfuscated. When running the executable in CAPE it quits immediately upon execution and CAPE determined it may have a date/time check since it quit right after checking the date/time.

![FormbookStage1Cape](/assets/images/05/Formbook/CapeSignature.png) 

Cool note is I was the first person to upload the 1st stage to [VirusTotal](https://www.virustotal.com/gui/file/f7fad1ed820f01c3d980368b95f5740d6652234cba81e67d50ac117fa9e2edbb/details).

When trying to de obfuscate it I Googled this tag 198 Protector V4 and came across a YouTube video that kinda went over how to de obfuscate similar .NET code. After figuring out what de obfuscation tools they were using and trying them with my sample they did not work It also does not help that the video was 4 years old or so. No luck on figuring out what is actually hidden on the 1st stage.

![FormbookStage1Obfuscator](/assets/images/05/Formbook/Stage1Obfuscator.png) 

![FormbookStage1](/assets/images/05/Formbook/Stage1Classes.png)

![FormbookStage1](/assets/images/05/Formbook/Stage1Math.png)
