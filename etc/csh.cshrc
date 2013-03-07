# $FreeBSD: release/9.0.0/etc/csh.cshrc 50472 1999-08-27 23:37:10Z peter $
#	$OpenBSD: csh.cshrc,v 1.2 1996/05/26 10:25:19 deraadt Exp $
#
# tcsh configuration
# Martin Tournoij <martin@arp242.net>
# Should work on: FreeBSD, OpenBSD, Linux, OpenSolaris
#

# NetBSD
if (-d /usr/pkg/bin) then
	set prefix = /usr/pkg
# OpenSolaris
else if (-d /opt/csw/bin) then
	set prefix = /opt/csw
# FreeBSD, OpenBSD
else if (-d /usr/local/bin) then
	set prefix = /usr/local
else
    set prefix = 0
endif

set uname = `uname`

###################
### Environment ###
###################
umask 022

setenv PATH ~/bin
setenv PATH ${PATH}:/sbin:/bin:/usr/sbin:/usr/bin
if (-d /usr/local/bin) then
	setenv PATH ${PATH}:/usr/local/bin:/usr/local/sbin
endif
if ($prefix != 0) then
    setenv PATH ${PATH}:${prefix}/bin:/${prefix}/sbin
endif
setenv PATH ${PATH}:/usr/games

# Some commonly installed packages on OpenSolaris
if ($uname == SunOS) then
	setenv PATH ${PATH}:/opt/VirtualBox
	setenv PATH ${PATH}:/opt/csw/gcc4/bin
endif

# /var/ is a memory device on my laptop
if ($uname == FreeBSD && -d /pkgdb) then
	setenv PKG_DBDIR /pkgdb/
	setenv PKG_TMPDIR /tmp/
endif

# Various applications settings
setenv PAGER less
setenv LESS "--ignore-case --LONG-PROMPT --SILENT --no-init"

setenv BLOCKSIZE K
setenv LS_COLORS "no=00:fi=00:di=34:ln=01;31:pi=34;43:so=31;43:bd=30;43:cd=30;43:or=01;35:ex=01;31:"
setenv GREP_COLOR 31 # red
setenv ACK_COLOR_FILENAME red

if ($uname == OpenBSD) then
	# Seems to work better on OpenBSD ...
	setenv TERM xterm-xfree86
else if ($uname == FreeBSD) then
	if ($tty =~ ttyv*) then
		setenv TERM cons25
		/usr/sbin/kbdcontrol -r fast
	else
		setenv TERM xterm-color
	endif
else if ($uname == Linux) then
	setenv TERM xterm-color
else
	setenv TERM vt220
endif

# UTF-8
if (-X locale) then
	setenv LANG en_US.UTF-8
	setenv LC_CTYPE en_US.UTF-8
endif

if ($uname == OpenBSD) then
	setenv PKG_PATH "ftp://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`uname -m`/"
	setenv CVSROOT "anoncvs@anoncvs.fr.openbsd.org:/cvs"
endif

# Set editor
if (-X vim) then
	setenv EDITOR vim
	alias vi "vim"
else if (-X vi) then
	setenv EDITOR vi
endif

# Set browser
if (-X opera) then
	setenv BROWSER opera
else if (-X elinks) then
	setenv BROWSER elinks
else if (-X links) then
	setenv BROWSER links
else if (-X lynx) then
	setenv BROWSER lynx
endif

################
### Settings ###
################
# Basic corrections when completing
set autocorrect

# Show options when autocompleting
set autolist

# Use history to aid expansion
set autoexpand

# Never autologout
set autologout

# Colorize stuff
set color

# set -n and set '\003' will both work
set echo_style=both

# file completion
set filec

# Keep n items in history
set history = 8192

# Logout on ^D
unset ignoreeof

# Show '>' for symlink to dir, and '&' for symlink to nowhere
set listlinks

# List all jobs after ^Z
set listjobs

# Show current dir.
set prompt = "[%~]%# "

# Use % for normal user and # for super
set promptchars = "%#"

# Show date & hostname on right side
set rprompt = "%B%U%m%b%u:%T"

# Never print "DING!" as the time
set noding

# Don't beep
set nobeep

# Don't allow > redirection on existing files (only >>)
set noclobber

# Print exit value if >0
set printexitvalue

# Ask for confirmation if we do rm *
set rmstar

# Save history
set savehist = 8192 merge

# Lists file name suffixes to be ignored by completion
set fignore = (.o .pyc)

#################################################
# Aliases
#################################################
# Update xterm title on directory change (special alias)
alias cwdcmd 'echo -n "\033]2;tcsh: $cwd\007"'

# Modestly color my ls. But not christmas tree Linux colors! (See environment
# variable $LS_COLOR above)
if ($uname == FreeBSD) then
	alias ls "ls-F -I"
	alias la "ls-F -A"
	alias lc "ls-F -lThoI"
	alias lac "ls-F -lThoA"
	alias pdiff "diff -urN -x CVS -x .svn -I '^# .FreeBSD: '"

	# bsdgrep is FreeBSD >=9
	if (-X bsdgrep) then
		alias grep "bsdgrep --color"
	else
		alias grep "grep --color"
	endif
