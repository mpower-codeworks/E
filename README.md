# E

E is a 483-byte Win32 Telnet server written in x86 assembly and built with MASM and Crinkler. It listens on port 5555, accepts one connection, sends back its own name "E" and exits. I started with a simple C server to see how small the same program could become in assembly.

The entire history for this project in source code is included. The file names contain the version numbers and brief descriptions. Starting with 000 is the C telnet server, extremely basic. I forget why I had the sleep timer in there but it is removed later anyway.

Every build was tested by connecting from an Apple II.

Version 001 is the direct conversion to x86. Version 002 begins the process of breaking everything down. By version 006 we're using Crinkler and really going for it. At 015 we leave off at 483 bytes. I think there's a bit more to got. More on that in a bit.

For me the biggest surprise was this:
```
original C simple telnet server          - 90112 bytes CL build
original C no CRT & heavy CL size opts   -  1536 bytes CL OPT SIZE build        
convert orig C to assembly               -  3072 bytes MASM
```
The largest size reduction of the entire project by far was accomplished with the linker and no code changes. I quite wanted to get a Tiny C Conplier (TCC) build working to see the result, but I couldn't get around needing to have winsock2.h sitting there next to e.c and that voids the whole point of the project. I didn't try GCC.

The style used was commenting out old code instead of removing it. A number of things went in and out several times along the way. I didn't preserve the failues.

I just noticed I forgot to take PORT out. Oh well.
