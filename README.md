<img src="images/logo2.png" align="left" width="100" alt="E Logo">
<!--
E is a 483-byte sizecoding experiment Win32 Telnet server written in x86 assembly and built with MASM and Crinkler. It listens on port 5555, accepts one connection, sends back its own name "E" and exits. I started with a simple C server to see how small the same program could become in assembly.
-->
𝖤 𝗂𝗌 𝖺 𝟦𝟪𝟥-𝖻𝗒𝗍𝖾 𝗌𝗂𝗓𝖾𝖼𝗈𝖽𝗂𝗇𝗀 𝖾𝗑𝗉𝖾𝗋𝗂𝗆𝖾𝗇𝗍 𝖶𝗂𝗇𝟥𝟤 𝖳𝖾𝗅𝗇𝖾𝗍 𝗌𝖾𝗋𝗏𝖾𝗋 𝗐𝗋𝗂𝗍𝗍𝖾𝗇 𝗂𝗇 𝗑𝟪𝟨 𝖺𝗌𝗌𝖾𝗆𝖻𝗅𝗒 𝖺𝗇𝖽 𝖻𝗎𝗂𝗅𝗍 𝗐𝗂𝗍𝗁 𝖬𝖠𝖲𝖬 𝖺𝗇𝖽 𝖢𝗋𝗂𝗇𝗄𝗅𝖾𝗋. 𝖨𝗍 𝗅𝗂𝗌𝗍𝖾𝗇𝗌 𝗈𝗇 𝗉𝗈𝗋𝗍 𝟧𝟧𝟧𝟧, 𝖺𝖼𝖼𝖾𝗉𝗍𝗌 𝗈𝗇𝖾 𝖼𝗈𝗇𝗇𝖾𝖼𝗍𝗂𝗈𝗇, 𝗌𝖾𝗇𝖽𝗌 𝖻𝖺𝖼𝗄 𝗂𝗍𝗌 𝗈𝗐𝗇 𝗇𝖺𝗆𝖾 "𝖤" 𝖺𝗇𝖽 𝖾𝗑𝗂𝗍𝗌. 𝖨 𝗌𝗍𝖺𝗋𝗍𝖾𝖽 𝗐𝗂𝗍𝗁 𝖺 𝗌𝗂𝗆𝗉𝗅𝖾 𝖢 𝗌𝖾𝗋𝗏𝖾𝗋 𝗍𝗈 𝗌𝖾𝖾 𝗁𝗈𝗐 𝗌𝗆𝖺𝗅𝗅 𝗍𝗁𝖾 𝗌𝖺𝗆𝖾 𝗉𝗋𝗈𝗀𝗋𝖺𝗆 𝖼𝗈𝗎𝗅𝖽 𝖻𝖾𝖼𝗈𝗆𝖾 𝗂𝗇 𝖺𝗌𝗌𝖾𝗆𝖻𝗅𝗒.
<!--
### E runs on all versions of Windows from 2000 to 11.
-->

### 𝖤 𝗋𝗎𝗇𝗌 𝗈𝗇 𝖺𝗅𝗅 𝗏𝖾𝗋𝗌𝗂𝗈𝗇𝗌 𝗈𝖿 𝖶𝗂𝗇𝖽𝗈𝗐𝗌 𝖿𝗋𝗈𝗆 𝟤𝟢𝟢𝟢 𝗍𝗈 𝟣𝟣.

<img src="images/E_EXMPL.png" align="right" width="300" alt="E Logo">

<!--
The entire history for this project in source code is included. The file names contain the version numbers and brief descriptions. Starting with 000 is the C telnet server, extremely basic. I forget why I had the sleep timer in there but it is removed later anyway.
-->