else if ($uname == OpenBSD) then
	if (-X colorls) then
		alias ls "colorls -FG"
		alias la "colorls -FGA"
		alias lc "colorls -FGlTho"
		alias lac "colorls -FGlThoA"
	else
		alias ls "ls -F"
		alias la "ls -FA"
		alias lc "ls -FlTho"
		alias lac "ls -FAlTho"
	endif

	alias pdiff "diff -urN -x CVS -x .svn -I '^# .OpenBSD: '"
else if ($uname == SunOS) then
	alias ls "ls-F"
	alias la "/bin/ls -FA"
	alias lc "/bin/ls -Flho"
	alias lac "/bin/ls -FlAho"
else if ($uname == Linux) then
	unalias ls
	alias ls ls-F
	alias lc ls -lh
	alias la ls -A
	alias lac ls -lhA

	alias sockstat "netstat -lnptu"
else
	# These should work on almost any platform ...
	alias la "ls -a"
	alias lc "ls -l"
	alias lac "ls -la"
endif

# Override the tcsh builtins
if (-x /usr/bin/nice) then
	alias nice "/usr/bin/nice"
else if (-x /bin/nice) then
        alias nice "/bin/nice"
endif
if (-x /usr/bin/time) then
	alias time "/usr/bin/time -h"
endif

# A few move aliases...
alias cp "cp -i"
alias mv "mv -i"
alias make "nice -n 20 make"
alias j "jobs -l"
alias lman "groff -man -Tascii" # `local man' <file>.1

# Third-party stuff
if (-X mplayer) then
	alias music "mplayer -cache-min 0 $* *.{mp3,flac}"
endif

if (-X opera) then
	alias opera "opera -nomail"
endif

# use title in filename
alias youtube-dl 'youtube-dl -t'

if (-X xtermset) then
	alias xt "xtermset -title"
	alias black "xtermset -fg white -bg black"
	alias white "xtermset -fg black -bg white"
else if (-X xtermcontrol) then
	alias xt "xtermcontrol --title"
	alias black "xtermcontrol --fg=white --bg=black"
	alias white "xtermcontrol --fg=black --bg=white"
endif

# Typos
alias sl "ls"
alias l "ls"
alias c "cd"
alias vo "vi"
alias ci "vi" # ci already exists, but few people use it and it mangles files!
alias grpe "grep"
alias Grep "grep"

alias helpcommand man

