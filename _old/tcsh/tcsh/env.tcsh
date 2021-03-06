# Setup PATH
if ($uname != win32) then
	setenv PATH ~/Local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games

	if (-d /usr/local/bin && $prefix != "/usr/local") then
		setenv PATH ${PATH}:/usr/local/bin:/usr/local/sbin
	endif
	if ($prefix != 0) setenv PATH ${PATH}:${prefix}/bin:${prefix}/sbin
	if (-d /usr/X11R6/bin) setenv PATH ${PATH}:/usr/X11R6/bin:/usr/X11R6/sbin
endif

# Some commonly installed packages on OpenSolaris
if ($uname == SunOS) setenv PATH ${PATH}:/opt/VirtualBox:/opt/csw/gcc4/bin

# Only use the newest Ruby
if ( -d "$HOME/.gem/ruby/2.3.0/bin" ) then
	setenv PATH "${PATH}:$HOME/.gem/ruby/2.3.0/bin/"
else if ( -d "$HOME/.gem/ruby/2.2.0/bin" ) then
	setenv PATH "${PATH}:$HOME/.gem/ruby/2.2.0/bin/"
else if ( -d "$HOME/.gem/ruby/2.1.0/bin" ) then
	setenv PATH "${PATH}:$HOME/.gem/ruby/2.1.0/bin/"
endif

# Setup Go
setenv GOPATH ~/gocode
#setenv GOPATH ~/code/TeamworkDesk
#setenv GOPATH ~/gocode:/home/martin/code/TeamworkDesk
if ( -d "$HOME/gocode/bin" ) setenv PATH "${PATH}:$HOME/gocode/bin"

# Various applications settings
setenv BLOCKSIZE K
setenv PAGER less
setenv LESS "--ignore-case --LONG-PROMPT --SILENT --no-init --no-lessopen"

# Make man pages 80 characters wide at the most; this is the default on BSD, but
# not Linux
setenv MANWIDTH 80

# Colors for ls(1)
setenv LS_COLORS "no=00:fi=00:di=34:ln=01;31:pi=34;43:so=31;43:bd=30;43:cd=30;43:or=01;35:ex=31:"

# Older GNU grep; BSD grep
setenv GREP_COLOR 31

# Newer GNU grep, I guess GREP_COLOR was too easy to use
setenv GREP_COLORS "ms=31:mc=31:sl=0:cx=0:fn=0:ln=0:bn=0:se=0"

# Fix scrolling in GTK3; https://www.pekwm.org/projects/pekwm/tasks/350
setenv GDK_CORE_DEVICE_EVENTS 1

# Make compose key work for GTK, Qt
setenv GTK_IM_MODULE xim
setenv QT_IM_MODULE xim

# Disable retarded "overlay scrollbar"
setenv GTK_OVERLAY_SCROLLING 0

# Don't output to a pager
setenv SYSTEMD_PAGER

# /var/ is a memory device on my laptop
if ($uname == FreeBSD && -d /pkgdb) setenv PKG_DBDIR /pkgdb/

if ($uname == OpenBSD) then
	setenv PKG_PATH "ftp://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`uname -m`/"
	setenv CVSROOT "anoncvs@anoncvs.fr.openbsd.org:/cvs"
endif

# Do the $TERM dance; these options seem to work best on various systems...
if (($?TMUX)) then
	setenv TERM screen-256color
else if ($uname == OpenBSD) then
	setenv TERM xterm-xfree86
else if ($uname == FreeBSD) then
	if ($tty =~ ttyv*) then
		setenv TERM cons25
	else
		setenv TERM xterm-256color
	endif
else if ($uname == Linux) then
	setenv TERM xterm-256color
	#setenv TERM xterm-color
else
	setenv TERM vt220
endif

# UTF-8
if (-X locale) then
	setenv LANG en_US.UTF-8
	setenv LC_CTYPE en_US.UTF-8
	setenv LC_COLLATE en_US.UTF-8

	#setenv I18NPATH ~/.locale
	#setenv LOCPATH ~/.locale
endif

# Set editor
if (-X vim) then
	setenv EDITOR vim
	# TODO: What if vim has no +clientserver?
	#alias vim "vim -p --servername vim"
	alias vim "vim -p"
	alias vi "vim"
else if (-X vi) then
	setenv EDITOR vi
endif

if (-X chromium) setenv BROWSER chromium

# Set DISPLAY on remote login
if ($?REMOTEHOST && ! $?DISPLAY) then 
	setenv DISPLAY ${REMOTEHOST}:0
endif

# Run commands from this file; only run for interactive prompt
if (-f "$HOME/Local/python-startup") setenv PYTHONSTARTUP ~/Local/python-startup

# This makes font looks non-ugly in Java applications
setenv _JAVA_OPTIONS "-Dswing.aatext=true -Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

# Stupid Android Sdk tricks
#setenv ANDROID_HOME /home/martin/milo/android-sdk-linux
#setenv PATH "${PATH}:/home/martin/milo/android-sdk-linux/tools:/home/martin/milo/android-sdk-linux/platform-tools"

foreach f ( /etc/profile.d/*.csh )
	if ( -r $f ) source $f
end
unset f