𝖳𝗁𝖾 𝖾𝗇𝗍𝗂𝗋𝖾 𝗁𝗂𝗌𝗍𝗈𝗋𝗒 𝖿𝗈𝗋 𝗍𝗁𝗂𝗌 𝗉𝗋𝗈𝗃𝖾𝖼𝗍 𝗂𝗇 𝗌𝗈𝗎𝗋𝖼𝖾 𝖼𝗈𝖽𝖾 𝗂𝗌 𝗂𝗇𝖼𝗅𝗎𝖽𝖾𝖽. 𝖳𝗁𝖾 𝖿𝗂𝗅𝖾 𝗇𝖺𝗆𝖾𝗌 𝖼𝗈𝗇𝗍𝖺𝗂𝗇 𝗍𝗁𝖾 𝗏𝖾𝗋𝗌𝗂𝗈𝗇 𝗇𝗎𝗆𝖻𝖾𝗋𝗌 𝖺𝗇𝖽 𝖻𝗋𝗂𝖾𝖿 𝖽𝖾𝗌𝖼𝗋𝗂𝗉𝗍𝗂𝗈𝗇𝗌. 𝖲𝗍𝖺𝗋𝗍𝗂𝗇𝗀 𝗐𝗂𝗍𝗁 𝟢𝟢𝟢 𝗂𝗌 𝗍𝗁𝖾 𝖢 𝗍𝖾𝗅𝗇𝖾𝗍 𝗌𝖾𝗋𝗏𝖾𝗋, 𝖾𝗑𝗍𝗋𝖾𝗆𝖾𝗅𝗒 𝖻𝖺𝗌𝗂𝖼. 𝖨 𝖿𝗈𝗋𝗀𝖾𝗍 𝗐𝗁𝗒 𝖨 𝗁𝖺𝖽 𝗍𝗁𝖾 𝗌𝗅𝖾𝖾𝗉 𝗍𝗂𝗆𝖾𝗋 𝗂𝗇 𝗍𝗁𝖾𝗋𝖾 𝖻𝗎𝗍 𝗂𝗍 𝗂𝗌 𝗋𝖾𝗆𝗈𝗏𝖾𝖽 𝗅𝖺𝗍𝖾𝗋 𝖺𝗇𝗒𝗐𝖺𝗒.
<!--
### Every build was tested by connecting from an Apple II.
-->
### 𝖤𝗏𝖾𝗋𝗒 𝖻𝗎𝗂𝗅𝖽 𝗐𝖺𝗌 𝗍𝖾𝗌𝗍𝖾𝖽 𝖻𝗒 𝖼𝗈𝗇𝗇𝖾𝖼𝗍𝗂𝗇𝗀 𝖿𝗋𝗈𝗆 𝖺𝗇 𝖠𝗉𝗉𝗅𝖾 𝖨𝖨.

<!--
Version 001 is the direct conversion to x86. Version 002 begins the process of breaking everything down. By version 006 we're using Crinkler and really going for it. At 015 we leave off at 483 bytes. I think there may be more to go, but this is good for now.
-->
𝖵𝖾𝗋𝗌𝗂𝗈𝗇 𝟢𝟢𝟣 𝗂𝗌 𝗍𝗁𝖾 𝖽𝗂𝗋𝖾𝖼𝗍 𝖼𝗈𝗇𝗏𝖾𝗋𝗌𝗂𝗈𝗇 𝗍𝗈 𝗑𝟪𝟨. 𝖵𝖾𝗋𝗌𝗂𝗈𝗇 𝟢𝟢𝟤 𝖻𝖾𝗀𝗂𝗇𝗌 𝗍𝗁𝖾 𝗉𝗋𝗈𝖼𝖾𝗌𝗌 𝗈𝖿 𝖻𝗋𝖾𝖺𝗄𝗂𝗇𝗀 𝖾𝗏𝖾𝗋𝗒𝗍𝗁𝗂𝗇𝗀 𝖽𝗈𝗐𝗇. 𝖡𝗒 𝗏𝖾𝗋𝗌𝗂𝗈𝗇 𝟢𝟢𝟨 𝗐𝖾'𝗋𝖾 𝗎𝗌𝗂𝗇𝗀 𝖢𝗋𝗂𝗇𝗄𝗅𝖾𝗋 𝖺𝗇𝖽 𝗋𝖾𝖺𝗅𝗅𝗒 𝗀𝗈𝗂𝗇𝗀 𝖿𝗈𝗋 𝗂𝗍. 𝖠𝗍 𝟢𝟣𝟧 𝗐𝖾 𝗅𝖾𝖺𝗏𝖾 𝗈𝖿𝖿 𝖺𝗍 𝟦𝟪𝟥 𝖻𝗒𝗍𝖾𝗌. 𝖨 𝗍𝗁𝗂𝗇𝗄 𝗍𝗁𝖾𝗋𝖾 𝗆𝖺𝗒 𝖻𝖾 𝗆𝗈𝗋𝖾 𝗍𝗈 𝗀𝗈, 𝖻𝗎𝗍 𝗍𝗁𝗂𝗌 𝗂𝗌 𝗀𝗈𝗈𝖽 𝖿𝗈𝗋 𝗇𝗈𝗐.

<!--
For me the biggest surprise was this:
-->
𝖥𝗈𝗋 𝗆𝖾 𝗍𝗁𝖾 𝖻𝗂𝗀𝗀𝖾𝗌𝗍 𝗌𝗎𝗋𝗉𝗋𝗂𝗌𝖾 𝗐𝖺𝗌 𝗍𝗁𝗂𝗌:

