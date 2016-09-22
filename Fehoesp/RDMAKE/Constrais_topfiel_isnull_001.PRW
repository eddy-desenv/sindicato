#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 05/07/01

User Function DEFAULT()        // incluido pelo assistente de conversao do AP5 IDE em 05/07/01
Processa({|lEnd| U_defproc()})
Return

User Function defproc()
Local cBanco  
Local cEmpAnt,cArqSX2
SetPrvt("CBANCO,CSERVER,CDATABASE,CFILE,CEMPANT,CARQSX2")
SetPrvt("CARQUIVO,ASTRU,CQUERY,NI,NCONECTA,")

MsgAlert("Este programa tem o objetivo de ajustar a estrutura das tabelas que não possuam os DEFAULT e tambem as colunas que estão com NULOS.Esta rotina funciona somente SQL,ORACLE.")

If !MsgYesNo("Inicia a execução S/N ? ",OemToAnsi('ATENCAO'))
	Return
Endif

cBanco := Alltrim(Upper(TCGetDb()))
if Subs(cBanco,1,5) <> "MSSQL" .And. cBanco <> "ORACLE" .And. cBanco <> "DB2"
  Return
Endif

dbSelectArea("SM0")
ProcRegua(SM0->(LastRec()))
dbGotop()
cEmpAnt := "@@"
While !Eof()
	IncProc()
	IF M0_CODIGO == cEmpAnt
		dbSkip()
		LOOP
	Endif
	cEmpAnt := M0_CODIGO
	//@ 14,10 Say "Criando Constraints da Empresa "+SM0->M0_CODIGO
	//@ 15,10 Say Space(59)
	//@ 16,10 Say Space(59)
	//@ 17,10 Say Space(59)

	//cArqSX2 := "SX2"+M0_CODIGO+"0"
    //USE (cArqSX2) ALIAS SX2 SHARED NEW VIA "DBFNTX"
	//INDEX ON X2_CHAVE TO Y
	dbSelectArea("SX2")    
	dbSetOrder(1)          
	Set Filter to
	
	dbGotop()
	While !Eof()
		//@ 15,10 Say "  Criando Constraints da Tabela "+SX2->X2_ARQUIVO
		//@ 16,10 Say Space(59)
		//@ 17,10 Say Space(59)
		u_RebuildFile(SX2->X2_ARQUIVO,cBanco)
		dbSelectArea("SX2")
		dbSkip()
	End
	dbSelectArea("SM0")
	dbSkip()
End
//Ferase("x.ntx")
//TCQUIT()
MsgStop("Processo concluido. Reinicialize o Servico do TopConnect")
Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DEFAULT_AP5ºAutor  ³Microsiga           º Data ³  07/05/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
// Substituido pelo assistente de conversao do AP5 IDE em 05/07/01 ==> Static Function RebuildFile(cArquivo,cBanco)
User Function RebuildFile(cArquivo,cBanco)
Local aStru,ni,cQuery

cArquivo := Upper(Alltrim(cArquivo))
IF "."$cArquivo
	cArquivo := Subs(cArquivo,1,AT(".",cArquivo)-1)
Endif
IF !TCCanOpen(cArquivo)
	Return Nil
Endif

IF Subs(cBanco,1,5) != "MSSQL"
   USE &cArquivo ALIAS TRBXTRB Shared NEW VIA "TOPCONN"
   aStru := dbStruct()
   dbCloseArea()

   dbCreate("TRBXTRB",aStru,"TOPCONN")
   cQuery := "INSERT INTO TRBXTRB SELECT * FROM "+cArquivo

   TCSQLEXEC(cQuery)
   IF substr(cBanco,1,6) == "ORACLE"
      TCSQLEXEC("COMMIT")
   Endif
   TCDELFILE(cArquivo)
   dbCreate(cArquivo,aStru,"TOPCONN")
   cQuery := "INSERT INTO "+cArquivo+" SELECT * FROM TRBXTRB"
   TCSQLEXEC(cQuery)
   IF substr(cBanco,1,6) == "ORACLE"
 	   TCSQLEXEC("COMMIT")
   Endif
   TCDELFILE("TRBXTRB")
   TCSQLEXEC(cQuery)
   IF substr(cBanco,1,6) == "ORACLE"
 	   TCSQLEXEC("COMMIT")
   Endif
Else
   USE &cArquivo ALIAS TRBXTRB Shared NEW VIA "TOPCONN"
   aStru := dbStruct()
   dbCloseArea()

   For ni:= 1 to Len(aStru)
	  cQuery := "UPDATE "+cArquivo+" SET "+aStru[ni,1]+" = "
	  IF aStru[ni,2] == "N"
	  	  cQuery += "0" 
	  Else
	  	  cQuery += "'"+Space(aStru[ni,3])+"'"
	  Endif
	  cQuery += " WHERE "+aStru[ni,1]+" IS NULL"	
	  @ 16,10 Say "     Gravando DEFAULTS de   "+aStru[ni,1]+Space(10)
	  @ 17,10 Say Space(59)
	  TCSQLEXEC(cQuery)

     cQuery := "ALTER TABLE "+cArquivo+" ADD DEFAULT "
 	  IF aStru[ni,2] == "N"
   	  cQuery += "0" 
     Else
	    cQuery += "'"+Space(aStru[ni,3])+"'"
     Endif
  	  cQuery += " FOR "+aStru[ni,1]
	  @ 17,10 Say "     Criando Constraints de "+aStru[ni,1]+Space(10)
     TCSQLEXEC(cQuery)

   Next
   cQuery := "UPDATE "+cArquivo+" SET D_E_L_E_T_ = ' ' WHERE D_E_L_E_T_ IS NULL"
   TCSQLEXEC(cQuery)
   cQuery := "ALTER TABLE "+cArquivo+" ADD DEFAULT ' ' FOR D_E_L_E_T_"
   TCSQLExec(cQuery)
   cQuery := "DELETE FROM TOP_FIELD WHERE FIELD_TABLE LIKE '%"+Alltrim(Upper(cArquivo))+"' AND FIELD_NAME = '@@HAS_DFT_VAL@@'"
   TCSQLEXEC(cQuery)
   cQuery := "INSERT INTO TOP_FIELD VALUES('dbo."+Upper(cArquivo)+"','@@HAS_DFT_VAL@@','X','0','0')"
   TCSQLExec(cQuery)
Endif
Return
