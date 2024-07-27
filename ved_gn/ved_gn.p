/* --- Copyright University of Birmingham 2005. All rights reserved. ------
 > File:            $usepop/pop/packages/ved_gn/ved_gn.p
 > Linked to:       $usepop/pop/packages/lib/ved_gn.p
 > Purpose:			Make "ved_gn" libraries and document available
 > Author:          Aaron Sloman,  8 Jan 2005
 > Documentation:	HELP * VED_GN, VED_POSTNEWS
 > Related Files:	LIB * unix_sockets
 */

/*

Compile this file to make ved_gn available.
Then try HELP ved_gn

*/


section;

global constant ved_gn;

unless isundef(ved_gn) then [endsection;] -> proglist endunless;

lconstant
	ved_gn_dir =
			;;; Default is THIS directory
			sys_fname_path(popfilename);

lconstant ved_gn_auto =    ved_gn_dir dir_>< 'auto/';
;;; lconstant ved_gn_lib =     ved_gn_dir dir_>< 'lib/';
;;; lconstant ved_gn_include = ved_gn_dir dir_>< 'include/';

;;; Load and show from ved_gn_ directory
extend_searchlist(ved_gn_auto, popautolist) -> popautolist;
;;; extend_searchlist(ved_gn_lib, popuseslist) -> popuseslist;
;;; extend_searchlist(ved_gn_include, popincludelist) -> popincludelist;

;;; And extend ved's teach and help and ref lists
lconstant
	;;; ved_gn_teach = [% ved_gn_dir dir_>< 'teach/' % teach],
	ved_gn_help = [% ved_gn_dir dir_>< 'help/' % help],
	;;; ved_gn_ref = [% ved_gn_dir dir_>< 'ref/' % help],
	ved_gn_teachlist = [^ved_gn_help],
	ved_gn_helplist = [^ved_gn_help],
;;;	ved_gn_reflist = [^ved_gn_help],
;

extend_searchlist([^ved_gn_help], vedhelplist) -> vedhelplist;
;;; extend_searchlist(ved_gn_teachlist, vedteachlist) -> vedteachlist;
extend_searchlist(ved_gn_helplist, vedteachlist,true) -> vedteachlist;
;;; extend_searchlist(ved_gn_reflist, vedreflist) -> vedreflist;
;;; extend_searchlist(ved_gn_helplist, vedreflist, true) -> vedreflist;

pop11_compile(ved_gn_auto dir_>< 'ved_gn.p');
;;; Not needed
;;; global constant ved_gn = true;
endsection;

/* --- Revision History ---------------------------------------------------
 */
