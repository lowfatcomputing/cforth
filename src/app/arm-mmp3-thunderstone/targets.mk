# APPPATH is the path to the application code, i.e. this directory
APPPATH=$(TOPDIR)/src/app/arm-mmp3-thunderstone
APPPATH2=$(TOPDIR)/src/app/arm-mmp2
APPPATH3=$(TOPDIR)/src/app/arm-xo-1.75

# OBJPATH2 is relative to APPPATH
OBJPATH2=../../../$(BUILDDIR)

# APPLOADFILE is the top-level "Forth load file" for the application code.
APPLOADFILE = app.fth

# APPSRCS is a list of Forth source files that your application uses,
# i.e. the list of files that app.fth floads.  It's for dependency checking.
APPSRCS = $(wildcard $(APPPATH)/*.fth) $(wildcard $(APPPATH2)/*.fth) $(wildcard $(APPPATH3)/*.fth)

default: cforth.img shim.img

include $(TOPDIR)/src/platform/arm-xo-1.75/targets.mk
