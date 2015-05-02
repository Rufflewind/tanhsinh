.POSIX:
.SUFFIXES:

PREFIX=/usr/local
ARFLAGS=-cru
CFLAGS=-fPIC -g -O2 -pedantic -Wall -Wconversion
LIBS=-lm

major=1
version=$(major).0.0

all: dist/lib/libtanhsinh.a dist/lib/libtanhsinh.so

clean:
	rm -fr dist

check: dist/bin/tanhsinh-example
	dist/bin/tanhsinh-example

doc:
	. ./tools && doc_init dist/share/doc/tanhsinh
	doxygen

doc-upload: doc
	. ./tools && doc_upload dist/share/doc/tanhsinh

install: all
	install -Dm644 tanhsinh.h $(DESTDIR)$(PREFIX)/include/tanhsinh.h
	install -Dm644 dist/lib/libtanhsinh.a \
	    $(DESTDIR)$(PREFIX)/lib/libtanhsinh.a
	install -m755 -t $(DESTDIR)$(PREFIX)/lib \
	    dist/lib/libtanhsinh.so.$(version)
	cp -P \
	    dist/lib/libtanhsinh.so \
	    dist/lib/libtanhsinh.so.$(major) \
	    $(DESTDIR)$(PREFIX)/lib

uninstall:
	rm -f \
	    $(DESTDIR)$(PREFIX)/include/tanhsinh.h \
	    $(DESTDIR)$(PREFIX)/lib/libtanhsinh.a \
	    $(DESTDIR)$(PREFIX)/lib/libtanhsinh.so \
	    $(DESTDIR)$(PREFIX)/lib/libtanhsinh.so.$(major) \
	    $(DESTDIR)$(PREFIX)/lib/libtanhsinh.so.$(version)

.PHONY: all check clean doc doc-upload install uninstall

dist/bin/tanhsinh-example: dist/tmp/example.o dist/lib/libtanhsinh.a
	mkdir -p dist/bin
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
	    dist/tmp/example.o dist/lib/libtanhsinh.a $(LIBS)

dist/lib/libtanhsinh.a: dist/tmp/tanhsinh.o
	mkdir -p dist/lib
	$(AR) $(ARFLAGS) $@ dist/tmp/tanhsinh.o

dist/lib/libtanhsinh.so: dist/lib/libtanhsinh.so.$(major)
	ln -fs libtanhsinh.so.$(major) $@

dist/lib/libtanhsinh.so.$(major): dist/lib/libtanhsinh.so.$(version)
	ln -fs libtanhsinh.so.$(version) $@

dist/lib/libtanhsinh.so.$(version): dist/tmp/tanhsinh.o
	mkdir -p dist/lib
	$(CC) -shared -Wl,-soname,libtanhsinh.so.$(major) -o $@ \
	    dist/tmp/tanhsinh.o $(LIBS)

dist/tmp/tanhsinh.o: tanhsinh.c tanhsinh.h
	mkdir -p dist/tmp
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c tanhsinh.c

dist/tmp/example.o: example.c tanhsinh.h
	mkdir -p dist/tmp
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c example.c
