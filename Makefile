CC=gcc
CFLAGS=-O2 -Wall -Werror `sdl-config --cflags`
LDLIBS=-luvsqgraphics `sdl-config --libs` -lm -lSDL_ttf

all: clean install zip

%: %.c uvsqgraphics.o
	rm -f $@
	$(CC) $(CFLAGS) $@.c uvsqgraphics.o -o $@ $(LDLIBS)

uvsqgraphics.o: uvsqgraphics.c uvsqgraphics.h 
	sudo install --mode=644 uvsqgraphics.h /usr/local/include/uvsqgraphics.h
	$(CC) $(CFLAGS) -c uvsqgraphics.c -o uvsqgraphics.o

.PHONY: install uninstall clean zip

install: install_packages install_files
	geany demo1.c &

install_packages:
	sudo apt-get install -qq make
	sudo apt-get install -qq gcc
	sudo apt-get install -qq geany
	sudo apt-get install -qq libsdl1.2-dev
	sudo apt-get install -qq libsdl-ttf2.0-dev

install_files:
	sudo install --mode=644 uvsqgraphics.h /usr/local/include/uvsqgraphics.h
	sudo install --mode=644 uvsqcouleur.h /usr/local/include/uvsqcouleur.h
	$(CC) $(CFLAGS) -c uvsqgraphics.c -o uvsqgraphics.o
	sudo ar r /usr/local/lib/libuvsqgraphics.a uvsqgraphics.o
	sudo ranlib /usr/local/lib/libuvsqgraphics.a
	sudo install --mode=644 verdana.ttf /usr/share/fonts/truetype/
	sudo install --mode=755 makeuvsq.sh /usr/local/bin/
	sudo rm -f /usr/local/bin/makeuvsq
	sudo ln -s /usr/local/bin/makeuvsq.sh /usr/local/bin/makeuvsq
	mkdir -p ${HOME}/.config/geany/
	mkdir -p ${HOME}/.config/geany/filedefs/
	install filetypes.c --mode=644 ${HOME}/.config/geany/filedefs/
	install ui_toolbar.xml --mode=644 ${HOME}/.config/geany/

reinstall: uninstall install_files

uninstall: clean
	sudo rm -f /usr/local/lib/libuvsqgraphics.a
	sudo rm -f /usr/local/include/uvsqgraphics.h
	sudo rm -f /usr/local/include/uvsqcouleur.h
	sudo rm -f /usr/share/fonts/truetype/verdana.ttf
	sudo rm -rf /usr/local/share/uvsqgraphics
	sudo rm -f /usr/local/bin/makeuvsq
	sudo rm -f /usr/local/bin/makeuvsq.sh

ZIPNAME=UVSQ_graphics

TEXNAME=doc_uvsqgraphics

clean:
	rm -f demo1 demo2 demo3 demo4
	rm -f uvsqgraphics.o
	rm -rf $(ZIPNAME)
	rm -f $(ZIPNAME).zip
	rm -f $(ZIPNAME).tgz
	rm -f $(TEXNAME).aux
	rm -f $(TEXNAME).log
	rm -f $(TEXNAME).out
	rm -f $(TEXNAME).toc
	rm -f $(TEXNAME).synctex.gz
	ls -l

tar: zip

zip:
	rm -rf $(ZIPNAME)
	rm -f $(ZIPNAME).zip
	mkdir $(ZIPNAME)
	cp uvsqcouleur.h $(ZIPNAME)
	cp demo*.c $(ZIPNAME)
	cp uvsqgraphics.c $(ZIPNAME)
	cp uvsqgraphics.h $(ZIPNAME)
	cp Makefile $(ZIPNAME)
	cp makeuvsq.sh $(ZIPNAME)
	cp filetypes.c $(ZIPNAME)
	cp verdana.ttf $(ZIPNAME)
	cp ui_toolbar.xml $(ZIPNAME)
	cp doc_uvsqgraphics.tex $(ZIPNAME)
	cp doc_uvsqgraphics.pdf $(ZIPNAME)
	cp -r Compilation_separee_avec_uvsqgraphics $(ZIPNAME)
	rm -f $(ZIPNAME)/Compilation_separee_avec_uvsqgraphics/Makefile.sanstab
	zip -r $(ZIPNAME).zip $(ZIPNAME)
	tar cfvz $(ZIPNAME).tgz $(ZIPNAME)
	rm -rf $(ZIPNAME)

tdm:
	echo "graphics.c"
	grep -n "^// [0-9]" graphics.c
	echo "graphics.h"
	grep -n "^// [0-9]" graphics.h