```
original C simple telnet server          - 90112 bytes CL build
original C no CRT & heavy CL size opts   -  1536 bytes CL OPT SIZE build        
convert orig C to assembly               -  3072 bytes MASM
```
<!--
The largest size reduction of the entire project by far was accomplished with the linker and no code changes. I quite wanted to get a Tiny C Conplier (TCC) build working to see the result, but I couldn't get around needing to have winsock2.h sitting there next to e.c and that voids the whole point of the project. I didn't try GCC.
-->
𝖳𝗁𝖾 𝗅𝖺𝗋𝗀𝖾𝗌𝗍 𝗌𝗂𝗓𝖾 𝗋𝖾𝖽𝗎𝖼𝗍𝗂𝗈𝗇 𝗈𝖿 𝗍𝗁𝖾 𝖾𝗇𝗍𝗂𝗋𝖾 𝗉𝗋𝗈𝗃𝖾𝖼𝗍 𝖻𝗒 𝖿𝖺𝗋 𝗐𝖺𝗌 𝖺𝖼𝖼𝗈𝗆𝗉𝗅𝗂𝗌𝗁𝖾𝖽 𝗐𝗂𝗍𝗁 𝗍𝗁𝖾 𝗅𝗂𝗇𝗄𝖾𝗋 𝖺𝗇𝖽 𝗇𝗈 𝖼𝗈𝖽𝖾 𝖼𝗁𝖺𝗇𝗀𝖾𝗌. 𝖨 𝗊𝗎𝗂𝗍𝖾 𝗐𝖺𝗇𝗍𝖾𝖽 𝗍𝗈 𝗀𝖾𝗍 𝖺 𝖳𝗂𝗇𝗒 𝖢 𝖢𝗈𝗇𝗉𝗅𝗂𝖾𝗋 (𝖳𝖢𝖢) 𝖻𝗎𝗂𝗅𝖽 𝗐𝗈𝗋𝗄𝗂𝗇𝗀 𝗍𝗈 𝗌𝖾𝖾 𝗍𝗁𝖾 𝗋𝖾𝗌𝗎𝗅𝗍, 𝖻𝗎𝗍 𝖨 𝖼𝗈𝗎𝗅𝖽𝗇'𝗍 𝗀𝖾𝗍 𝖺𝗋𝗈𝗎𝗇𝖽 𝗇𝖾𝖾𝖽𝗂𝗇𝗀 𝗍𝗈 𝗁𝖺𝗏𝖾 𝗐𝗂𝗇𝗌𝗈𝖼𝗄𝟤.𝗁 𝗌𝗂𝗍𝗍𝗂𝗇𝗀 𝗍𝗁𝖾𝗋𝖾 𝗇𝖾𝗑𝗍 𝗍𝗈 𝖾.𝖼 𝖺𝗇𝖽 𝗍𝗁𝖺𝗍 𝗏𝗈𝗂𝖽𝗌 𝗍𝗁𝖾 𝗐𝗁𝗈𝗅𝖾 𝗉𝗈𝗂𝗇𝗍 𝗈𝖿 𝗍𝗁𝖾 𝗉𝗋𝗈𝗃𝖾𝖼𝗍. 𝖨 𝖽𝗂𝖽𝗇'𝗍 𝗍𝗋𝗒 𝖦𝖢𝖢.

<!--
The style used was commenting out old code instead of removing it. A number of things went in and out several times along the way. I didn't preserve the failues.
-->
𝖳𝗁𝖾 𝗌𝗍𝗒𝗅𝖾 𝗎𝗌𝖾𝖽 𝗐𝖺𝗌 𝖼𝗈𝗆𝗆𝖾𝗇𝗍𝗂𝗇𝗀 𝗈𝗎𝗍 𝗈𝗅𝖽 𝖼𝗈𝖽𝖾 𝗂𝗇𝗌𝗍𝖾𝖺𝖽 𝗈𝖿 𝗋𝖾𝗆𝗈𝗏𝗂𝗇𝗀 𝗂𝗍. 𝖠 𝗇𝗎𝗆𝖻𝖾𝗋 𝗈𝖿 𝗍𝗁𝗂𝗇𝗀𝗌 𝗐𝖾𝗇𝗍 𝗂𝗇 𝖺𝗇𝖽 𝗈𝗎𝗍 𝗌𝖾𝗏𝖾𝗋𝖺𝗅 𝗍𝗂𝗆𝖾𝗌 𝖺𝗅𝗈𝗇𝗀 𝗍𝗁𝖾 𝗐𝖺𝗒. 𝖨 𝖽𝗂𝖽𝗇'𝗍 𝗉𝗋𝖾𝗌𝖾𝗋𝗏𝖾 𝗍𝗁𝖾 𝖿𝖺𝗂𝗅𝗎𝖾𝗌.

```
Walkdown from 90K to 483 bytes:

start with working version in C          - 90112 bytes exe size
original C no CRT & heavy CL size opts   -  1536 bytes 
first version in MASM                    -  3072 bytes
replace invokes with push/call           -  3072 bytes
remove dup error handles                 -  3072 bytes
first crinker build                      -   558 bytes
remove htons import & hard-code port     -   551 bytes
remove ZeroMemory (win does the init)    -   533 bytes
remove sleep - not needed                -   529 bytes
switched to ebx/esi                      -   521 bytes
   ebx = listening socket
   esi = client socket
combined mov AF_INET and mov 0B315h      -   517 bytes
switched IPPROTO to eax protocol zero    -   515 bytes
removed shutdown - let socket default    -   510 bytes
reduce wsa to actual size (400)          -   509 bytes
shortened the message to server name "E" -   493 bytes
let wsacleanup dispoose of the socket    -   487 bytes
fall-thu redundant INVALID_SOCKET check  -   484 bytes
moved addr_in from data? to data         -   483 bytes

```
<img src="images/mpc.png" width="25%" alt="mpower-codeworks">
