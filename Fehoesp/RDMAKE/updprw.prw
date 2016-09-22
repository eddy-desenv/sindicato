	#INCLUDE "Protheus.ch"
#INCLUDE "APWizard.ch"
#include "tbiconn.ch"
#DEFINE CEMPRESA "01"
#DEFINE CFILIAL "01"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ UpdPRW   บ Autor ณ     Nava           บ Data ณ  19/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Analisa e corrige os seguintes erros nos RDMakes, quando   บฑฑ
ฑฑบ          ณ possivel:                                                  บฑฑ
ฑฑบ          ณ - Altera os dbSetOrder() de usuario para dbOrderNickName().บฑฑ // Atencao (UPDXFUN).
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function UpdPRW

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local nRet := 0
Local oWizard
Local cTitulo  := "Pr้-virada de versใo"
Local cCabec   := "Defini็ใo de processos"
Local cMessage
Local cMask    := "Todos (*.*) |*.*| Arquivos DBF (*.DBF) |*.DBF| Arquivos de texto (*.TXT) |*.TXT| Arquivos XML (*.XML) |*.XML|"
Local cRdMakes := "c:\teste\" + Space(254)
Local oSayFnt11, oSayFnt21, oGetFnt21, oBtn21

// Monta a mensagem do painel 1.
cMess1 := "Esse programa tem por objetivo analisar o sistema antes de uma virada de versใo."
cMess2 := "ษ necessแrio efetuar uma c๓pia de seguran็a da pasta de rdmakes do sistema."
cMess3 := "Clique em avan็ar para continuar com o processo."

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Painel 1.                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE WIZARD oWizard TITLE cTitulo;
HEADER cCabec MESSAGE "Anแlise de arquivos de programas rdmake";
NEXT {|| VldTela(1)};
NOFIRSTPANEL PANEL
oWizard:GetPanel(1)

@ 015, 012 SAY oSayFnt11 VAR cMess1 OF oWizard:GetPanel(1) PIXEL
@ 023, 012 SAY oSayFnt12 VAR cMess2 OF oWizard:GetPanel(1) PIXEL
@ 031, 012 SAY oSayFnt13 VAR cMess3 OF oWizard:GetPanel(1) PIXEL

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Painel 2.                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CREATE PANEL oWizard;
HEADER "Pr้-virada de versใo";
MESSAGE "Selecione a pasta onde se encontram os programas rdmake do sistema";
BACK {|| .T.};
NEXT {|| VldTela(2, {cRdMakes})}
oWizard:GetPanel(2)

@ 036, 012 SAY oSayFnt21 VAR "Fontes de dados" OF oWizard:GetPanel(2) PIXEL
@ 035, 075 MSGET oGetFnt21 VAR cRdMakes Of oWizard:GetPanel(2) PIXEL SIZE 95, 09
DEFINE SBUTTON oBtn21 FROM 034, 168 TYPE 14 OF oWizard:GetPanel(2);
ACTION {|| cRdMakes := padr(cGetFile(cMask,"Selecione a pasta",;
1, "", .T., GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE), len(cRdMakes)) } ENABLE

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Painel 3.                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CREATE PANEL oWizard;
HEADER "Finaliza็ใo";
MESSAGE "Finalize o assistente para sair do assistente.";
BACK {|| .T.};
NEXT {|| VldTela(3)};
FINISH {|| VldTela(3)} PANEL
oWizard:GetPanel(3)

// Ativa o wizard.
ACTIVATE WIZARD oWizard CENTERED WHEN {|| .T.} VALID {|| VldTela(0)}

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ VldTela  บ Autor ณ Felipe Raposo      บ Data ณ  03/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Efetua a validacao da tela passada por parametro.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function VldTela(nTela, aParam)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local lRet := .T.
Local cMsg

Do Case
	Case nTela == 1
		// Nao faz nada.
	Case nTela == 2
		cMsg := "O programa irแ analisar todos os programas da pasta selecionada e, " +;
		"sendo possํvel, irแ alterar as chamadas de dbSetOrder() para dbOrderNickName()." + CRLF +; // Atencao (UPDXFUN).
		"Assegure-se de ter feito BACKUP da pasta antes de continuar." + CRLF + CRLF +;
		"Deseja continuar?"
		If MsgYesNo(cMsg, "Aten็ใo")
			MsAguarde({|| ProcPRW(aParam[1])}, "Processando programas.")
		Else
			lRet := .T.
		Endif
EndCase

Return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ProcPRW  บ Autor ณ Felipe Raposo      บ Data ณ  03/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Abre, analisa e, sendo necessario, altera o programa.      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ProcPRW(cDirPRW)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local lRet := .T.
Local cArqPRW, aArqPRW, cArqNovo, cAlias, cOrder, nOrder
Local cLinAnt, cLinha, aUsrOrd[0], aSetOrd[0]

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Prepara o environment.                                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Prepare Environment Empresa CEMPRESA Filial CFILIAL

// Trata o diretorio dos rdmakes.
cDirPRW := AllTrim(cDirPRW)
If right(cDirPRW, 1) <> "\"
	cDirPRW += "\"
Endif

