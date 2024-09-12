
SCRDIR=$(HOME)/.config/scbi
VER=$(shell git describe)

all: clean.install
	mkdir -p $(SCRDIR)
	rm -f $(SCRDIR)/*~ scripts.d/*~
	rm -f $(SCRDIR)/.*~ scripts.d/.*~
	cp -r scripts.d/* $(SCRDIR)
	echo "SCBI hands-on : ${VER}" > $(SCRDIR)/.scbi_handson_version.txt

	cd scripts.d; find . -type f > $(SCRDIR)/.handson.plugins

clean.install:
	if [ -f $(SCRDIR)/.handson.plugins ]; then          \
		cat $(SCRDIR)/.handson.plugins |            \
			while read file; do                \
				rm -f $(SCRDIR)/$$file;    \
			done;                              \
		rm -f $(SCRDIR)/.handson.plugins;           \
		rm -f $(SCRDIR)/.scbi_handson_version.txt;  \
	fi

lint:
	scbi lint --error scripts.d/h-*
	echo No problem detected

force:
