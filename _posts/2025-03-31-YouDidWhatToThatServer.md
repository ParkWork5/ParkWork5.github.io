I was looking for the next piece of software to reverse and saw a curious tag on Malware Bazaar called [fuckedserver-net](https://bazaar.abuse.ch/browse/tag/fuckedserver-net/). Curiosity got the best of me and now i have 4 pieces of software to reverse. Censys said there was nothing being hosted on the server at the time i checked and all the urls in the PowerShell scripts failed to download anything. 


## File Relations
![Flow Chart](/assets/images/09/FlowChart.png)

Although the files were grouped up together I was not able to determine how the ef4c15 executable was related to the domain in the tag. I checked with VirusTotal and based on their data only the two PowerShell and the one msc files were related because of the connection to fuckedserver[.]net. 

## PowerShell 5e842.ps1

![First PWSH](/assets/images/09/5e842powershell.png)

1. Downloads AnyDesk.zip to the victim's TEMP folder and and extracts it there. 
2. Downloads nThread.dll to the victim's TEMP folder and adds the Desktop class from the .NET file to the current PowerShell session.
3. Downloads AnyDesk.exe to the victim's APPDATA folder.
4. Creates a new virtual desktop called hVNC.
5. Runs the functions CreateDesktop and CreateProcess from the loaded dll file.

When looking through the code I was curious on what the deal was with the virtual desktops. I think the idea behind it was to hide the activity of the AnyDesk running in a different Windows desktop. Then run Explorer.exe on that created desktop to make it appear legitimate or if discovered to get the user to think Windows must be acting up like it usually does.

## PowerShell 405d1.ps1

![Second PWSH](/assets/images/09/405d1powershell.png)

1. Creates a full copy of C:\Windows and a fake System 32 folder inside the newly created directory. This is pretty nuts because based on the command I thought it was suppose to make an empty directory with the System 32 folder but, that is not the case when i was testing it inside my Windows VM. A brief DuckDuckGo expedition showed that the \\?\ prefix can be used for disabling parsing of the file name by Windows and allow for long file paths or file paths with not allowed characters. Nothing about a copy of a directory.
2. The next directory creation works as expected and an empty en-US sub directory is created inside of System 32.
3. Decode 64 encoded strings.
4. Create two separate WmiMgmt.msc files from the decoded strings.
5. Replaces the string '{htmlLoaderUrl}' inside '\\?\C:\Windows \System32\en-US\WmiMgmt.msc' with hxxps://fuckedserver[.]net/encrypthub/ram/. 
6. Runs the original msc file.
7. Then deletes the fake directories

The thing about this script is that it only runs the original msc file and not the one with the connection to the fuckedserver[.]net domain. In the msc file there is section for the tag as such below. When researching msc malware i came across an [article](https://www.outflank.nl/blog/2024/08/13/will-the-real-grimresource-please-stand-up-abusing-the-msc-file-format/) about using msc file format to execute commands on victim machines. What makes this file format attractive is that is not the normal executable, macro embedded document, or html file seen in phishing attacks. Whoever wrote the msc file is using the "Link to Web Address" to probably load a malicious HTML page. Through it doesn't matter since the PowerShell script executes the wrong msc file. I was also curious on what was  in the binary elements at the end of the msc file. Some DuckDuckGo brought me to an ancient [StackOverflow](https://stackoverflow.com/questions/42711354/extract-icons-from-a-msc-file) post for extracting icons from msc files. Each pair of binary tags contains data that is base64 encoded and then is possibly serialized by .NET. To figure out what is going on chuck it into CyberChef, download the data as a .bin file, and delete the first 28 bytes of the file. I did that and got icon image files. Nothing cool hidden in the binary tag.

## 977198.dll

This is the dll file called nThread.dll in the PowerShell script. It contains a list of .NET functions to be used by the malware to:

+ Create,enumerate,and delete virtual desktops.
+ Create, enumerate, and delete processes on virtual desktops.
+ Create logs.

Solid functions and nothing is obfuscated.

## ef4c16.exe

This executable based on Yara rules is a sample of StealC infostealer. It has the ability to steal credentials, session tokens, and sensitive data from a variety of applications. It is also time gated and I found it does use one of the Window's API calls to check time early on in execution.

It unpacks the first layer of itself using an xor decrypt function. There are two sets of calls to the decryption function. Some values piped into this function are encrypted so, maybe there is another round of decryption happening before the xor decryption is applied to them. When i decrypted the first layer with IDAPython i got mostly strings and not full commands. Link to IDAPython first layer decryptor [here](https://github.com/ParkWork5/IDAPythonScripts/tree/main/StealC). Thanks to Lexfo for their detailed analysis of StealC [here](https://blog.lexfo.fr/StealC_malware_analysis_part3.html) it helped me figure out what was going on in my StealC payload.

Full list of found strings [here](/assets/images/FoundStrings.txt). Below are some of the interesting ones I found.

|String|Reference|
|------|-------|
|Pidgin|Might be a reference to an old online chat software.|
|loginusers.vdf |Shows all logins to Steam made on the PC.|
|sqlite3|Common database library used in browsers.|
|cc name: month: card: |The ability to grab saved credit cards.|

Interestingly this string is included as some kind of obfuscation i guess only in the decrypt function.

![DecryptorStringObfuscation](/assets/images/09/DecryptFunction.png)


## File Details


|Name|Malware Type|MalBzr|
|----|------------|------|
|5e842.ps1|PowerShell|[Link](https://bazaar.abuse.ch/sample/5e8428fbd148bf83f0b7ebbaea9ca326de0b8810edbcd2c55c3c75d034b11fe0/)|
|405d1.ps1|PowerShell|[Link](https://bazaar.abuse.ch/sample/405d1dcdbba56bce99a308734c39ac8ca62ffb55dbd69565293a79b468e4dad1/)|
|3a592.msc|Malicious MS Saved Console|[Link](https://bazaar.abuse.ch/sample/3a5924cca3467388d2f5ea74f3b3e2437a229beb780d79019c57724af4394649/)|
|977198.dll|.NET|[Link](https://bazaar.abuse.ch/sample/977198c47d5e7f049c468135f5bde776c20dcd40e8a2ed5adb7717c2c44be5b9/)|
|ef4c16.exe|Steal C Exe|[Link](https://bazaar.abuse.ch/sample/e4fc16fb36a5cd9e8d7dfe42482e111c7ce91467f6ac100a0e76740b491df2d4/)|







