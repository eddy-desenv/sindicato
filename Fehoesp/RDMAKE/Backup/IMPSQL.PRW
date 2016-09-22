#include "rwmake.ch"
#include "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPSQL    ºAutor  ³Jaime Wikanski      º Data ³  30/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de importacao em batch de tabelas de dbf para        º±±
±±º          ³o Top Connect                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ImpSql()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cEmpresa		:= SM0->M0_CODIGO
Local nI       		:= 0
Local xEmps   		:= {}
Local cTitulo  		:= OemToAnsi("Empresas de origem disponiveis")
Local nOpc     		:= 0
Local oOk      		:= LoadBitMap(GetResources(),"LBOK")
Local oNo      		:= LoadBitMap(GetResources(),"LBNO")
Local aTitulo  		:= {" ", "Empresa", "Filial", "Nome", "Emp Destino", "Fil Destino", "Nome Destino"}
Local oListBox
Local aList			:= {}
Local oSay
Local oDlg
Local cPerg			:= "IMPSQL"
Local cType			:=	"Arquivos de empresa|SIGAMAT.EMP"
Private cPath		:= ""
Private cMensagem   := ""     
Private cMens		:= "" 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abre tela se selacao do path do arquivo SIGAMAT.EMP                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPath := Alltrim(StrTran(cGetFile(cType, OemToAnsi("Selecione o diretorio de do arquivo SIGAMAT.EMP da versao 4.07"),0,"SERVIDOR\",.T.,GETF_RETDIRECTORY),"\SERVIDOR",""))
If Empty(cPath)
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se encontrou o arquivo SIGAMAT.EMP da 4.07                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File(cPath+"SIGAMAT.EMP")
	Aviso("Inconsistencia","Arquivo SIGAMAT.EMP da versao 4.07 não localizado no path especificado !",{"Ok"},,"Atencao:")
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abre o arquivo SM0 da 4.07                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Select("SM0ORI") > 0
	DbSelectArea("SM0ORI")
	DbCloseArea()
Endif
dbUseArea(.T.,,lower(Alltrim(cPath)+"sigamat.emp"),"SM0ORI",.t.,.t.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pesquisa os arquivos no diretorio de retorno                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aList := {}
DbSelectArea("SM0ORI")
DbGoTop()
While !EOF()
	Aadd( aList, { .F., SM0ORI->M0_CODIGO, SM0ORI->M0_CODFIL, Alltrim(SM0ORI->M0_FILIAL)+"/"+Alltrim(SM0ORI->M0_NOME), "", "", ""})
	DbSelectArea("SM0ORI")
	DbSkip()
Enddo
Asort(aList,,,{|x,y| x[2] <= y[2] .and. x[3] <= y[3]})
If Select("SM0ORI") > 0
	DbSelectArea("SM0ORI")
	DbCloseArea()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a tela de selecao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aList) > 0
   DEFINE MSDIALOG oDlg TITLE cTitulo From 9,0 To 19,60 OF oMainWnd 
  
   @ .5,.7 LISTBOX oListBox VAR cListBox Fields ;
            HEADER  aTitulo[1],;
            		OemtoAnsi(aTitulo[2]),;
            		OemtoAnsi(aTitulo[3]),;
            		OemtoAnsi(aTitulo[4]),;
            		OemtoAnsi(aTitulo[5]),;
            		OemtoAnsi(aTitulo[6]),;
            		OemtoAnsi(aTitulo[7]) ;
            SIZE 195,62 ON DBLCLICK (Iif(VerSX2(aList[oListBox:nAt,2], @aList, oListBox:nAt) == .T., aList[oListBox:nAt,1] := !aList[oListBox:nAt,1], aList[oListBox:nAt,1] := .F.),oListBox:Refresh()) //NOSCROLL

   oListBox:SetArray(aList)
   oListBox:bLine := { || {	If(aList[oListBox:nAt,1],oOk,oNo),;
   							aList[oListBox:nAt,2],;
   							aList[oListBox:nAt,3],;
   							aList[oListBox:nAt,4],;
   							aList[oListBox:nAt,5],;
   							aList[oListBox:nAt,6],;
   							aList[oListBox:nAt,7]}}

   DEFINE SBUTTON FROM    4,206 	TYPE 1  ACTION (nOpc := 1,oDlg:End())       ENABLE OF oDlg 
   DEFINE SBUTTON FROM 18.5,206 	TYPE 2  ACTION (nOpc := 0,oDlg:End())       ENABLE OF oDlg

   ACTIVATE MSDIALOG oDlg CENTERED
Endif
                                                             
If nOpc == 1
	If Len(aList) <= 0 .or. Ascan(aList,{|x| x[1] == .T.}) <= 0
	    Aviso("Atencao !", "Não foram localizadas empresas cadastradas nesse SIGAMAT.EMP ou nenhuma empresa selecionada para importacao",{"Ok"})
	Else                                 
		Processa({|| AppendTable(aList)})
	Endif
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VerSX2     ºAutor  ³Jaime Wikanski     º Data ³  30/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que verifica se o SX2 esta no mesmo path do arquivo  º±±
±±º          ³sigamat.emp                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VerSX2(cEmpOri, aList, nPos)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lReturn 	:= .T.
Local aEmpDest	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o arquivo SX2 existe                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File(cPath+"SX2"+Alltrim(cEmpOri)+"0.DBF") .and. aList[nPos,1] == .F.
	Aviso("Inconsistencia","Não foi possivel localizar o arquivo SX2"+Alltrim(cEmpOri)+"0.DBF. O mesmo deve estar no diretório "+Alltrim(cPath)+".",{"Ok"},,"Atencao:")
	lReturn := .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a empresa de destino                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lReturn .and. aList[nPos,1] == .F.
	aEmpDest := SeleDest(cEmpOri)
	If Len(aEmpDest) > 0
		aList[nPos,5] := aEmpDest[1]
		aList[nPos,6] := aEmpDest[2]
		aList[nPos,7] := aEmpDest[3]
	Else
		lReturn := .F.
	Endif
Endif

Return(lReturn)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SeleDest  ºAutor  ³Jaime Wikanski      º Data ³  30/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela de selecao das empresas de destino dos arquivos        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SeleDest(cEmpSel)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nI       		:= 0
Local xEmps   		:= {}
Local cTitulo  		:= OemToAnsi("Empresas de destino disponiveis")
Local nOpc     		:= 0
Local oOk      		:= LoadBitMap(GetResources(),"LBOK")
Local oNo      		:= LoadBitMap(GetResources(),"LBNO")
Local aTitulo  		:= {" ", "Empresa", "Filial", "Nome"}
Local oListBox
Local oSay
Local oDlg
Local aReturn		:= {}
Local nPos			:= 1
Local aList			:= {}
Local nRecSM0		:= SM0->(Recno())
Local lMarcou		:= .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pesquisa os arquivos no diretorio de retorno                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aList := {}
DbSelectArea("SM0")
DbGoTop()
While !EOF()                  
	If SM0->M0_CODIGO $ "99/20" 
		DbSelectArea("SM0")
		DbSkip()
		Loop
	Endif
	Aadd( aList, {Iif(SM0->M0_CODFIL == cEmpSel .and. !lMarcou, .T., .F.), SM0->M0_CODIGO, SM0->M0_CODFIL, Alltrim(SM0->M0_FILIAL)+"/"+Alltrim(SM0->M0_NOME)} )
	If SM0->M0_CODFIL == cEmpSel
		lMarcou := .T.
	Endif
	DbSelectArea("SM0")
	DbSkip()
Enddo
Asort(aList,,,{|x,y| x[3] <= y[3]})
DbGoTo(nRecSM0)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a tela de selecao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aList) > 0
   DEFINE MSDIALOG oDlg TITLE cTitulo From 9,0 To 19,60 OF oMainWnd 
  
   @ .5,.7 LISTBOX oListBox VAR cListBox Fields ;
            HEADER  aTitulo[1],;
            		OemtoAnsi(aTitulo[2]),;
            		OemtoAnsi(aTitulo[3]),;
            		OemtoAnsi(aTitulo[4]) ;
            SIZE 195,62 ON DBLCLICK (Iif(aList[oListBox:nAt,1] == .F., (LimpaSel(@aList), aList[oListBox:nAt,1] := !aList[oListBox:nAt,1]), aList[oListBox:nAt,1] := .F.),oListBox:Refresh()) //NOSCROLL

   oListBox:SetArray(aList)
   oListBox:bLine := { || {	If(aList[oListBox:nAt,1],oOk,oNo),;
   							aList[oListBox:nAt,2],;
   							aList[oListBox:nAt,3],;
   							aList[oListBox:nAt,4]}}
   nPos := Ascan(aList,{|x| x[1] == .T.})   							
   If nPos == 0
      nPos := 1
   Endif
   oListBox:nAt := nPos

   DEFINE SBUTTON FROM    4,206 	TYPE 1  ACTION (nOpc := 1,oDlg:End())       ENABLE OF oDlg 
   DEFINE SBUTTON FROM 18.5,206 	TYPE 2  ACTION (nOpc := 0,oDlg:End())       ENABLE OF oDlg

   ACTIVATE MSDIALOG oDlg //CENTERED
Endif
                                                             
If nOpc == 1
	If Len(aList) <= 0 .or. Ascan(aList,{|x| x[1] == .T.}) <= 0
	    Aviso("Atencao !", "Selecione uma empresa de destino para migração dos dados.",{"Ok"})
	Else                                 
		nPosMarca := Ascan(aList,{|x| x[1] == .T.})
		aReturn := {aList[nPosMarca,2],aList[nPosMarca,3],aList[nPosMarca,4]}
	Endif
Endif

Return(aReturn)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LimpaSel   ºAutor  ³Jaime Wikanski     º Data ³  30/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Limpa as demais empresas selecionadas                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function LimpaSel(aList)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nX	:= 0

For nX := 1 to Len(aList)
	aList[nX,1] := .F.
Next nX

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AppendTableºAutor  ³Jaime Wikanski     º Data ³  30/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de importacao em batch de tabelas do CTREE para      º±±
±±º          ³o Top Connect                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AppendTable(aList)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cAlias	:= ""     
Local nX		:= 0
Local nY		:= 0
Local lAbrArea	:= .F.
Local aArea		:= GetArea()
Local cQuery	:= ""
Local nTotRegs	:= 0
Local xArqs		:= {}
Local xArqseMP	:= {}
Local cChave	:= ""
Local cIndSX2	:= ""
Local cEmpAtu	:= SM0->M0_CODIGO

For nY := 1 to Len(aList)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o registro esta marcado                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aList[nY,1] == .F.
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Abre o arquivo SX2 da empresa de origem                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Select("SX2ORI") > 0
		DbSelectArea("SX2ORI")
		DbCloseArea()
	Endif
	dbUseArea(.T.,,lower(Alltrim(cPath)+"SX2"+aList[nY,2]+"0.dbf"),"SX2ORI",.t.,.t.)
	If Select("SX2ORI") <= 0
		Aviso("Inconsistencia","Não foi possivel abrir o arquivo SX2 de origem da empresa "+aList[nY,2]+". Verifique se o mesmo encontra-se no diretório"+Alltrim(cPath),{"Ok"},,"Atencao:")
		// CMENSAGEM := "Não foi possivel abrir o arquivo SX2 de origem da empresa "+aList[nY,2]+". Verifique se o mesmo encontra-se no diretório"+Alltrim(cPath)+cHR(13)+cHR(10)
		Loop
	Endif
	cChave  := "X2_CHAVE"
	cIndSX2 := CriaTrab(Nil,.f.)
	IndRegua("SX2ORI",cIndSX2,cChave,,,"Indexando SX2...")
				
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Retorna os arquivos no path especificado                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	xArqs := Directory(Alltrim(cPath)+"???"+aList[nY,2]+"0.dbf")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pesquisa os arquivos no diretorio                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	xArqsEmp := {}
	ProcRegua(Len(xArqs))
	For ni:= 1 to Len(xArqs)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Incrementa a regua de processamento							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc("Analisando arquivo "+xArqs[ni,1]+"...")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Valida se o arquivo deve ser importado						 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Substr(xArqs[ni,1],1,2) $ "SX" .and. !Substr(xArqs[ni,1],1,3) $ "SIX"
			DbSelectArea("SX2ORI")
			If DbSeek(Substr(xArqs[ni,1],1,3),.F.)
				If Substr(SX2ORI->X2_ARQUIVO,4,2) == aList[nY,2]
					Aadd( xArqsEmp, {xArqs[ni,1], SX2ORI->X2_MODO} )
				Endif
			Endif
		Endif
	Next ni
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza os arquivos temporarios                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Select("SX2ORI") > 0
		DbSelectArea("SX2ORI")
		DbCloseArea()
	Endif
	FErase(cIndSX2+OrdBagExt())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existem arquivos a serem migrados                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(xArqsEmp) == 0
		Aviso("Inconsistencia","Não existem arquivos disponiveis para migração da empresa de origem "+aList[nY,2]+". Verifique a existencia desses arquivos no diretório "+Alltrim(cPath)+" e se os mesmos encontram-se relacionados no SX2 da empresa de origem.",{"Ok"},,"Atencao:")
		Loop
	Endif				

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Abre o SX2 e o SX3 da empresa de destino                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If AbreSXDest(aList[nY,5]) == .F.
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Processa os registros marcados no array                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ProcRegua(Len(xArqsEmp))
	For nX := 1 to Len(xArqsEmp)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Incrementa a regua de processamento							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProc("Importando arquivo "+xArqsEmp[nX,1]+"...")
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Valida se o arquivo esta marcado                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If aList[nY,1] == .F.
			Loop
		Endif	                                          
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alimenta variaveis                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cAlias := Substr(xArqsEmp[nX,1],1,3)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o alias existe no SX3                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("SX3TMP")
		If !DbSeek(cAlias,.F.)
			Aviso("Importacao de tabelas","O alias "+cAlias+" pertencente ao arquivo "+xArqsEmp[nX,1]+" não existe no SX3 da empresa de destino "+aList[nY,5]+". O mesmo sera ignorado!",{"Ok"},,"Atencao:")
			Loop
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o X2_MODO da empresa de destino esta compativel            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("SX2TMP")
		If !DbSeek(cAlias,.F.)
			Aviso("Importacao de tabelas","O alias "+cAlias+" pertencente ao arquivo "+xArqsEmp[nX,1]+" não existe no SX2 da empresa de destino "+aList[nY,5]+". O mesmo sera ignorado!",{"Ok"},,"Atencao:")
			Loop
		Endif
	
	    //TESTE MARCIO
//		If SX2TMP->X2_MODO == "C"
//			RecLock("SX2TMP",.F.)
//			SX2TMP->X2_MODO := "E"
//			MsUnlock()
//		Endif
			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Abre a tabela do Top Connect se o mesmo nao existir                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lAbrArea := .F.
		#IFDEF TOP
			cArquivo := RetArq(__cRdd,Trim(SX2TMP->X2_ARQUIVO),.T.)
			//	If !MsFile(cArquivo)
				DbSelectArea(SX2TMP->X2_CHAVE)
				dbCloseArea()
			//	End
			If !ChkFile(SX2TMP->X2_CHAVE, .F., ,,,,, "SX2TMP")
				Aviso("Importacao de tabelas","O alias "+cAlias+" pertencente ao arquivo "+xArqsEmp[nX,1]+" não pode ser aberto para a empresa de destino"+aList[nY,5]+". O mesmo sera ignorado!",{"Ok"},,"Atencao:")
				Loop
			Else
				lAbrArea := .T.
			Endif      
		#ELSE
			cArquivo := RetArq(__cRdd,AllTrim(SX2TMP->X2_PATH)+Trim(SX2TMP->X2_ARQUIVO),.T.)
			If !MsFile(AllTrim(SX2TMP->X2_PATH)+Trim(SX2TMP->X2_ARQUIVO))
				dbCloseArea()
				lRet := .F.
				Help(" ",1,"CT220ERR")
			End
			If lRet 
				If !ChkFile(SX2TMP->X2_CHAVE, .F., SX2TMP->X2_CHAVE,,,,, "SX2TMP")
					Aviso("Importacao de tabelas","O alias "+cAlias+" pertencente ao arquivo "+xArqsEmp[nX,1]+" não pode ser aberto para a empresa de destino"+aList[nY,5]+". O mesmo sera ignorado!",{"Ok"},,"Atencao:")
					Loop
				Else
					lAbrArea := .T.
				Endif      
			EndIf
		#ENDIF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Abre o arquivo dbf                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Select("TMP") > 0
			DbSelectArea("TMP")
			DbCloseArea()
		Endif                 
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Copia o arquivo para o diretorio padrao                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbUseArea(.T.,__Localdriver,lower(Alltrim(cPath)+xArqsEmp[nX,1]),"TMP",.t.,.F.)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Valida se abriu o arquivo DBF                               	       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Select("TMP") <= 0
			Aviso("Importacao de tabelas","O arquivo DBF "+xArqsEmp[nX,1]+" não foi aberto. O mesmo sera ignorado!",{"Ok"},,"Atencao:")
			Loop
		Endif
	                        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Appenda o arquivo                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MsAguarde( {||Importa(cAlias, Alltrim(cPath)+xArqsEmp[nX,1], SX2TMP->X2_MODO, aList[nY,6], Trim(SX2TMP->X2_ARQUIVO))},"Importando alias "+cAlias )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fecha a area se abriu o arquivo do Top Connect                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbrArea == .T.
			DbSelectArea(cAlias)
			DbCloseArea()
		Endif
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fecha o arquivo dbf                                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Select("TMP") > 0
			DbSelectArea("TMP")
			DbCloseArea()
		Endif
		nnPos		:=AT(".",xArqsEmp[nX,1])-1
		cExt		:= ".#"+Subs(xArqsEmp[nX,1],nnPos+2,2)
		cArqTemp 	:= Alltrim(cPath)+Subs(xArqsEmp[nX,1],1,nnPos)+cExt
		cArqFor		:= Alltrim(cPath)+xArqsEmp[nX,1]
		RENAME &cArqFor TO &cArqTemp  && Renome Arquivo .FOR p/ .#FO (Ja Processado)
	Next nX
Next nY
	
RestArea(aArea)

MemoWrite("LOGIMP.TXT",cMensagem)

Final("Reinicialize o sistema !")

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AbreSXDest  ³ Autor ³ Jaime Wikanski        ³ Data ³ 30/03/04³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Efetua a abertura do arquivo da outra empresa               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AbreSXDest(cEmpDest)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cArquivo    := ""
Local cIndice     := ""
Local nContador   := 0
Local nEmpresa    := 0
Local cModoSX2	  := ""
Local lReturn	  := .T.
       
// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Seleciona o arquivo SX2 da empresa ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArquivo := "SX2" + cEmpDest + "0"
cIndice  := "SX2" + cEmpDest + "01"
If(!File(Trim(cArquivo)+GetDBExtension()))
	MsgStop(cArquivo + OemToAnsi(" n†o encontrado"))
	Return(.F.)
End
If Select("SX2TMP") > 0
	DbSelectArea("SX2TMP")
	DbCloseArea()
Endif
dbUseArea(.T.,, cArquivo,"SX2TMP" , .T., .F.)  

If !File(Trim(cIndice)+ OrdBagExt())
	cIndexKey := "X2_CHAVE"
	IndRegua("SX2TMP",cIndice,cIndexKey,,,OemToAnsi("Selecionando Registros..."))
	dbCommitAll()
	dbClearInd()
	dbSetIndex(cIndice+OrdBagExt())
Else
	dbSetIndex(cIndice+OrdBagExt())
Endif
dbSetOrder(1)

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Seleciona o arquivo SX3 da empresa ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArquivo := "SX3" + cEmpDest + "0"
cIndice  := "SX3" + cEmpDest + "01"
If(!File(Trim(cArquivo)+GetDBExtension()))
	MsgStop(cArquivo + OemToAnsi(" n†o encontrado"))
	Return(.F.)
End
If Select("SX3TMP") > 0
	DbSelectArea("SX3TMP")
	DbCloseArea()
Endif
dbUseArea(.T.,, cArquivo,"SX3TMP" , .T., .T.)  

If !File(Trim(cIndice)+ OrdBagExt())
	cIndexKey := "X3_ARQUIVO+X3_ORDEM"
	IndRegua("SX3TMP",cIndice,cIndexKey,,,OemToAnsi("Selecionando Registros..."))
	dbCommitAll()
	dbClearInd()
	dbSetIndex(cIndice+OrdBagExt())
Else
	dbSetIndex(cIndice+OrdBagExt())
Endif
dbSetOrder(1)

Return(.T.)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ Importa   ºAutor  ³Jaime Wikanski     º Data ³  30/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de importacao em batch de tabelas do CTREE para      º±±
±±º          ³o Top Connect                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Importa(cAlias,cArquivo, cModo, cFilArq, cTabela)

Local bCampo 		:= { |nCPO| Field(nCPO) }
Local nCntFor		:= 0
Local nTotCpo		:= 0
Local cQuery		:= ""                        
Local cKeyUnq		:= ""
Local aCampos		:= {}
Local lTemDup		:= .F.
Local cWhere 		:= ""

DbSelectArea("TMP")
nTotCpo = FCount()
                                                                  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a chave unica do arquivo se estara duplicada                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery := " SELECT x.name, INDEX_COL('dbo."+cTabela+"', x.indid, c.colid) as CAMPO"
cQuery += " from sysindexes x, syscolumns c"
cQuery += " where x.id = object_id('dbo."+cTabela+"')"
cQuery += "     AND indid BETWEEN 1 AND 254"
cQuery += "     AND x.id = c.id"
cQuery += "     AND c.colid <= x.keycnt"
cQuery += "     AND SUBSTRING(x.name,1,1) != '_'"
cQuery += "     AND INDEXPROPERTY(OBJECT_ID('dbo."+cTabela+"'), x.name, 'IsStatistics') = 0"
cQuery += "     AND INDEXPROPERTY(OBJECT_ID('dbo."+cTabela+"'), x.name, 'IsAutoStatistics') = 0"
cQuery += "     AND INDEX_COL('dbo."+cTabela+"',x.indid,c.colid) is not null"
cQuery += "     and x.name like '%UNQ%'"
cQuery += " ORDER BY x.indid, c.colid ASC"     
If Select("QRYIDX") > 0	
	DbSelectArea("QRYIDX")
	DbCloseArea()
Endif
TcQuery cQuery New Alias "QRYIDX"
DbSelectArea("QRYIDX")
DbGoTop()
While !EOF()                  
	If Alltrim(QRYIDX->CAMPO) <> "R_E_C_D_E_L_"
		cKeyUnq += Alltrim(QRYIDX->CAMPO)+" = '*"+Alltrim(QRYIDX->CAMPO)+"*' AND "
		Aadd(aCampos, Alltrim(QRYIDX->CAMPO))
	Endif
	DbSelectArea("QRYIDX")
    DbSkip()
Enddo
If Len(cKeyUnq) > 0
	cKeyUnq := " WHERE "+Substr(cKeyUnq,1,Len(cKeyUnq)-5)
Endif
If Select("QRYIDX") > 0	
	DbSelectArea("QRYIDX")
	DbCloseArea()
Endif

DbSelectArea("TMP")
DbGoTop()
While !EOF()
	If Deleted()
		DbSelectArea("TMP")
		DbSkip()
		Loop
	Endif
	If Len(aCampos) > 0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Executa query verificando duplicidades                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("TMP")                                              
		cQuery := " SELECT COUNT(*) AS DUPLIC"
		cQuery += " FROM "+cTabela+" (NOLOCK)"
		cWhere := cKeyUnq
		For nZ := 1 to Len(aCampos)
			If "FILIAL"$aCampos[nZ] .Or. "FILORIG"$aCampos[nZ]
				cWhere := StrTran(cWhere,"*"+Alltrim(aCampos[nZ])+"*",Iif(cModo == "C", Space(2), cFilArq))
			Else
				//cWhere := StrTran(cWhere,"*"+Alltrim(aCampos[nZ])+"*",&(aCampos[nZ]))
				If ValType(&(aCampos[nZ])) == "C"
					cWhere := StrTran(cWhere,"*"+Alltrim(aCampos[nZ])+"*",&(aCampos[nZ]))
				Else
					cWhere := StrTran(cWhere,"*"+Alltrim(aCampos[nZ])+"*",Dtos(&(aCampos[nZ])))
				Endif
			Endif
		Next nX        
		cQuery += cWhere
		If Select("QRYIDX") > 0	
			DbSelectArea("QRYIDX")
			DbCloseArea()
		Endif
		TcQuery cQuery New Alias "QRYIDX"
		DbSelectArea("QRYIDX")
		DbGoTop()
		If QRYIDX->DUPLIC > 0
			lTemDup := .T.
			DbSelectArea("TMP")
			RecLock("TMP",.F.)
			&(aCampos[1]) := "XX"
             cMens += "O registro "+cWhere+" data tabela "+cTabela+chr(13)+chr(10)            
			
			MsUnlock()		
	
			If Select("QRYIDX") > 0	
				DbSelectArea("QRYIDX")
				DbCloseArea()
			Endif
			DbSelectArea("TMP")
			DbSkip()
			Loop
		Endif

		If Select("QRYIDX") > 0	
			DbSelectArea("QRYIDX")
			DbCloseArea()
		Endif
	Endif
				
	DbSelectArea(cAlias)                                              
	RecLock(cAlias,.t.)
	For nCntFor := 1 TO nTotCpo
		DbSelectArea("SX3")
		DbSetOrder(2)
		If !DbSeek(TMP->(Field(nCntFor)))
			Loop
		Else
			If SX3->X3_CONTEXT $ "V"
				Loop
			Endif
		Endif
		DbSelectArea("TMP")
		If "FILIAL"$Field(nCntFor) .Or. "FILORIG"$Field(nCntFor)   
			DbSelectArea(cAlias)                                              
			&(calias+"->"+ALLTRIM(SX3->X3_CAMPO)) := Iif(cModo == "C", Space(2), cFilArq)
	    	//FieldPut(nCntFor,Iif(cModo == "C", Space(2), cFilArq))
		Else
			DbSelectArea(cAlias)                                              
			&(calias+"->"+ALLTRIM(SX3->X3_CAMPO)) := TMP->&(EVAL(bCampo,nCntFor))
		Endif    
	Next nCntFor
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratamento Específico                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cAlias == "SA1"	     
		If LEN(ALLTRIM(STUFF(SA1->A1_CGC,At(" ",SA1->A1_CGC),1,""))) == 11
        	SA1->A1_PESSOA := "F"
        	If !Empty(SA1->A1_INSCR)
        		SA1->A1_PFISICA := SA1->A1_INSCR
        		SA1->A1_INSCR   := ""	
        	Endif
		ElseIf LEN(ALLTRIM(SA1->A1_CGC)) == 14	
        	SA1->A1_PESSOA := "J"
		Endif     
		
		
		If PA1->(dbSeek(xFilial("PA1")+SA1->A1_CODMUN))        
			SA1->A1_IBGE   := PA1->PA1_IBGE
		Endif
        SA1->A1_TPFRETE := "C"			
        SA1->A1_MOEDALC := 1  
        SA1->A1_SATIV1  := SA1->A1_SEGMENT
        SA1->A1_CONTA   := ""
		SA1->A1_MUNE    := SA1->A1_MUNENT //Entrega
		SA1->A1_CEPE    := SA1->A1_CEPENT
		SA1->A1_ESTE    := SA1->A1_ESTENT 
		SA1->A1_BAIRROE := SA1->A1_BAIENT 
		SA1->A1_COD_MUN := SA1->A1_CODMUN 
		SA1->A1_MUNC    := SA1->A1_MUNCOB //Cobranca 
		SA1->A1_CEPC    := SA1->A1_CEPCOB
		SA1->A1_ESTC    := SA1->A1_ESTCOB 
		SA1->A1_BAIRROC := SA1->A1_BAICOB 
  		
  		If Empty(Tabela("T3",SA1->A1_SEGMENT,.F.))
             cMens += "O cliente "+SA1->A1_COD+" esta com o segmento inválido "+SA1->A1_SEGMENT+chr(13)+chr(10)            
        Endif
        lMsErroAuto:= .T.
  		
  		If SA1->A1_PESSOA == "J"
	  		If Empty(SA1->A1_CGC) .Or. !CGC(ALLTRIM(STUFF(SA1->A1_CGC,At(" ",SA1->A1_CGC),1,"")),.T.)
   	          cMens += "O cliente "+SA1->A1_COD+" esta com o CGC/CPF inválido "+SA1->A1_CGC+chr(13)+chr(10)            
   	    	 Endif
    	Endif
  		If Empty(SA1->A1_COD_MUN) .Or. !(PA1->(dbSeek(xFilial("PA1")+SA1->A1_COD_MUN)))
             cMens += "O cliente "+SA1->A1_COD+" esta com o Código de municipio inválido "+SA1->A1_COD_MUN+chr(13)+chr(10)            
        Endif

  		If Empty(SA1->A1_VEND) 
             cMens += "O cliente "+SA1->A1_COD+" esta sem vendedor "+chr(13)+chr(10)            
        Endif
        
		If SA1->A1_PESSOA == "J"
	  		If !Empty(SA1->A1_INSCR) .And. !IE(ALLTRIM(SA1->A1_INSCR),SA1->A1_EST,.F.)
    	         cMens += "O cliente "+SA1->A1_COD+" esta com a IE inválido "+SA1->A1_INSCR+chr(13)+chr(10)            
       		 Endif
       	Endif	 
        lMsErroAuto:= .F.

  		If !(SED->(dbSeek(xFilial("SED")+SA1->A1_NATUREZ)))
             cMens += "O cliente "+SA1->A1_COD+" esta com a natureza inválida "+SA1->A1_NATUREZ+chr(13)+chr(10)            
        Endif

  		If !(SE4->(dbSeek(xFilial("SE4")+SA1->A1_COND))) .And. !Empty(SA1->A1_COND)
             cMens += "O cliente "+SA1->A1_COD+" esta com a condicao de pagamento inválida"+SA1->A1_COND+chr(13)+chr(10)            
        Endif

	ElseIf cAlias == "SB1"	

  	
  	
  		If Empty(SB1->B1_GRUPO) .Or. !SBM->(dbSeek(xFilial("SBM")+SB1->B1_GRUPO))
             cMens += "O produto "+SB1->B1_COD+" esta com o Grupo inválido "+ SB1->B1_GRUPO+ chr(13)+chr(10)            
        Endif

  		If Empty(SB1->B1_PROC) .Or. !SA2->(dbSeek(xFilial("SA2")+SB1->B1_PROC+SB1->B1_LOJPROC))
             cMens += "O produto "+SB1->B1_COD+" esta com o fornecedor padrao inválido "+SB1->B1_PROC+SB1->B1_LOJPROC+chr(13)+chr(10)            
    	ElseIf SB1->B1_PROC <> "000001"                      
    		SB1->B1_SOLICIT	:= "S"
        Endif

  		If Empty(SB1->B1_TIPO) .Or. Empty(Tabela("02",SB1->B1_TIPO,.F.))
             cMens += "O produto "+SB1->B1_COD+" esta com o tipo inválido "+SB1->B1_TIPO+chr(13)+chr(10)            
        Endif

  		If Empty(SB1->B1_UM) .Or. !SAH->(dbSeek(xFilial("SAH")+SB1->B1_UM))
             cMens += "O produto "+SB1->B1_COD+" esta com o tipo inválido "+SB1->B1_UM+chr(13)+chr(10)            
        Endif

  		If Empty(SB1->B1_TE) .Or. !SF4->(dbSeek(xFilial("SF4")+SB1->B1_TE))
             cMens += "O produto "+SB1->B1_COD+" esta com o tes inválido "+SB1->B1_TE+chr(13)+chr(10)            
        Endif                 
        

  		If Empty(SB1->B1_TS) .Or. !SF4->(dbSeek(xFilial("SF4")+SB1->B1_TS))
             cMens += "O produto "+SB1->B1_COD+" esta com o tes inválido "+SB1->B1_TS+chr(13)+chr(10)            
        Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o Segmento do Cliente                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    	   
	Endif
	
	DbSelectArea(cAlias)                                              
	MsUnlock()
	DbCommit()                   
//	MsUnlockAll()
	DbSelectArea("TMP")
	DbSkip()
Enddo

MemoWrite("Importa.txt",cMens)
If lTemDup
	//Aviso("Inconsistencia","Existem registros com chave primaria duplicados no arquivo "+cTabela+". Esse registro foi ignorado e marcado com a filial XX.",{"Ok"},,"Atencao")
    cMensagem := "Existem registros com chave primaria duplicados no arquivo "+cTabela+". Esse registro foi ignorado e marcado com a filial XX."
Endif
Return              

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ValidPergº Autor ³                    º Data ³             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Espec¡fico                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg(cPerg)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aAreaAtu	:= GetArea()
Local aRegs		:= {}
Local i,j

DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PADR(cPerg,6)
   
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
Aadd(aRegs,{cPerg,"01","Path SIGAMAT 4.07 ?"			,"","","mv_ch1","C",50,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
        RecLock("SX1",.T.)
        For j:=1 to FCount()
            If j <= Len(aRegs[i])
                FieldPut(j,aRegs[i,j])
            Endif
        Next
        MsUnlock()
    Endif
Next

RestArea(aAreaAtu)
Return(Nil)

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ cgc      ³ Autor ³ Wagner Xavier         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processa o criterio de validacao dos campos                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ExpL1:=cgc(ExpC1)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpL1 = Valor Logico de Retorno (.T. ou .F.)               ³±±
±±³          ³ ExpC1 = Numero do CGC                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function cgc(cCGC)
LOCAL nCnt,i,j,cDVC,nSum,nDIG,cDIG:=""

IF ValType(cCGC) = "U"
	cCGC := &(ReadVar())
ENDIF

cDVC:=SubStr(cCGC,13,2)
cCGC:=SubStr(cCGC,1,12)

FOR j := 12 TO 13
	nCnt := 1
	nSum := 0
	FOR i := j TO 1 Step -1
		nCnt++
		IF nCnt>9;nCnt:=2;EndIf
		nSum += (Val(SubStr(cCGC,i,1))*nCnt)
	Next i
	nDIG := IIF((nSum%11)<2,0,11-(nSum%11))
	cCGC := cCGC+STR(nDIG,1)
	cDIG := cDIG+STR(nDIG,1)
Next j
Return IIF(cDIG==cDVC,.T.,.F.)
