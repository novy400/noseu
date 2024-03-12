BIN_LIB=DEV
APP_BNDDIR=APP
LIBL=$(BIN_LIB)

INCDIR=""
BNDDIR=($(BIN_LIB)/$(APP_BNDDIR))
PREPATH=/QSYS.LIB/$(BIN_LIB).LIB
SHELL=/QOpenSys/usr/bin/qsh

all: .logs .evfevent library $(PREPATH)/$(APP_BNDDIR).BNDDIR

$(PREPATH)/LIVRERST.SRVPGM: $(PREPATH)/LIVRERST.MODULE
$(PREPATH)/$(APP_BNDDIR).BNDDIR: $(PREPATH)/LIVRERST.SRVPGM

.logs:
	mkdir .logs
.evfevent:
	mkdir .evfevent
library:
	-system -q "CRTLIB LIB($(BIN_LIB))"




$(PREPATH)/LIVREDET.MODULE: src/qrpglesrc/livredet.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTRPGMOD MODULE($(BIN_LIB)/LIVREDET) SRCSTMF('src/qrpglesrc/livredet.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB)" > .logs/livredet.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/LIVREDET.MBR') TOSTMF('.evfevent/livredet.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/LIVRELST.MODULE: src/qrpglesrc/livrelst.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTRPGMOD MODULE($(BIN_LIB)/LIVRELST) SRCSTMF('src/qrpglesrc/livrelst.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB)" > .logs/livrelst.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/LIVRELST.MBR') TOSTMF('.evfevent/livrelst.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/LIVRERSTGET.MODULE: src/test/QRPGLESRC/LIVRERST_GETBYCODE.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTRPGMOD MODULE($(BIN_LIB)/LIVRERSTGET) SRCSTMF('src/test/QRPGLESRC/LIVRERST_GETBYCODE.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB)" > .logs/livrerstget.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/LIVRERSTGET.MBR') TOSTMF('.evfevent/livrerstget.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')

$(PREPATH)/LIVRERST.MODULE: src/qrpglesrc/livrerst.sqlrpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/LIVRERST) SRCSTMF('src/qrpglesrc/livrerst.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) COMPILEOPT('TGTCCSID(*JOB)') RPGPPOPT(*LVL2) OPTION(*EVENTF) OBJTYPE(*MODULE)" > .logs/livrerst.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/LIVRERST.MBR') TOSTMF('.evfevent/livrerst.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/L..MODULE: src/qtstsrc/livrerst.tst.sqlrpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/L.) SRCSTMF('src/qtstsrc/livrerst.tst.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) COMPILEOPT('TGTCCSID(*JOB)') RPGPPOPT(*LVL2) OPTION(*EVENTF) OBJTYPE(*MODULE)" > .logs/l..splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/L..MBR') TOSTMF('.evfevent/l..evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')





$(PREPATH)/TFR.FILE: src/sql/testbugFakeRest.sql
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "RUNSQLSTM SRCSTMF('src/sql/testbugFakeRest.sql') COMMIT(*NONE)" > .logs/tfr.splf




$(PREPATH)/LIVRERST.SRVPGM: src/qsrvsrc/livrerst.bnd
	-system -q "CRTBNDDIR BNDDIR($(BIN_LIB)/$(APP_BNDDIR))"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSRVPGM SRVPGM($(BIN_LIB)/LIVRERST) MODULE(LIVRERST) SRCSTMF('src/qsrvsrc/livrerst.bnd') BNDDIR($(BNDDIR)) REPLACE(*YES)" > .logs/livrerst.splf
	-system -q "ADDBNDDIRE BNDDIR($(BIN_LIB)/$(APP_BNDDIR)) OBJ((*LIBL/LIVRERST *SRVPGM *IMMED))"


$(PREPATH)/%.BNDDIR: 
	-system -q "CRTBNDDIR BNDDIR($(BIN_LIB)/$*)"
	-system -q "ADDBNDDIRE BNDDIR($(BIN_LIB)/$*) OBJ($(patsubst %.SRVPGM,(*LIBL/% *SRVPGM *IMMED),$(notdir $^)))"




