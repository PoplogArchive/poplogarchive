/* --- Copyright University of Birmingham 2010. All rights reserved. ------
 > File:            $usepop/pop/packages/vedutils/lib/pop_mobile_connect.p
 > Purpose:         Enable communication via Huawei/T-mobile USB Web-n-walk stick
					Huawei E220 on Linux for SMS
                    (Provides only a tiny subset of the 'minicom' commands, but
                    does support sending and reading of text messages.)
 > Author:          Aaron Sloman, Apr  4 2010 (see revisions)
 > Documentation:   HELP POP_MOBILE_CONNECT
 > Related Files:
 */


/*

##Must run as root now.

CONTENTS

 define GLOBAL VARIABLES
 define BASIC PROCEDURE FOR SENDING AND READING
 define pmc_send(message);
 define ADDITIONAL PMC PROCEDURES
 define pmc_clear();
 define pmc_network();
 define pmc_getimsi();
 define pmc_getmanufacturer();
 define pmc_service_centre();
 define SWITCHING MODES
 define pmc_textmode();
 define pmc_nontextmode();
 define SETTING CONNECTION PREFERENCES (3G/GPRS)
 define pmc_3g_pref();
 define pmc_3g_only();
 define pmc_gprs_pref();
 define pmc_gprs_only();
 define MESSAGE HANDLING PROCEDURES
 define pmc_all_messages();
 define pmc_get_message(n);
 define pmc_del_message(n);
 define pmc_send_message(number, text);
 define MESSAGES REQUESTING PASSES
 define pmc_7_day_pass();
 define pmc_30_day_pass();

*/

/*

NB: must be run as root at present.

Information below was based on a web site, whose details I have mislaid
(will add later).

It has all been tested ONLY on a t-mobile web-n-walk mobile broadband
USB stick bought in 2008.

This assumes that you have set up /etc/wvdial.conf appropriately and run
wvdial to make a connection to the tmobile service.

The procedure pmc_send takes a string, prepares a Ved file buffer --
the file whose name is held in the pop-11 variable pmc_output_file.
The default is './pmc-text.p' but another file name can be assigned.


It then reads any responses
from the modem channel until the end of response character sequence.
Everything read in is included in the Ved file buffer.
	
Each command defined below uses a string of characters, given to pmc_send.

The general format for strings is AT+Some_Command.
Examples, used below to define commonly required functions, are:

    AT+COPS=? #get network names

    AT+CIMI #Get IMSI Number

    AT+CGMI #Get manufacturer name

To send SMS's you need to put the device in "Text" mode.
This is done by sending the following command:

    AT+CMGF=1 # Puts the mode in text mode

This text was found in an online web page (url mislaid):

    I'm not sure how to set it to 3g only, etc but lurking around
    the vodafone code I found this

    HUAWEI_DICT = {
    `GPRSONLY' : `AT^SYSCFG=13,1,3FFFFFFF,2,4#,
    `3GONLY' :   `AT^SYSCFG=14,2,3FFFFFFF,2,4#,
    `GPRSPREF' : `AT^SYSCFG=2,1,3FFFFFFF,2,4#,
    `3GPREF' :   `AT^SYSCFG=2,2,3FFFFFFF,2,4#,
    }

These strings are used below in procedures for setting preferences.
I don't know if they work!

*/


/*
define GLOBAL VARIABLES
*/

global vars
	pmc_output_file,
    minicom_device = '/dev/ttyUSB1';

;;; minicom_device = '/dev/ttyUSB0';
;;; minicom_device = '/dev/ttyUSB2';

;;; provide default file name if not already assigned
if isundef(pmc_output_file) then
	 './pmc-text.p' -> pmc_output_file
endif;

/*
define BASIC PROCEDURE FOR SENDING AND READING
*/

