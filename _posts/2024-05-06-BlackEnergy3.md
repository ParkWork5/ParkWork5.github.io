No networking data since even through I tell CAPE to capture traffic off a new interface it doesn’t care and still captures traffic off the old interface.

I was looking at [this](https://www.withsecure.com/en/whats-new/pressroom/withsecure-uncovers-kapeka-a-new-malware-with-links-to-russian-nation-state-threat-group-sandworm) article by WithSecure Research talking about APT-44/Sandworm group and a new ransomware discovered being used by them called Kapeka. The author mentions based on their research that Kapeka came from GreyEnergy and prior to that BlackEnergy(BE). Kapeka looks hard so, I found a [sample](https://www.hybrid-analysis.com/sample/052ebc9a518e5ae02bbd1bd3a5a86c3560aefc9313c18d81f6670c3430f1d4d4/568bdc5d0e316d1638c0daab) of BE from Hybrid Analysis and got to work.

The sample I got is probably BE3 based on the [timeline](https://malpedia.caad.fkie.fraunhofer.de/details/win.blackenergy) from Malpedia about the malware family. Below is the spear-phishing Excel document that you are greeted with. 

[UntanslatedPhish](/assets/images/01-BlackEnergy/SpearPhishExcel.png)

[TranslatedPhish](/assets/images/01-blackenergy/SpearPhishExcelMachineTranslated.png)


Cool phish but, what I am really after is that sweet VBA code. Unfortunately when pulling it up I saw that it was password protected.


[VBAPasswordProtected](/assets/images/01-BlackEnergy/VBAPasswordProtected.png)

After a some Googling I came across a [Reddit](https://www.reddit.com/r/excel/comments/yy3m8/hi_rexcel_i_just_found_a_way_to_hack_password/) post of someone using a hex editor and editing a hex value from DPB to Dpx and resetting the password to your own. That did the trick and found the shell code.

[VBACode](/assets/images/01-BlackEnergy/ExcelCode1.png)

[MoreVBACode](/assets/images/01-BlackEnergy/ExcelCode2.png)

Each function contains a portion of an executable called vba_macro.exe. This is saved to and ran from the user's Temp file.

[MoreVBACode](/assets/images/01-BlackEnergy/vba_macroLocation.png)


When ran vba_macro.exe will create two files. A dat file called FONTCACHE and a lnk file that is pointing to the dat file and running it with rundll32.exe. Not sure why the executable does this but, it does ping the host it is installed on repeatedly. After running vba_macro.exe will delete itself. When both FONTCACHE.dat and the lnk file are created vba_macro.exe will not run.

[LNKFile](/assets/images/01-BlackEnergy/LNKFile.png)

[FontCache](/assets/images/01-BlackEnergy/fontcacheexe.png)

Here are some interesting things I found when looking at the strings dumped from memory of vba_macro.exe.


|Things|Comments|
|------|--------|
|_Satori_81_MutexObject|This could be a hard coded file mutex file name I think. Googling showed articles of a Satori botnet but, that happened after this Excel file was made.|
|System and networking fingerprinting|Found artifacts of the lab computer.|
|/s /c "for /L %%i in (1,1,100) do (del /F "%s" & ping localhost -n 2 & if not exist "%s" Exit 1)"|Ping command in a loop. |
|Ping localhost -n 2|Standalone ping command.|


	
Fontcache.dat when loaded will create DLLloader32_####.exe into the same directory and then runs itself. Where each # is a random alphanumeric character. This exe is a legitimate signed executable per VirusTotal. Using x32 dbg I was not able to figure out how to see what fontcache.dat did when it was loaded by DLLloader32. I think I am suppose to dump memory from where fontcache.dat is loaded in but, not sure.  

[DLLLLoader](/assets/images/01-BlackEnergy/DLLLExe.png)


# Credits:
<a href="https://www.flaticon.com/free-icons/spreadsheet" title="spreadsheet icons">Spreadsheet icons created by Hopstarter – Flaticon</a>

<a href="https://www.flaticon.com/free-icons/malware" title="malware icons">Malware icons created by Freepik - Flaticon</a>