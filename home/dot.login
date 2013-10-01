# vim syntax=tcsh
#
# $FreeBSD: src/etc/csh.login,v 1.22.2.1 2011/09/23 00:51:37 kensmith Exp $
# $hgid:
#

if ( -X fortune ) then
	fortune -a
endif

if ( -f ~/.tcsh/cwdcmd ) then
	source ~/.tcsh/cwdcmd
endif