define pmc_send(message);

	;;; Output channel

    dlocal cucharout=discout(minicom_device);

	;;; Prepare input buffer (VED text file)
    edit(pmc_output_file);
    vedendfile();
    vedlinebelow();

	;;; Transmit the message, followed by CR
    appdata(message,cucharout);
    cucharout('\r');

    vedinsertstring('\nSent\n\n');

	;;; Prepare to readd response
    lvars inchar=discin(minicom_device);

    lvars char;

    ;;; Now read reply. Ends with
    ;;; <CR><LF>OK<CR><LF>

    lvars char1 = 0, char2=0, char3=0, char4=0, char5=0, char6;

    repeat inchar() -> char;

        if char == termin then
            vedinsertstring('\n\n\nTERMIN RECEIVED\n\n\n');
            return();
        endif;

        char2 -> char1;
        char3 -> char2;
        char4 -> char3;
        char5 -> char4;
        char6 -> char5;
        char  -> char6;

        if
            char6 == `\n` and
            char5 == `\n` and
            char4 == `K` and
            char3 == `O` and
            char2 == `\n` and
            char1 == `\n`
        then
            ;;; end of response
            vedinsertstring('\n\n----\n\n');
            return()
        endif;

        if char == `\r` then `\n` -> char endif;

		;;; insert text into buffer
        vedcharinsert(char);

    endrepeat;

enddefine;


/*
define ADDITIONAL PMC PROCEDURES
*/

;;; The following commands all produce their output in the output-device file, which
;;; you may wish to clear between commands, using the ved command: ENTER clear.

/*
pmc_clear();
;;; re-set the USB device.
*/

define pmc_clear();
    ;;; clear input
    ''.pmc_send;
enddefine;

/*
Sample output of pmc_network
+COPS: (1,"T-Mobile UK","TMO UK","23430",2),(2,"T-Mobile UK","TMO UK","23430",0),,(0,1,2,3,4),(0,1,2)
*/

define pmc_network();
    ;;;get network names
    'AT+COPS=?'.pmc_send;
enddefine;

/*
Sample output of pmc_getimsi
	234308351487046
*/

define pmc_getimsi();
    ;;;Get IMSI Number
    'AT+CIMI'.pmc_send;
enddefine;


/*
Sample output of
	pmc_getmanufacturer();

AT+CGMI

huawei

OK

*/

define pmc_getmanufacturer();
    ;;;Get manufacturer name
    'AT+CGMI'.pmc_send;
enddefine;

/*
Sample output of pmc_service_centre
pmc_service_centre();
AT+CSCA?

+CSCA: "+447983112977",145

OK
*/

define pmc_service_centre();
    ;;; service centre address
    'AT+CSCA?'.pmc_send;
enddefine;

/*
define SWITCHING MODES
*/

/*
pmc_textmode();

*/

define pmc_textmode();
    ;;; Puts the mode in text mode
    'AT+CMGF=1'.pmc_send;
enddefine;

/*
pmc_nontextmode();

*/

define pmc_nontextmode();
    ;;; Puts the mode in non text mode
    'AT+CMGF=0'.pmc_send;
enddefine;

/*
define SETTING CONNECTION PREFERENCES (3G/GPRS)
*/

/*
pmc_3g_pref();

;;; set 3G preferred: (in non-text mode)

*/

define pmc_3g_pref();
    ;;; set 3G preferred: (in non-text mode)
    ;;; `3GPREF' :   `AT^SYSCFG=2,2,3FFFFFFF,2,4#,
    pmc_send('AT^SYSCFG=2,2,3FFFFFFF,2,4#');
enddefine;

/*
pmc_3g_only();
;;; set 3G only: (in non-text mode)

*/

define pmc_3g_only();
	;;;`3GONLY' :   `AT^SYSCFG=14,2,3FFFFFFF,2,4#,
    pmc_send('AT^SYSCFG=14,2,3FFFFFFF,2,4#');
enddefine;


/*
pmc_gprs_pref();
;;; set GPRS preferred: (in non-text mode)

*/