// Cria o arquivo de log.
If (nHandle := OpenLog(cDirPRW + "LOG.LOG")) < 1
	MsgInfo("Nใo foi possํvel criar o arquivo de log.")
	Quit
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Analisa os indices de usuario.                                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SIX->(dbSetOrder(1)) // Atencao (UPDXFUN).
SIX->(dbGoTop())
Do While SIX->(!eof())
	If !(SIX->PROPRI $ "S ") .and. left(SIX->INDICE, 2) <> "SZ" .and. left(SIX->INDICE, 1) <> "Z"
		If SIX->ORDEM > "9"
			nOrdem := asc(SIX->ORDEM) - 55
		Else
			nOrdem := val(SIX->ORDEM)
		Endif
		If empty(SIX->NICKNAME)
			RecLock("SIX", .F.)
			SIX->NICKNAME := AllTrim(str(nOrdem))
			SIX->(msUnLock())
			GravaLog("Nickname criado..: " + SIX->INDICE + ": " + AllTrim(SIX->NICKNAME))
		Else
			GravaLog("Nickname usuario.: " + SIX->INDICE + ": " + AllTrim(SIX->NICKNAME))
		Endif
		
		aAdd(aUsrOrd, {SIX->INDICE, nOrdem, AllTrim(SIX->NICKNAME)})
	Endif
	SIX->(dbSkip())
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Analisa os arquivos de programa.                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aArqPRW := Directory(cDirPRW + "*.pr?", "D")

For nX := 1 to len(aArqPRW)
	cArqPRW := aArqPRW[nX, 1]
	cExt := upper(right(cArqPRW, 3))
	If cExt == "PRW" .or. cExt == "PRX"
		MsProcTxt("Processando arquivo " + cArqPRW); ProcessMessages()  // Atualiza a pintura da janela.
		// GravaLog("Arquivo " + cArqPRW)
		
		nLinha   := 2  // A primeira linha ja eh lida abaixo.
		aSetOrd  := {}
		cArqNovo := ""
		lAlter   := .F.
		FT_FUse(cDirPRW + cArqPRW)
		cLinAnt := FT_FReadLn()
		cFirstLine := cLinAnt
		FT_FSkip()  // Vai para a linha 2.
		Do While !FT_FEOF()
			cLinha := FT_FReadLn()
			If !empty(cLinha)
				If "DBSETORDER" $ upper(cLinha) // Atencao (UPDXFUN).
					If "DBSELEC" $ upper(cLinAnt)
						
						cAlias := SubStr(StrTran(StrTran(AllTrim(cLinAnt), " ", ""), "	", ""), 15, 3)
						cOrder := SubStr(StrTran(StrTran(AllTrim(cLinha), " ", ""), "	", ""), 12)
						nOrder := val(left(cOrder, len(cOrder) - 1))
						nAlias := aScan(aUsrOrd, {|x| x[1] == cAlias .and. x[2] == nOrder})
						If nAlias > 0
							aAdd(aSetOrd, {nLinha, cLinha, cAlias})
							GravaLog(" - Alterada a linha " + AllTrim(str(nLinha)) + " [" + cArqPRW + "]")
							GravaLog(" - [" + cLinha + "] -> Nickname: [" + aUsrOrd[nAlias, 1] + ": " + aUsrOrd[nAlias, 3] + "]")
							
							nY := at("DBSETORDER", upper(cLinha)) // Atencao (UPDXFUN).
							cLinha := left(cLinha, nY - 1) + "dbOrderNickName('" + aUsrOrd[nAlias, 3] + "')" +;
							"  // " + SubStr(cLinha, nY) + " // Alterado (UPDXFUN)."
							lAlter := .T.
						Endif
					Else
						GravaLog(" - Atencao com a linha " + AllTrim(str(nLinha)) + " [" + cArqPRW + "]")
						GravaLog(" - [" + cLinha + "]")
						cLinha += " // Atencao (UPDXFUN)."
						lAlter := .T.
					Endif
				Endif
				cLinAnt := cLinha
			Endif
			cArqNovo += cLinha + CRLF
			
			FT_FSkip()
			nLinha ++  // Incrementa a linha lida.
		EndDo
		FT_FUse()
		cArqNovo := cFirstLine + CRLF + cArqNovo
		
		// Grava o arquivo alterado.
		If lAlter
			FRENAME ( cDirPRW + cArqPRW, cDirPRW + cArqPRW + ".OLD" )
			MemoWrite(cDirPRW + cArqPRW + ".NEW", cArqNovo)
			GravaLog("Arquivo " + cDirPRW + cArqPRW + ".NEW gravado.")
		Endif
	Endif
Next nX

GravaLog("Fim de processamento")
Fclose( nHandle )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fecha o environment.                                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
RESET ENVIRONMENT

Return

// 355 do RFINA105
/*-------------------------------------------------------------*/
Static FUNCTION OpenLog( cArquivo )
/*-------------------------------------------------------------*/
RETURN(Fcreate( cArquivo ) )


/*-------------------------------------------------------------*/
Static FUNCTION GravaLog( cMsg )
/*-------------------------------------------------------------*/

ConOut(cMsg)
Fseek(  nHandle, 0, 2 )
Fwrite( nHandle,  Left( TIME(), 5 ) + ' - ' + cMsg + CRLF )

RETURN .T.