##############
# Keybinds ###
##############
# Delete
bindkey ^[[3~ delete-char

# Home
bindkey ^[[H beginning-of-line
bindkey ^[[1~ beginning-of-line

# End
bindkey ^[[F end-of-line
bindkey ^[[4~ end-of-line

# F1
bindkey ^[[M run-help
bindkey OP run-help
bindkey ^[[11~ run-help # Putty

# Arrow keys
bindkey -k up history-search-backward
bindkey -k down history-search-forward

# Insert
bindkey ^[[L yank
bindkey ^[[2 yank

#################################################
# Completion
#################################################
set hosts
if ( -r "$HOME/.hosts" ) then
	set hosts=($hosts `grep -Ev '(^#|^$)' $HOME/.hosts`)
endif

if ( -r "$HOME/.ssh/known_hosts" ) then
	set hosts=($hosts `cut -d " " -f 1 ~/.ssh/known_hosts | sort -u`)
endif

set noglob

# Show directories only
complete cd 'C/*/d/'
complete rmdir 'C/*/d/'

# Various built-in
complete alias 'p/1/a/'
complete unalias 'p/1/a/'
complete unset 'p/1/s/'
complete set 'p/1/s/'
complete unsetenv 'p/1/e/'
complete setenv 'p/1/e/'
complete limit 'p/1/l/'
complete bindkey 'C/*/b/'
complete uncomplete 'p/*/X/'
complete fg 'c/%/j/'

# Users
complete chgrp 'p/1/g/'
complete chown 'c/*[.:]/g/' 'p/1/u/:' 'n/*/f/'

# Procs
complete kill 'c/-/S/' 'n/*/`ps axco pid= | sort`/'
complete pkill 'c/-/S/' 'n/*/`ps axco command= | sort -u`/'
complete killall 'c/-/S/' 'n/*/`ps axco command= | sort -u`/'

# Use available commands as arguments
complete which 'p/1/c/'
complete where 'p/1/c/'
complete man 'p/1/c/'
complete apropos 'p/1/c/'

# set up programs to complete only with files ending in certain extensions
complete cc 'p/*/f:*.[cao]/'
complete python 'p/*/f:*.py/'
complete perl 'p/*/f:*.[pP][lL]/'

# Complete hosts
complete ssh 'p/1/$hosts/'
complete sftp 'p/1/$hosts/'
complete scp 'p/1/$hosts/'
complete ping 'p/1/$hosts/'

# Misc.
complete hg 'p/1/(add addremove annotate archive backout bisect bookmarks \
	branch branches bundle cat clone commit copy diff export forget graft \
	grep heads help identify import incoming init locate log manifest \
	merge outgoing parents paths phase pull push recover remove rename \
	resolve revert rollback root serve showconfig status summary tag tags \
	tip unbundle update verify version/)'

complete svn 'p/1/(add blame cat changelist checkout cleanup commit copy \
	delete diff export help import info list lock log merge mergeinfo \
	mkdir move propdel propedit propget proplist propset resolve \
	resolved revert status switch unlock update)/' \
	'n/help/(add blame cat changelist checkout cleanup commit copy \
	delete diff export help import info list lock log merge mergeinfo \
	mkdir move propdel propedit propget proplist propset resolve \
	resolved revert status switch unlock update)/'

complete git 'p/1/(add merge-recursive add--interactive merge-resolve am \
	merge-subtree annotate merge-tree apply mergetool archimport mktag \
	archive mktree bisect mv bisect--helper name-rev blame notes branch \
	pack-objects bundle pack-redundant cat-file pack-refs check-attr \
	patch-id check-ref-format peek-remote checkout prune checkout-index \
	prune-packed cherry pull cherry-pick push clean quiltimport clone \
	read-tree column rebase commit receive-pack commit-tree reflog config \
	relink count-objects remote credential-cache remote-ext \
	credential-cache--daemon remote-fd credential-store remote-ftp daemon \
	remote-ftps describe remote-http diff remote-https diff-files \
	remote-testgit diff-index repack diff-tree replace difftool \
	repo-config difftool--helper request-pull fast-export rerere \
	fast-import reset fetch rev-list fetch-pack rev-parse filter-branch \
	revert fmt-merge-msg rm for-each-ref send-email format-patch send-pack \
	fsck sh-i18n--envsubst fsck-objects shell gc shortlog \
	get-tar-commit-id show grep show-branch hash-object show-index help \
	show-ref http-backend stage http-fetch stash http-push status \
	imap-send stripspace index-pack submodule init symbolic-ref init-db \
	tag instaweb tar-tree log unpack-file lost-found unpack-objects \
	ls-files update-index ls-remote update-ref ls-tree update-server-info \
	mailinfo upload-archive mailsplit upload-pack merge var merge-base \
	verify-pack merge-file verify-tag merge-index web--browse \
	merge-octopus whatchanged merge-one-file write-tree merge-ours)/'

complete find 'n/-fstype/"(nfs 4.2)"/' 'n/-name/f/' \
	'n/-type/(c b d f p l s)/' \
	'n/-user/u/ n/-group/g/' \
	'n/-exec/c/' 'n/-ok/c/' \
	'n/-cpio/f/' \
	'n/-ncpio/f/' \
	'n/-newer/f/' \
	'c/-/(fstype name perm prune type user nouser group nogroup size inum \
		atime mtime ctime exec ok print ls cpio ncpio newer xdev depth \
		daystart follow maxdepth mindepth noleaf version anewer cnewer \
		amin cmin mmin true false uid gid ilname iname ipath iregex \
		links lname empty path regex used xtype fprint fprint0 fprintf \
		print0 printf not a and o or)/' \
	'n/*/d/'

# Only list make targets
complete make 'n@*@`make -pn | sed -n -E "/^[#_.\/[:blank:]]+/d; /=/d; s/[[:blank:]]*:.*//gp;"`@'

complete dd 'c/if=/f/' 'c/of=/f/' \
	'c/conv=*,/(ascii block ebcdic lcase pareven noerror notrunc osync sparse swab sync unblock)/,' \
	'c/conv=/(ascii block ebcdic lcase pareven noerror notrunc osync sparse swab sync unblock)/,' \
	'p/*/(bs cbs count files fillcahr ibs if iseek obs of oseek seek skip conv)/='

# FreeBSD-specific stuff
if ($uname == FreeBSD) then
	complete service 'p/1/`service -l`/' 'n/*/(start stop reload restart status rcvar onestart onestop)/'
	complete ifconfig 'p/1/`ifconfig -l`/'
	complete sysctl 'n/*/`sysctl -Na`/'

	complete pkg_delete 'n@*@`/bin/ls /var/db/pkg`@'
	complete pkg_info 'n@*@`/bin/ls /var/db/pkg`@'
	complete kldload 'n@*@`/bin/ls -1 /boot/modules/ /boot/kernel/ | grep -v symbols | sed "s|\.ko||g"`@'
	complete kldunload 'n@*@`kldstat | awk \{sub\(\/\.ko\/,\"\",\$NF\)\;print\ \$NF\} | grep -v Name`@'
	complete netstat 'n/-I/`ifconfig -l`/' 'n/*/(start stop restart reload status)/'
# Linux
else if  ($uname == Linux) then
	complete service 'p/1/`/bin/ls /etc/init.d`/'
	complete ifconfig 'p/1/`ifconfig -s | sed 1d | cut -d" " -f1`/'
	
	complete chkconfig 'c/--/(list add del)/' 'n@*@`/bin/ls /etc/init.d`@'
endif

unset noglob