define pmc_gprs_pref();
    ;;; `GPRSPREF' : `AT^SYSCFG=2,1,3FFFFFFF,2,4#,
	pmc_send('AT^SYSCFG=2,1,3FFFFFFF,2,4#');
enddefine;

/*
pmc_gprs_only();
;;; set GPRS only : (in non-text mode)

*/

define pmc_gprs_only();
	;;; `GPRSONLY' : `AT^SYSCFG=13,1,3FFFFFFF,2,4#,
	pmc_send('AT^SYSCFG=13,1,3FFFFFFF,2,4#');
enddefine;


/*
define MESSAGE HANDLING PROCEDURES
*/

/*
pmc_all_messages();

;;; Sample output (phone number changed):

+CMGL: 1,"REC READ","+44798311xxxx",,"10/03/28,15:05:13+04"

testing

+CMGL: 2,"REC READ","84457711198105108101",,"10/04/02,23:32:31+04"

You've successfully purchased 30 days of mobile broadband, please keep this text as your receipt.

+CMGL: 3,"REC READ","84457711198105108101",,"10/04/04,01:48:07+04"

Unfortunately, your 7 days of mobile broadband expires at midnight tonight.  You can either buy another 7 days or carry on using Mobile Broadband at 2 per day

+CMGL: 0,"REC UNREAD","+44798311xxxx",,"10/04/04,12:34:50+04"

 First test using pmc

OK

*/

define pmc_all_messages();
    ;;; list all messages
    pmc_send('AT+CMGL="ALL"');
enddefine;

/*
Sample output of pmc_get_message(n)

pmc_get_message(0);

AT+CMGR=0

+CMGR: "REC READ","+44798311xxxx",,"10/03/28,15:05:12+04"

testing

OK

*/

define pmc_get_message(n);
    ;;; read message (first is message n=0);
    pmc_send('AT+CMGR='><n);
enddefine;

/*
Sample output of pmc_del_message(n)
;;; first message n=0

pmc_del_message(0);

AT+CMGD=0

^DSFLOWRPT:000014F4,00000000,00000000,000000000001949A,0000000000021E14,0003E800,000FA000

OK

*/

define pmc_del_message(n);
    ;;; delete message n ( 0 is first message )
    pmc_send('AT+CMGD='><n);
enddefine;

/*
Sample output of pmc_send_message(number, text);

pmc_send_message('+44798311xxxx', 'First test using pmc');

AT+CMGS="+44798311xxxx"

>

>  First test using pmc

^DSFLOWRPT:00001762,00000000,00000000,000000000001949A,0000000000021E14,0003E800,000FA000

AA

^BOOT:22443946,0,0,0,75

^DSFLOWRPT:00001764,00000000,00000000,000000000001949A,0000000000021E14,0003E800,000FA000

+CMGS: 31

OK

*/

define pmc_send_message(number, text);
	;;; send text to phone number
	;;; NB both number and text should be provided as strings.
    ;;; To send an SMS do the following:
    ;;;'AT+CMGS="+44798311xxxx"\r this is my message \r\^Z'.pmc_send
	pmc_send('AT+CMGS="' >< number >< '"\r ' >< text >< '\r\^Z');
enddefine;


/*
define MESSAGES REQUESTING PASSES
*/

/*
pmc_7_day_pass()
;;; Cost is GBP 7 (i.e. half price, saving 7)
*/

define pmc_7_day_pass();
    ;;; ask for 7 day pass
    'AT+CMGS="441"\r7 DAY\r\^Z'.pmc_send
enddefine;

/*
pmc_30_day_pass()
;;; Cost is GBP 15 (saving 45)
*/

define pmc_30_day_pass();
    ;;; ask for 30 day pass
    'AT+CMGS="441"\r30 DAY\r\^Z'.pmc_send
enddefine;



/* --- Revision History ---------------------------------------------------
--- Aaron Sloman, Apr  4 2010
    Extended with new functions.
 */
