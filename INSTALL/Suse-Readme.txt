
This file is
    http://www.cs.bham.ac.uk/research/poplog/linux-cd/Suse-Readme.txt

Written by Paul Marker
Installed by Aaron Sloman
    20 Feb 2002
Slightly modified
    3 Apr 2002
=======================================================================

      SUSE_POPLOG - A brief guide to get SuSE 7.3 working with poplog

AUTHOR : Paul Marker
EMAIL  : ug31pxm  AT cs.bham.ac.uk
NOTE   : This file is not a definitive answer but more the steps I took
     to get poplog installed and working on my copy of SuSE Linux
     7.3. I am new to Linux, so I cannot go into great depth but
     hopefully this will help to get things rolling.
     These steps are on SuSE 7.3 but may well be similar on other
     versions.

============================================================================
TO CARRY OUT THE TASKS STATED IN THIS HELP FILE, AND THOSE ACCOMPANYING
THE POPLOG INSTALLATION YOU MUST BE LOGGED IN AS THE ROOT (SUPER) USER!

1)  INSTALL THE TERMCAP LIBRARY

    Firstly you need to install an aditional library for SuSE
    called Termcap. This is crucial, since Poplog assumes this library
    is installed and will not run without it.

    You need to get a copy of the termcap RPM installer. A good
    place to start is http://at.rpmfind.net. If you look under the
    SuSE 7.3 distribution section you will find the following library.

        termcap-2.0.8-406.i386

    This is the file you want.

    You then need to install the library, this is fairly easy.
    Through KONQUEROR double (or single) click the termcap rpm file,
    to run it. This will launch SuSE's package manager, ehich I know
    very little about. If you worried what will happen find out
    about it before hand, else do what I did and just press the
    INSTALL button. This will then install the library. However you are
    not quite done.

2)  CREATE A SYMBOLIC LINK

    This is just for the benefit of Poplog which looks for the file
    libtermcap.so.2, and not libtermcap.so.2.0.8 which is (probably) the
    actual version you just intalled. From a terminal execute the
    following:

        ln -s /lib/libtermcap.so.2.0.8 /lib/libtermcap.so.2

    And thats it.
    (If you installed a termcap.so file with a different version number,
    modify the command accordingly).

3)  INSTALL POPLOG

    For help on this refer to the README and AREADME file which is
    provided with the tar file for linux-poplog.

4)  RUNNING POPLOG

    The basic command to run xved (the poplog editor) is shown below
    where [filename] is optional if you want to load directly with a
    poplog file:

        poplog xved [filename]

    More detailed information on running poplog in its various
    states, and how to set it up so that you only have to type
    "xved [filename]" can be found in the userguide.html in the
    directory where you un-tarred the poplog installation files.

    This is also available at
    http://www.cs.bham.ac.uk/research/poplog/userguide.html

==============================================================================
IF YOU NEED FURTHER HELP OR ADVICE

Post your questions to the:
        comp.lang.pop news group or to
        pop-forum AT cs.bham.ac.uk

Be as specific as possible. In particular state what sort of computer
you are using, which operating system, which version of poplog, and
exactly what you did, what (if anything) was printed out, and what you
expected to happen. Helpers are not mind-readers, though they are
willing to help if the task is not too hard.
