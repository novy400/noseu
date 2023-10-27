PROJET= NOSEU
BIN_LIB=$(PROJET)BIN
TST_LIB=$(PROJET)TST
BND_LIB=$(BIN_LIB)
RPGUNIT_LIB=RPGUNIT
DBGVIEW=*ALL
DBGVIEWSQL=*SOURCE
LIBLIST= $(BIN_LIB)
INC_LIB= '/home/yv/tmp/'
CCSID=297

# The shell we use
SHELL=/QOpenSys/usr/bin/qsh

all: crtlib init livrerst.srvpgm noseu.bnddir livrelst.pgm

# rules
crtlib: $(BIN_LIB).lib
# TODO: dans init ajouter le chargement de la table 
init: 
livrerst.srvpgm: livrerst.inc livrerst.sqlrpgle
livrelst.pgm: livrerst.srvpgm livrelst.rpgle
noseu.bnddir: livrerst.entry
tst: $(TST_LIB).lib livrerst.srvpgm livrerst.tst

%.lib:
	-system -q "CRTLIB $*"
	@touch $@

%.inc: src/qrpgleref/%.rpgleinc
	system "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1208)" 
	cp  '$<'  $(INC_LIB)
	@touch $@

%.pgm:
	$(eval modules := $(patsubst %,$(BIN_LIB)/%,$(basename $(filter %.rpgle %.sqlrpgle,$(notdir $^)))))
	system "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1208)" 
	liblist -af $(LIBLIST);\
	system "CRTPGM PGM($(BIN_LIB)/$*) MODULE($(modules))"
	@touch $@

%.rpgle: src/qrpglesrc/%.rpgle
	system "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1208)" 
	liblist -af $(LIBLIST);\
	system "CRTRPGMOD MODULE($(BIN_LIB)/$*) SRCSTMF('$<') DBGVIEW($(DBGVIEW)) TGTCCSID($(CCSID))"
	@touch $@

%.sqlrpgle: src/qrpglesrc/%.sqlrpgle
	system "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1208)" 
	liblist -af $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('$<') COMMIT(*NONE) OBJTYPE(*MODULE) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID($(CCSID))') DBGVIEW($(DBGVIEWSQL))"
	@touch $@

%.srvpgm: src/qsrvsrc/%.bnd
	$(eval modules := $(patsubst %,$(BIN_LIB)/%,$(basename $(filter %.rpgle %.sqlrpgle,$(notdir $^)))))
	system "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1208)" 
	liblist -af $(LIBLIST);\
	system "CRTSRVPGM SRVPGM($(BIN_LIB)/$*) MODULE($(modules)) OPTION(*DUPPROC) SRCSTMF('$<')"

	@touch $@
	system "DLTOBJ OBJ($(BIN_LIB)/*ALL) OBJTYPE(*MODULE)"

%.bnddir: 
	-system -q "CRTBNDDIR BNDDIR($(BND_LIB)/$*)"
	liblist -af $(LIBLIST);\

	-system -q "ADDBNDDIRE BNDDIR($(BND_LIB)/$*) OBJ($(patsubst %.entry,(*LIBL/% *SRVPGM *IMMED),$^))"
	@touch $@

%.tst: src/qtstsrc/%.tst.sqlrpgle
	system "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1208)"
	liblist -af $(LIBLIST) $(TST_LIB) $(RPGUNIT_LIB);\
	system "CRTSQLRPGI OBJ($(TST_LIB)/$*) SRCSTMF('$<') COMMIT(*NONE) OBJTYPE(*MODULE) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID(*JOB)') DBGVIEW($(DBGVIEWSQL))"
	liblist -af $(LIBLIST) $(TST_LIB) $(RPGUNIT_LIB);\
	system "CRTSRVPGM SRVPGM($(TST_LIB)/$*) BNDSRVPGM(RUTESTCASE $(BIN_LIB)/$*) EXPORT(*ALL) OPTION(*DUPPROC) MODULE($(TST_LIB)/$*)"
	liblist -af $(LIBLIST) $(TST_LIB) $(RPGUNIT_LIB);\
	system "RUCALLTST TSTPGM($(TST_LIB)/$*)"
	@touch $@
	system "DLTOBJ OBJ($(TST_LIB)/*ALL) OBJTYPE(*MODULE)"

%.entry:
    # Basically do nothing..
	@touch $@


clean:
	rm -f *.pgm *.rpgle *.sqlrpgle *.cmd *.srvpgm *.dspf *.bnddir *.entry *.inc *.cmp

	
release:
	@echo " -- Creating release. --"
	@echo " -- Creating save file. --"
	system "CRTSAVF FILE($(BIN_LIB)/RELEASE)"
	system "SAVLIB LIB($(BIN_LIB)) DEV(*SAVF) SAVF($(BIN_LIB)/RELEASE) OMITOBJ((RELEASE *FILE))"
	-rm -r release
	-mkdir release
	system "CPYTOSTMF FROMMBR('/QSYS.lib/$(BIN_LIB).lib/RELEASE.FILE') TOSTMF('./release/release.savf') STMFOPT(*REPLACE) STMFCCSID(1252) CVTDTA(*NONE)"
	@echo " -- Cleaning up... --"
	system "DLTOBJ OBJ($(BIN_LIB)/RELEASE) OBJTYPE(*FILE)"
	@echo " -- Release created! --"
	@echo ""
	@echo "To install the release, run:"
	@echo "  > CRTLIB $(BIN_LIB)"
	@echo "  > CPYFRMSTMF FROMSTMF('./release/release.savf') TOMBR('/QSYS.lib/$(BIN_LIB).lib/RELEASE.FILE') MBROPT(*REPLACE) CVTDTA(*NONE)"
	@echo "  > RSTLIB SAVLIB($(BIN_LIB)) DEV(*SAVF) SAVF($(BIN_LIB)/RELEASE)"
	@echo ""
