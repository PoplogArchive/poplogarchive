http://www.cs.bham.ac.uk/research/poplog/linux-cd/AREADME.txt
$local/ftp/linux-cd/AREADME.txt

PC LINUX POPLOG INSTALLATION INSTRUCTIONS (BIRMINGHAM CONFIGURATION)
Aaron Sloman
Updated: 17 Feb 2003


CONTENTS

 -- FILES IN LINUX POPLOG DIRECTORY
 -- -- Core program and documentation files
 -- -- Optional extra files
 -- INSTRUCTIONS FOR INSTALLATION OF POPLOG ON LINUX: OVERVIEW
 -- PRELIMINARY STEP 1: Install termcap if necessary.
 -- PRELIMINARY STEP 2: Install motif if necessary.
 -- PRELIMINARY STEP 3: Save any previous version of Poplog
 -- -- Step 3.a: Save old Poplog
 -- -- Step 3.b: Restore the poplog/local directory
 -- -- Step 3.c. Optional: Create tar file backup of your local directory
 -- PRELIMINARY STEP 4: Decide where poplog should go
 -- -- STEP 4.a. Check if there is enough space on /usr/local partition
 -- -- STEP 4.b. Find free space on other partitions
 -- -- Step 4.c (Optional) SETTING UP A NEW LOCATION FOR POPLOG
 -- INSTALLING POPLOG AFTER PRELIMINARY STEPS 1 to 4.
 -- -- A: installing from the CD
 -- -- B: installing from tar file made for the cd
 -- -- C: installing from files selected from the linux-cd/ directory.
 -- NOTE: Do not forgot to make backup copies

-- FILES IN LINUX POPLOG DIRECTORY

This file is located in the directory
    http://www.cs.bham.ac.uk/research/poplog/linux-cd

There are several other files in the same directory.

All the files are included in the Poplog CD at
    http://www.cs.bham.ac.uk/research/poplog/bham-linux-poplog.tar.gz

    After installation, if instructions have benn made clear enough
    and have been followed all the files listed below will be in the
    directory /usr/local/poplog/src


-- -- Core program and documentation files

    AREADME.txt
        The file you are now reading, which includes several preliminary
        steps to precede installation of linux poplog.

    AREADME.motifcheck.txt
        This file is referred to below, in one of the preliminary steps.
        It gives information on how to check whether motif is installed,
        and if not how to fetch and install it. Even if  motif is
        installed on your system, the version may be incompatible with
        that used for linking poplog.
        In that case poplog will have to be relinked (unless you decide
        to use poplog without motif).

    INSTALL-FROM-CD.txt
    INSTALL-FROM-WEB-FILES.txt
    INSTALL-FINAL.txt
    INSTALL-OPTIONS.txt
        These contain instructions to be followed after you have
        completed the preliminary steps described below.

    copyright.html
        Poplog copyright information. Sussex University has given
        permission for poplog and all its sources to be made freely
        available, without restriction of use. Some files are provided
        by the University of Birmingham on a similar basis.

    linuxstuff.html
        Overview for people browsing this file on the web.
        Partly duplicates this file.
        Available online
        here:
            http://www.cs.bham.ac.uk/research/poplog/linux-cd/linuxstuff.html

    Suse-Readme.txt
        Information for anyone planning to install Poplog on a SuSe
        linux system. Poplog requires the termcap library to be
        pre-installed and this file tells you how to do that.

    linux-poplog.tar.gz
        (about 12 Mbytes)
        (Not to be confused with poplog/bham-linux-poplog.tar.gz )

        Linux poplog packaged with additional files used to install
        linux poplog configured in the same way as at the University of
        Birmingham, in the School of Computer Science, including
        additional libraries and documentation, and revised teaching
        materials.
        This includes automatic installation scripts.

        Instructions for installation are below.

