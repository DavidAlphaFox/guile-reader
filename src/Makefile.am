lib_LTLIBRARIES = libguile-reader.la
libguile_reader_la_SOURCES = reader.c token-readers.c reader-lib.c compat.c
libguile_reader_la_LDFLAGS = -module -version-info 1:0:0 $(GUILE_LDFLAGS)

readerincludedir = $(includedir)/guile-reader

readerinclude_HEADERS = reader.h reader-config.h	\
			token-readers.h reader-lib.h
BUILT_SOURCES = token-reader-lookup.c token-reader-list.c	\
		make-reader-flags.c				\
                reader-lib.x token-readers.x reader.x
CLEANFILES = $(BUILT_SOURCES)

EXTRA_DIST = symbol-token-reader.c example-repl.scm $(TESTS)		\
	     extract-token-readers.sh extract-make-reader-flags.sh	\
	     compat.h

# Some header files are generated (in builddir) and others are in srcdir.
AM_CPPFLAGS = -I$(srcdir) -I$(builddir) -I$(top_builddir)
AM_CFLAGS   = $(GUILE_CFLAGS) $(GCC_CFLAGS)


# We're adding $(GUILE_CFLAGS) since it may contain `-I' flags, and
# hope that it does not contain anything that would make `cpp'
# unhappy.
snarfcppopts = $(DEFS) $(INCLUDES) $(CPPFLAGS) $(AM_CPPFLAGS) \
	       $(GUILE_CFLAGS)


.c.x:
	$(AM_V_GEN)$(guile_snarf) -o $@ $< $(snarfcppopts)


# Token reader lookup.
token-reader-lookup.c: $(srcdir)/token-readers.h
	$(AM_V_GEN) LC_ALL=C ; export LC_ALL ; cat $< |	\
	$(srcdir)/extract-token-readers.sh |		\
	$(GPERF) -t -C -N _scm_token_reader_lookup |	\
	$(SED) -e's/register //g' > "$@.tmp"
	mv "$@.tmp" "$@"

token-reader-list.c: $(srcdir)/token-readers.h
	$(AM_V_GEN) LC_ALL=C ; export LC_ALL ; cat $< | \
	$(srcdir)/extract-token-readers.sh --no-gperf-header | \
	cut -f 1 -d , | sort | $(SED) -e's/^\(.*\)$$/"\1",/g' > $@

# `make-reader' flags.
make-reader-flags.c: $(srcdir)/reader.h
	$(AM_V_GEN) LC_ALL=C ; export LC_ALL ; cat $< |	\
	$(srcdir)/extract-make-reader-flags.sh |	\
	$(GPERF) -t -C -N _scm_to_make_reader_flag |	\
	$(SED) -e's/register //g' > "$@.tmp"
	mv "$@.tmp" "$@"


# These are dependencies between BUILT_SOURCES files.
# Need to be present to guarantee correct build order.
token-readers.x: token-reader-list.c token-reader-lookup.c
reader.x: make-reader-flags.c
