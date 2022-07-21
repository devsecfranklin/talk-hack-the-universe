dnl Process this file with autoconf
AC_PREREQ([2.69])
AC_INIT(talk-hack-the-universe, 1.1, 2730246+devsecfranklin@users.noreply.github.com, https://github.com/devsecfranklin/talk-hack-the-universe)
AC_CONFIG_MACRO_DIR(config/m4)
AC_CONFIG_AUX_DIR(config)
AM_INIT_AUTOMAKE(foreign)

LT_INIT

AC_CONFIG_COMMANDS([franklin-build],
 [echo "(⊃｡•́‿•̀｡)⊃━⭑･ﾟﾟ･*:༅｡.｡༅:*ﾟ:*:✼✿ Configuring for $mypkgname ☽༓･*˚⁺‧͙"],
 [mypkgname=$PACKAGE_NAME])
AC_CONFIG_FILES([
 Makefile
 talk/Makefile
])

dnl le python

AM_PATH_PYTHON(3.9) # minimum version of Python
PY39="python$PYTHON_VERSION" # define the python interpreter
dnl LDFLAGS="$LDFLAGS -l$PY39"
AC_SUBST(PY39, python$PYTHON_VERSION)

AC_SUBST(GITVERSION)
AC_SUBST(GITTAG)
AC_SUBST(GITBRANCH)

if test -e $srcdir/.git
then
AC_CHECK_PROG(HAS_GIT, git, found, not-found)
else
HAS_GIT=no-repository
fi
if test $HAS_GIT = found
then
    GITVERSION="git --git-dir \$(srcdir)/.git rev-parse --short HEAD"
    GITTAG="git --git-dir \$(srcdir)/.git describe --all --always --dirty"
    GITBRANCH="git --git-dir \$(srcdir)/.git name-rev --name-only HEAD"
else
    GITVERSION=""
    GITTAG=""
    GITBRANCH=""
fi

# AC_CANONICAL_HOST is needed to access the 'host_os' variable    
AC_CANONICAL_HOST

build_linux=no
build_windows=no
build_mac=no

# Detect the target system
case "${host_os}" in
    linux*)
        build_linux=yes
        ;;
    cygwin*|mingw*)
        build_windows=yes
        ;;
    darwin*)
        build_mac=yes
        ;;
    *)
        AC_MSG_ERROR(["OS $host_os is not supported"])
        ;;
esac

# Pass the conditionals to automake
AM_CONDITIONAL([LINUX], [test "$build_linux" = "yes"])
AM_CONDITIONAL([WINDOWS], [test "$build_windows" = "yes"])
AM_CONDITIONAL([OSX], [test "$build_mac" = "yes"])

AC_LATEX_CLASS_ARTICLE
AC_LATEX_CLASS_BOOK
AC_LATEX_CLASS_REPORT
AC_LATEX_PACKAGE_AMSMATH
AC_LATEX_PACKAGE_FONTENC
AC_PROG_DVIPDF
AC_PROG_DVIPS
AC_PROG_FIG2DEV
AC_PROG_GNUPLOT
AC_PROG_MF
AC_PROG_LATEX
AC_PROG_BIBTEX
AC_PROG_PDFLATEX
AC_PROG_PS2PDF
dnl AC_PROG_LATEX2HTML
dnl AC_PROG_LATEX2MAN
AC_PROG_MAKEINDEX
dnl AC_PROG_JPEG2PS
AC_PROG_MKTEXPK
AC_PROG_TEXHASH
AC_PROG_KPSEWHICH
dnl AC_TEXMF_PATH
AC_PROG_PNGTOPNM
AC_PROG_PNMTOPS
AC_PROG_JPEGTOPNM
dnl AC_PROG_LATEX2PNG
dnl AC_PROG_LATEX2RTF
AC_PROG_PSBOOK
AC_PROG_PSNUP
AC_PROG_PSSELECT
AC_PROG_PSRESIZE
AC_PROG_DVIBOOK

AC_OUTPUT