The above files provide the minimum required to install PC linux poplog.

    relinking.linux.poplog
        A shell script that may be useful if you cannot get Poplog to
        work at all and you have to re-build the basic executable files.

        If you have a version of linux for which poplog will not work,
        e.g. If you type in the main poplog directory
            $popsys
        (e.g. in /usr/local/poplog/v15.53a/pop/pop)
        the following commands
            ./basepop11
            ./corepop11

        and you get an error, then first try installing motif, as
        described below.

        If it still does not work you may need to try relinking poplog.
        First follow the instructions below to install all the poplog
        files.
        See also
            http://www.cs.bham.ac.uk/research/poplog/sysdoc/
            http://www.cs.bham.ac.uk/research/poplog/tools/

-- -- Optional extra files

Additional smaller files are available as optional extras, some of them
included in the linux-poplog.tar.gz file.

Files not included in the linux-poplog.tar.gz file, but included in the
bham-linux-poplog.tar.gz file, and also downloadable from here
    http://www.cs.bham.ac.uk/research/poplog/linux-cd/
namely:

    newkit.tar.gz
    brait.tar.gz
    simworld.tar.gz
    ctwm-window-manager.tar.gz
    contrib.tar.gz
    install_package
    master.tar.gz
    neural.tar.gz
    openmotif-2.1.30-8.i386.rpm
    popvision.tar.gz
    vedgn.tar.gz

These are explained in the linuxstuff.html file, mentioned above.

Additional files are included in the linux-poplog.tar.gz file
    INSTALL_LIKE_BHAM
    INSTALL_MOTIF_POPLOG
    INSTALL_NOMOTIF
    bham.tar.gz
    checkout.txt
    comp.lang.pop.faq.html
    emacs.tar.gz
    freepoplog.html
    install_package
    linuxmotif1553a.tar.gz
    newc_dec.tar.gz
    pophtmlprimer.tar.gz
    poplog.info.html
    userguide.html
    vedmail.tar.gz
    mklinks.afs
    run_install

These are explained in the file: AREADME.install.txt


=======================================================================

-- INSTRUCTIONS FOR INSTALLATION OF POPLOG ON LINUX: OVERVIEW

There are PRELIMINARY STEPS to be taken before installing poplog:

    1. Check whether you need to install the termcap library.
    2. Check whether you need to install motif
    3. If you previously had a version of poplog running,
        save it before installing the new one.
    4. Make sure you have enough space in /usr/local and if
        not make a symbolic link, as described in Step 4.

These steps are described below

Remaining instructions are in other files mentioned below.

=======================================================================
-- PRELIMINARY STEP 1: Install termcap if necessary.
    (May be necessary for SuSe users.)

Poplog uses termcap for terminal control. Termcap is is
regarded as obsolete and therefore not included by default on some linux
systems. If your system does not have it poplog will complain about not
being able to find termcap when you first attempt to test it. If that
happens you'll have to get a version of termcap for your system and
install it, after following these instructions:

    Check whether this file exists:

        /lib/libtermcap.so.2

    I.e. give this shell command:

        ls -l /lib/libtermcap.so.2*

    IF /lib/libtermcap.so.2 DOES NOT EXIST but this one does
        /lib/libtermcap.so.2.0.8
    or something like it

        THEN DO (as super user):

            ln -s /lib/libtermcap.so.2.0.8 /lib/libtermcap.so.2

    IF NEITHER FILE EXISTS then read the file
        http://www.cs.bham.ac.uk/research/poplog/linux-cd/Suse-Readme.txt
    and follow instructions.


=======================================================================
-- PRELIMINARY STEP 2: Install motif if necessary.

Check that your system has motif installed, and if not install it, or
install poplog and then follow instructions to disable motif facilities
in Poplog.

If you disable motif in poplog that will mean that some useful
facilities of poplog are not available, though they are not essential,
e.g. scroll bars and menu buttons on the editor XVed.

If you decide to install poplog without motif, skip the rest of this
section. (I.e. Go to PRELIMINARY STEP 3).

To find out whether motif has been installed on your linux system, and
of not how to get it, read this file which should be in the same
directory as the file you are now reading:

    AREADME.motifcheck.txt

    Also available at
        http://www.cs.bham.ac.uk/research/poplog/linux-cd/AREADME.motifcheck.txt


=======================================================================
-- PRELIMINARY STEP 3: Save any previous version of Poplog

If you did not have a previous version of Poplog skip to STEP 4, below.

-- -- Step 3.a: Save old Poplog

If you had a previous version of poplog in
    /usr/local/poplog/

you can save it by renaming that directory:

    mv /usr/local/poplog /usr/local/poplog.old

If the installation of the new version fails for any reason, you can
always restore that version.

-- -- Step 3.b: Restore the poplog/local directory

You will probably want to keep your local extensions to the main poplog
system. If so you can create a poplog directory and move back the local
directory

    ### create poplog directory
    mkdir /usr/local/poplog

    ### Move the local directory back to where it was
    mv /usr/local/poplog.old/local /usr/local/poplog

-- -- Step 3.c. Optional: Create tar file backup of your local directory

If you want to keep a "safe" copy of the old local directory, you
can use tar and save it thus:

    cd /usr/local/poplog
    tar cfz /usr/local/poplog.old/local.tar.gz local

That command should work on all linux systems. In case you have a
version of tar that does not recognize the "z" to mean "compress"
you can do it in two steps
    tar cf /usr/local/poplog.old/local.tar local
    gzip /usr/local/poplog.old/local.tar

Then check it
    ls -l /usr/local/poplog.old/local.tar.gz
The size of the file will depend on how big your local directory was.

You may wish to copy the file to a CD or zip file to ensure that you
have a backup version if your hard drive fails.

NOTE for experts:
You can normally install a new version of poplog on top of an old
version (i.e. just run the tar commands below). That will replace
old versions of files with new versions, and leave any extras in place.
However occasionally that can cause problems with local files shadowing
new versions of poplog files.

=======================================================================

-- PRELIMINARY STEP 4: Decide where poplog should go

If you had  previously installed poplog and are now installing a new
system you can ignore this section, unless your believe poplog may
be in a disk partition that is running short of space. This will
tell you how to install in a new location.

The main poplog system will take up about 40 to 50 Mbytes of file space
(including large amounts of documentation, libraries, Pop-11, Ved,
Prolog, Common Lisp and Standard ML.)

The extensions provided at Birmingham can take 20-30 Mbytes or more,
depending how many libraries you fetch and install and how many saved
images you decide to build for rapid start-up.

In addition, the compressed files you download or copy from the CD
in order to install Poplog may take 30-40 Mbytes or more after they
have been unpacked, though the files used for installation can be
deleted when the installation is complete. (It may be worth saving
them on a backup device.)

Taking all the above into account try to choose a partition on which you
have at least 200Mbytes spare, to allow for growth. (If you are going to
use it to install other things in addition to Poplog, you may need a lot
more than that.)

-- -- STEP 4.a. Check if there is enough space on /usr/local partition

    df -k /usr/local

This may print out something like

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda5             12096724   4112388   7369852  36% /usr

though with different numbers. In that example, the partition has
over 7000 MBytes of spare space. If the number under "Available"
is less than about 200000, then you have less than 200Mbytes free,
and it may be wise to install poplog in another place.

If you have enough space on /usr/local then you can do

    mkdir -p /usr/local/poplog/src

and skip to the end of this section.

-- -- STEP 4.b. Find free space on other partitions
Ignore this step if you have enough space on /usr/local

The command

    df -k

will show ou all your partitions and how much space you have left
in them.

E.g. you may have a partion with a name such as /dev/hda7 which is
mounted as /home which has a lot of spare space available.

If in doubt, try installing in the default location /usr/local/poplog

If you run out of space during the installation you can remove the
poplog compressed files (downloaded or supplied on CD) by doing this:

        rm -rf /usr/local/poplog/src/*

Then you can do it in a different partition.

-- -- Step 4.c (Optional) SETTING UP A NEW LOCATION FOR POPLOG
Ignore this step if you have enough space on /usr/local

Suppose you decide to put the system on a different disc partition from
your standard /usr/local/ partition. This is what you do.

Select the partition and create the directory you want poplog to go
into. E.g. if you have plenty of spare space in /home, then you can
create the appropriate directory thus (for which you will have to be
super-user):

            mkdir -p /home/poplog/src

then, as super-user, link that directory to /usr/local

            ln -s /home/poplog /usr/local/poplog

This will make
        /usr/local/poplog

a symbolic link to
        /home/poplog

Thus the system will behave as if you had put poplog in
    /usr/local/poplog
even though you have not taken up any space in the /usr/local
disk partition, apart from the tiny space required for the link.

Likewise, the system will treat the directory
    /usr/local/poplog/src/

as effectively the same as
    /usr/home/poplog/src/

After you have done all that, the standard instructions and shell
scripts referring to /usr/local/poplog will work as if you really had
created /usr/local/poplog

=======================================================================
-- INSTALLING POPLOG AFTER PRELIMINARY STEPS 1 to 4.

(First make sure you have been through preliminary steps 1 to 4
described above.)

The remaining instructions require use of the file
    linux-poplog.tar.gz

available in three ways:

(a) directly available online as
    http://www.cs.bham.ac.uk/research/poplog/linux-cd/linux-poplog.tar.gz

    OR via ftp:
    ftp://ftp.cs.bham.ac.uk/pub/dist/poplog/linux-cd/linux-poplog.tar.gz

(b) included on the Birmingham CD

(c) Included in this package used to make the CD
    http://www.cs.bham.ac.uk/research/poplog/bham-linux-poplog.tar.gz

    OR via ftp:
    ftp://ftp.cs.bham.ac.uk/pub/dist/poplog/bham-linux-poplog.tar.gz


There are other files, providing optional extra poplog-based facilities,
available on the line in the directory
    http://www.cs.bham.ac.uk/research/poplog/linux-cd/

also included on the Birmingham CD and also included in the large tar
file mentioned above.: bham-linux-poplog.tar.gz

Information about those optional extras is available in this file:

    http://www.cs.bham.ac.uk/research/poplog/linux-cd/linuxstuff.html
    (also included in the CD)

When you are ready, and have the appropriate instruction files, there
are three options for installation:

-- -- A: installing from the CD
        Follow the instructions in this file
            INSTALL-FROM-CD.txt

-- -- B: installing from tar file made for the cd
        Fetch the file (about 20 Mbytes), available at
    http://www.cs.bham.ac.uk/research/poplog/bham-linux-poplog.tar.gz
    OR via ftp:
    ftp://ftp.cs.bham.ac.uk/pub/dist/poplog/bham-linux-poplog.tar.gz

    If you fetch this you can behave as if you had got the file off the
    CD and follw instructions in the file
            INSTALL-FROM-CD.txt


-- -- C: installing from files selected from the linux-cd/ directory.

Browse this directory in your web browser:
    http://www.cs.bham.ac.uk/research/poplog/linux-cd/

It includes all the files provded in the CD and the
bham-linux-poplog.tar.gz file.

Follow the instructions in these files
    AREADME.txt
        (the file you are reading now)

Then the file
    INSTALL-FROM-WEB-FILES.txt

Available at
    http://www.cs.bham.ac.uk/research/poplog/linux-cd/INSTALL-FROM-WEB-FILES.txt


ATER INSTALLING BE SURE TO BACK UP YOUR POPLOG DIRECTORY SO THAT
YOU WILL NOT LOSE IT ALL IF YOUR HARD DRIVE FAILS

=======================================================================

-- NOTE: Do not forgot to make backup copies

The poplog linux+PC poplog system has been tested on Redhat Linux
versions 7.1, 7.2, 7.3, 8.0 and various other systems, including SuSe
and Mandrake.

Everything should work on other linux, debian, and freebsd systems
running on intel or equivalent machines (e.g. PC with AMD athlon).
However you may find some variations in directory layout and there may
be distributions Linux (e.g. Mandrake apparently) that need some minor
modifications to these instructions. If you encounter problems please
post them to the comp.lang.pop news group or send email to
    pop-forum AT cs.bham.ac.uk

If possible please describe any remedial actions you found useful to
overcome the problems.


Motif is normally required, but if you do not have it or do not wish to
install it you have the option to re-link poplog to run without it, as
explained above.

=======================================================================

Please report any problems with this installation package to

A.Sloman AT cs.bham.ac.uk

Post general queries about poplog, pop-11, or the poplog languages, to
the comp.lang.pop newsgroup.
[end]
