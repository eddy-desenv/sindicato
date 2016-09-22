#INCLUDE "Protheus.ch"
#INCLUDE "APWizard.ch"
#include "tbiconn.ch"
#DEFINE NTAMPATH 254
#DEFINE CEMPRESA "01"
#DEFINE CFILIAL  "01"
#xtranslate tTipo(<uTipo>, <uTam>, <uDec>) => " " + <uTipo> + "[" + bTrim(<uTam>) + "," + bTrim(<uDec>) + "]"
#xtranslate tNum2Str(<uVar>) => AllTrim(Str(<uVar>))
#xtranslate tLimpa(<uVar>) => AllTrim(StrTran(<uVar>, "	", " ")) // Substitui TAB por espaco.
#xtranslate tFRename(<uOri>, <uBak>) => IIf(file(<uBak>), fErase(<uBak>), nil); fRename(<uOri>, <uBak>)

Static lEnvironment := .F.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PreUpd   บ Autor ณ Felipe Raposo      บ Data ณ  19/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Analisa e corrige os seguintes erros nos RDMakes, quando   บฑฑ
ฑฑบ          ณ possivel:                                                  บฑฑ
ฑฑบ          ณ - Altera os dbSetOrder() de usuario para dbOrderNickName().บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PreUpd

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local nRet := 0
Local oWizard
Local cTitulo  := "Pr้-virada de versใo"
Local cCabec   := "Defini็ใo de processos"
Local cDirBase := padr("\SystemLoad\", NTAMPATH)
Local cRdMakes := padr("c:\rdmake\ACTLINE.prj", NTAMPATH)  // "\rdmake\informary.prj", NTAMPATH)

Local oBtn21, oBtn22
Local aMess[0], oSays[0]
Local nLin, nX, nY
Local lOpcSX1 := .F.
Local lOpcSX2 := .F.
Local lOpcSX6 := .F.
Local lOpcSIX := .F.
Local lOpcPRW := .F.
Local lOpcIDN := .F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Painel 1.                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE WIZARD oWizard TITLE cTitulo;
HEADER cCabec MESSAGE "Anแlise de arquivos de programas rdmake";
NEXT {|| VldUPD(1)};
NOFIRSTPANEL PANEL
oWizard:GetPanel(1)

// Monta a mensagem do painel.
aAdd(aMess, "Esse programa tem por objetivo analisar o sistema antes de uma virada de versใo.")
aAdd(aMess, "ษ necessแrio efetuar uma c๓pia de seguran็a da pasta envolvidas no processo, tanto")
aAdd(aMess, "a de sistema (sigaadv ou system) quanto a de projeto (rdmake).")
aAdd(aMess, "Esse programa necessita ser executado em modo exclusivo (sem nenhum usuแrio no sistema).")
aAdd(aMess, "Clique em avan็ar para continuar com o processo.")
nLin  := 15
nY    := len(aMess)
oSays := array(nY)
For nX := 1 to nY - 1
	@ nLin, 012 SAY oSays[nX] PROMPT Space(100) OF oWizard:GetPanel(1) PIXEL
	oSays[nX]:SetText(aMess[nX])
	oSays[nX]:Refresh()
	nLin += 8  // Pulo pixels por linha.
Next nX
nLin += 6  // Pula mais 6 linhas para a ultima mensagem.
@ nLin, 012 SAY oSays[nY] PROMPT Space(100) OF oWizard:GetPanel(1) PIXEL
oSays[nY]:SetText(aMess[nY])
oSays[nY]:Refresh()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Painel 2.                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CREATE PANEL oWizard;
HEADER "Pr้-virada de versใo";
MESSAGE "Preencha os parโmetros solicitados abaixo";
BACK {|| .T.};
NEXT {|| VldUPD(2, {cDirBase, cRdMakes, lOpcSX1, lOpcSX2, lOpcSX6, lOpcSIX, lOpcPRW, lOpcIDN})}
oWizard:GetPanel(2)

@ 005, 010 TO 045, 275 PROMPT "Arquivos do sistema" OF oWizard:GetPanel(2) PIXEL

@ 015, 015 SAY "Arquivos de atualiza็ใo" OF oWizard:GetPanel(2) PIXEL
@ 014, 075 MSGET cDirBase Of oWizard:GetPanel(2) PIXEL SIZE 95, 09
DEFINE SBUTTON oBtn21 FROM 013, 170 TYPE 14 OF oWizard:GetPanel(2);
ACTION {|| cDirBase := padr(cGetFile(nil, "Selecione a pasta", 1, nil, .T.,;
GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE), NTAMPATH) } ENABLE

@ 027, 015 SAY "Projeto de fun็๕es" OF oWizard:GetPanel(2) PIXEL
@ 026, 075 MSGET cRdMakes Of oWizard:GetPanel(2) PIXEL SIZE 95, 09
DEFINE SBUTTON oBtn22 FROM 025, 170 TYPE 14 OF oWizard:GetPanel(2);
ACTION {|| cRdMakes := padr(cGetFile("Arquivos de Projeto (*.PRJ) |*.PRJ|", "Selecione o projeto", 1, nil, .T.,;
GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE), NTAMPATH) } ENABLE

@ 050, 010 TO 120, 275 PROMPT "Op็๕es de anแlise" OF oWizard:GetPanel(2) PIXEL
@ 057, 015 CHECKBOX lOpcSX1 PROMPT "Analisa perguntas (SX&1)" OF oWizard:GetPanel(2) SIZE 200, 009 PIXEL
@ 067, 015 CHECKBOX lOpcSX2 PROMPT "Analisa dicionแrio de dados (SX&2 / SX3)" OF oWizard:GetPanel(2) SIZE 200, 009 PIXEL
@ 077, 015 CHECKBOX lOpcSX6 PROMPT "Analisa gatilhos (SX&6) - op็ใo ainda nใo implementada" OF oWizard:GetPanel(2) SIZE 200, 009 PIXEL WHEN .F.
@ 087, 015 CHECKBOX lOpcSIX PROMPT "Analisa ํndices (S&IX) - op็ใo ainda nใo implementada" OF oWizard:GetPanel(2) SIZE 200, 009 PIXEL WHEN .F.
@ 097, 015 CHECKBOX lOpcPRW PROMPT "Analisa programas (PR&W / PRX)" OF oWizard:GetPanel(2) SIZE 200, 009 PIXEL
@ 107, 015 CHECKBOX lOpcIDN PROMPT "Identa programas (PR&W / PRX)" OF oWizard:GetPanel(2) SIZE 200, 009 PIXEL

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Painel 3.                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CREATE PANEL oWizard;
HEADER "Finaliza็ใo";
MESSAGE "Finalize o assistente para sair.";
BACK {|| .F.};  // Nao permite voltar mais.
NEXT {|| VldUPD(3)};
FINISH {|| VldUPD(3)} PANEL
oWizard:GetPanel(3)

// Ativa o wizard.
ACTIVATE WIZARD oWizard CENTERED WHEN {|| .T.} VALID {|| VldUPD(0)}

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ VldUPD   บ Autor ณ Felipe Raposo      บ Data ณ  03/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Efetua a validacao da tela passada por parametro.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function VldUPD(nTela, aParam)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local lRet := .T.
Local cMsg, oRegua
Local cDirBase, cRdMakes, lOpcSX1, lOpcSX2, lOpcSX6, lOpcSIX, lOpcPRW, lOpcIDN

Do Case
	Case nTela == 1
		// Nao valida nada nessa tela.
		
	Case nTela == 2
		
		cDirBase := AllTrim(aParam[1])
		cRdMakes := AllTrim(aParam[2])
		lOpcSX1  := aParam[3]
		lOpcSX2  := aParam[4]
		lOpcSX6  := aParam[5]
		lOpcSIX  := aParam[6]
		lOpcPRW  := aParam[7]
		lOpcIDN  := aParam[8]
		If !(lOpcSX1 .or. lOpcSX2 .or. lOpcSX6 .or. lOpcSIX .or. lOpcPRW)
			cMsg := 'Selecione pelo menos uma das op็๕es de anแlise'
			MsgAlert(cMsg, "Aten็ใo")
			lRet := .F.
		ElseIf lOpcPRW .and. empty(cRdMakes)
			cMsg := 'Selecione um diret๓rio vแlido na op็ใo "Fonte de Dados"'
			MsgAlert(cMsg, "Aten็ใo")
			lRet := .F.
		ElseIf (lOpcSX1 .or. lOpcSX2 .or. lOpcSX6 .or. lOpcSIX) .and. empty(cDirBase)
			cMsg := 'Selecione um diret๓rio vแlido na op็ใo "Arquivos base"'
			MsgAlert(cMsg, "Aten็ใo")
			lRet := .F.
		Else
			cMsg := "O programa irแ analisar o sistema de acordo com " +;
			"os parโmetros informados pelo usuแrio." + CRLF
			If lOpcSX2
				cMsg += "O assistente irแ EXCLUIR as tabelas vazias do banco de dados. " + CRLF +;
				"Assegure-se de ter feito BACKUP da pasta " + cDirBase + " antes de continuar." + CRLF
			Endif
			If lOpcPRW
				cMsg += "O assistente irแ analisar os programas de usuแrio do sistema e substituir " +;
				"todos os chamados de dbSetOrder() para dbOrderNickName()." + CRLF +;
				"Assegure-se de ter feito BACKUP da pasta " + cRdMakes + " antes de continuar." + CRLF
			Endif
			cMsg += CRLF + "Deseja continuar?"
			If MsgYesNo(cMsg, "Aten็ใo")
				oRegua := MsNewProcess():New({|lEnd| ProcUPD(oRegua, @lEnd, cDirBase, cRdMakes, lOpcSX1, lOpcSX2, lOpcSX6, lOpcSIX, lOpcPRW, lOpcIDN)}, "Anแlise do sistema", "", .T.)
				oRegua:Activate()
			Else
				lRet := .F.
			Endif
		Endif
EndCase

Return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ProcPRW  บ Autor ณ Felipe Raposo      บ Data ณ  03/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Abre, analisa e, havendo necessidade, altera o programa.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ProcUPD(oRegua, lEnd, cDirBase, cRdMakes, lOpcSX1, lOpcSX2, lOpcSX6, lOpcSIX, lOpcPRW, lOpcIDN)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local lRet := .T.
Local nHdLog

// Configura a regua de cima.
oRegua:SetRegua1(IIf(lOpcSX1, 3, 0) + IIf(lOpcSX2, 2, 0) + IIf(lOpcSX6, 2, 0) + IIf(lOpcSIX, 2, 0) + IIf(lOpcPRW, 2, 0))

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Prepara o ambiente.                                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !lEnvironment
	Prepare Environment Empresa CEMPRESA Filial CFILIAL
	lEnvironment := .T.
Endif

// Cria os arquivos de log.
If (nHdLog := CreateLog("\PREUPD.LOG")) < 1
	Quit
Endif

// Trata so diretorios informados.
cDirBase += IIf(right(cDirBase, 1) == "\", "", "\")

If lOpcSX1 .and. !lEnd
	oRegua:IncRegua1("Analisando perguntas")
	ProcSX1(oRegua, @lEnd, nHdLog, cDirBase)
Endif
If lOpcSX2 .and. !lEnd
	oRegua:IncRegua1("Analisando dicionแrio de dados")
	ProcSX2(oRegua, @lEnd, nHdLog, cDirBase)
Endif
If lOpcSX6 .and. !lEnd
	oRegua:IncRegua1("Analisando gatilhos")
	ProcSX6(oRegua, @lEnd, nHdLog, cDirBase)
Endif
If lOpcSIX .and. !lEnd
	oRegua:IncRegua1("Analisando ํndices")
	ProcSIX(oRegua, @lEnd, nHdLog, cDirBase)
Endif
If lOpcPRW .and. !lEnd
	oRegua:IncRegua1("Analisando programas")
	ProcPRW(oRegua, @lEnd, nHdLog, cRdMakes, cDirBase, lOpcIDN)
Endif

// Fecha o arquivo de log.
FClose(nHdLog)
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ProcSX1  บ Autor ณ Felipe Raposo      บ Data ณ  03/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Analisa o arquivo de perguntas.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ProcSX1(oRegua, lEnd, nHdLog, cSysLoad)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local lRet := .T.
Local cSX1Bas := cSysLoad + "SX1.dbf"

// Analisa a exist๊ncia do arquivo SX1.
If !file(cSX1Bas)
	GravaLog(nHdLog, "", "Arquivo SX1.dbf nใo encontrado no diret๓rio " + cSysLoad)
	Return .F.
Endif

// Inicio do processamento
GravaLog(nHdLog, "", "Analisando perguntas (SX1)")
GravaLog(nHdLog, "", "Arquivo base: " + cSX1Bas)

// Abre o arquivo SX1 Base.
dbUseArea(.T., nil, cSX1Bas, "SX1B", .T., .F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Compara as perguntas do arquivo base com as do arquivo do sistema.  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oRegua:IncRegua1("Analisando perguntas base")
GravaLog(nHdLog, "S", "Analise das perguntas do sistema base:")
SX1->(dbSetOrder(1))  // X1_GRUPO+X1_ORDEM.
SX1B->(dbGoTop())
oRegua:SetRegua2(SX1B->(RecCount()))
Do While SX1B->(!eof()) .and. !lEnd
	oRegua:IncRegua2("Pergunta " + SX1B->X1_GRUPO)  // Atualiza a pintura da janela.
	If !empty(SX1B->X1_GRUPO)
		If SX1->(!dbSeek(SX1B->(X1_GRUPO+X1_ORDEM), .F.))
			GravaLog(nHdLog, "S", " -- Serแ criada a pergunta " + SX1B->(X1_GRUPO + "/" + X1_ORDEM + tTipo(X1_TIPO, X1_TAMANHO, X1_DECIMAL)))
		Endif
	Endif
	
	SX1B->(dbSkip())
EndDo

// Fecha o arquivo base.
SX1B->(dbCloseArea())

// Verifica se o usuario cancelou o processamento.
If lEnd
	cMsg := "Cancelado pelo usuแrio"
	GravaLog(nHdLog, "", cMsg)
	MsgAlert(cMsg, "Aten็ใo")
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza o log.                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
GravaLog(nHdLog, "", "")  // Pula uma linha no arquivo de log.
GravaLog(nHdLog, "", Replicate("-", 20))
GravaLog(nHdLog, "GW")  // Grava os warnings.
GravaLog(nHdLog, "", "Fim de processamento das perguntas")
GravaLog(nHdLog, "", Replicate("-", 20))
GravaLog(nHdLog, "", "")  // Pula uma linha no arquivo de log.

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ProcSX2  บ Autor ณ Felipe Raposo      บ Data ณ  03/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Analisa os arquivos SX2 x SX3 x Base de Dados.             บฑฑ
ฑฑบ          ณ - Analisa se foi criado algum campo de usuario que coincideบฑฑ
ฑฑบ          ณ   com um campo criado na nova versao.                      บฑฑ
ฑฑบ          ณ - Analisa se ha divergencia entre o dicionario e o banco.  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ProcSX2(oRegua, lEnd, nHdLog, cSysLoad)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local lRet := .T.
Local cSX3Bas := cSysLoad + "SX3.dbf"
Local aStrDB, aStrX3, lAlterado, lFechar, lExcluir
Local nX, nY, nZ, cAux1, cAux2
Local aIndice, cCampo, lAbrir

// Atualiza a pintura da janela.
oRegua:IncRegua2("Abrindo arquivos base")

// Analisa a exist๊ncia do arquivo SX3.
If !file(cSX3Bas)
	GravaLog(nHdLog, "", "Arquivo SX3.dbf nใo encontrado no diret๓rio " + cSysLoad)
	Return .F.
Endif

// Inicio do processamento.
GravaLog(nHdLog, "", "Analisando dicionแrio de dados (SX2 / SX3)")
GravaLog(nHdLog, "", "Arquivo base: " + cSX3Bas)

// Abre o arquivo SX3 Base.
dbUseArea(.T., nil, cSX3Bas, "SX3B", .T., .F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Compara as perguntas do arquivo base com as do arquivo do sistema.  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
GravaLog(nHdLog, "S", "Analise os campos do sistema base:")
SX3->(dbSetOrder(2))  // X3_CAMPO.
SX3B->(dbGoTop())
oRegua:SetRegua2(SX3B->(RecCount()))
Do While SX3B->(!eof()) .and. !lEnd
	oRegua:IncRegua2("Campo " + SX3B->X3_CAMPO)  // Atualiza a pintura da janela.
	If SX3B->X3_PROPRI <> "U" .and. SX3->(dbSeek(SX3B->X3_CAMPO, .F.)) .and. SX3->X3_PROPRI == "U"
		GravaLog(nHdLog, "S", " -- Campo " + SX3B->X3_CAMPO + " (conflitante com nova versใo)")
	Endif
	
	SX3B->(dbSkip())
EndDo

// Fecha o arquivo base.
SX3B->(dbCloseArea())

// Verifica se o usuario cancelou o processamento.
If lEnd
	cMsg := "Cancelado pelo usuแrio"
	GravaLog(nHdLog, "", cMsg)
	MsgAlert(cMsg, "Aten็ใo")
	Return
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Analisa a integridade do dicionario de dados.                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oRegua:IncRegua1("Analisando integridade SX2 x SX3 x Base de dados")
oRegua:IncRegua2("")
oRegua:SetRegua2(SX2->(RecCount()))
SX2->(dbSetOrder(1))  // X2_CHAVE.
SX3->(dbSetOrder(1))  // X3_ARQUIVO + X3_ORDEM.
SX2->(dbGoTop())
Do While SX2->(!eof())
	oRegua:IncRegua2(SX2->(AllTrim(X2_ARQUIVO) + " - " + AllTrim(X2_NOME)))
	lAbrir   := .T.
	lExcluir := .F.
	
	// Analisa os campos.
	aStrX3 := {}
	SX3->(dbSeek(SX2->X2_CHAVE, .F.))
	Do While SX3->(X3_ARQUIVO == SX2->X2_CHAVE .and. !eof())
		lAlterado := .F.
		If SX3->X3_TIPO == "C"
			If SX3->X3_DECIMAL <> 0
				RecLock("SX3", .F.)
				SX3->X3_DECIMAL := 0
				SX3->(msUnLock())
				lAlterado := .T.
			Endif
		ElseIf SX3->X3_TIPO == "N"
			// Campo livre.
		ElseIf SX3->X3_TIPO == "L"
			If SX3->(X3_TAMANHO <> 1 .or. X3_DECIMAL <> 0)
				RecLock("SX3", .F.)
				SX3->X3_TAMANHO := 1
				SX3->X3_DECIMAL := 0
				SX3->(msUnLock())
				lAlterado := .T.
			Endif
		ElseIf SX3->X3_TIPO == "D"
			If SX3->(X3_TAMANHO <> 8 .or. X3_DECIMAL <> 0)
				RecLock("SX3", .F.)
				SX3->X3_TAMANHO := 8
				SX3->X3_DECIMAL := 0
				SX3->(msUnLock())
				lAlterado := .T.
			Endif
		ElseIf SX3->X3_TIPO == "M"
			If SX3->(X3_TAMANHO <> 10 .or. X3_DECIMAL <> 0)
				RecLock("SX3", .F.)
				SX3->X3_TAMANHO := 10
				SX3->X3_DECIMAL := 0
				SX3->(msUnLock())
				lAlterado := .T.
			Endif
		Endif
		If lAlterado
			GravaLog(nHdLog, "S", " -- Campo " + SX3->X3_CAMPO + " alterado automaticamente.")
			GravaLog(nHdLog, "S", " --   Tipo " + SX3->(tTipo(X3_TIPO, X3_TAMANHO, X3_DECIMAL)))
		Endif
		
		// Monta a estrutura para comparacao.
		If SX3->X3_CONTEXT <> "V"
			SX3->(aAdd(aStrX3, {RTrim(X3_CAMPO), X3_TIPO, X3_TAMANHO, X3_DECIMAL}))
		Endif
		SX3->(dbSkip())
	EndDo
	
	// Verifica se existe indice para o arquivo.
	SIX->(dbSetOrder(1))  // INDICE + ORDEM.
	If SIX->(dbSeek(SX2->X2_CHAVE, .F.))
		Do While SIX->(INDICE == SX2->X2_CHAVE .and. !eof())
			aIndice := U_CtoA(SIX->CHAVE, "+")
			For nX := 1 to len(aIndice)
				cCampo := aIndice[nX]
				nZ     := at(PrefixoCpo(SX2->X2_CHAVE) + "_", cCampo)
				cAux1  := ""
				For nY := max(nZ, 1) to min(len(cCampo), 10 + nZ)
					cAux2 := upper(SubStr(cCampo, nY, 1))
					If (cAux2 >= "A" .and. cAux2 <= "Z") .or. (cAux2 >= "0" .and. cAux2 <= "9") .or. cAux2 == "_"
						cAux1 += cAux2
					Else
						Exit
					Endif
				Next nY
				cCampo := AllTrim(cAux1)
				If empty(cCampo) .or. aScan(aStrX3, {|x| x[1] == cCampo}) < 1
					GravaLog(nHdLog, "S", " -- อndice invแlido: " + SIX->(INDICE + "/" + ORDEM + " [" + AllTrim(CHAVE) + "] - " + aIndice[nX]))
					lAbrir := .F.
				Endif
			Next nX
			SIX->(dbSkip())
		EndDo
	Else
		GravaLog(nHdLog, "S", " -- Tabela sem ํndice: " + cArquivo)
		lAbrir := .F.
	Endif
	
	// Verifica se o arquivo existe na base de dados.
	// Se nao existe, nao precisa comparar a estrutura.
	cArquivo := SX2->(AllTrim(X2_PATH) + AllTrim(X2_ARQUIVO)) + GetDBExtension()
	If !U_DBExist(SX2->X2_CHAVE)
		// GravaLog(nHdLog, "S", " -- Tabela nใo criada: " + cArquivo)
		lAbrir := .F.
	Endif
	
	// Verifica se nao teve nenhum problema ate aqui.
	If lAbrir
		// Analisa os campos.
		If Select(SX2->X2_CHAVE) < 1
			ChkFile(SX2->X2_CHAVE)  // Abre o arquivo.
			lFechar := .T.
		Else
			lFechar := .F.
		Endif
		
		// Verifica se o arquivo esta vazio.
		(SX2->X2_CHAVE)->(dbGoTop())
		If (SX2->X2_CHAVE)->(eof())
			lFechar  := .T.
			lExcluir := .T.
		Else
			// Compara as estruturas.
			aStrDB := (SX2->X2_CHAVE)->(dbStruct())
			For nX := 1 to len(aStrX3)
				nY := aScan(aStrDB, {|x| x[1] == aStrX3[nX, 1]})
				If nY < 1
					GravaLog(nHdLog, "S", " -- Campo " + aStrX3[nX, 1] + " nใo existe na base de dados.")
				ElseIf !U_CompArr(aStrX3[nX], aStrDB[nY])  // Funcao para comparar os valores de duas arrays.
					GravaLog(nHdLog, "S", " -- Campo na base de dados com estrutura divergente do dicionแrio de dados.")
					GravaLog(nHdLog, "S", " --   SX3..: " + aStrX3[nX, 1] + " - " + tTipo(aStrX3[nX, 2], aStrX3[nX, 3], aStrX3[nX, 4]))
					GravaLog(nHdLog, "S", " --   Base.: " + aStrDB[nY, 1] + " - " + tTipo(aStrDB[nY, 2], aStrDB[nY, 3], aStrDB[nY, 4]))
				Endif
			Next nX
			For nX := 1 to len(aStrDB)  // Faz a comparacao reversa.
				nY := aScan(aStrX3, {|x| x[1] == aStrDB[nX, 1]})
				If nY < 1
					GravaLog(nHdLog, "S", " -- Campo " + aStrDB[nX, 1] + " da tabela nใo existe na dicionแrio de dados.")
				Endif
			Next nX
		Endif
		
		// Fecha o arquivo aberto.
		If lFechar
			(SX2->X2_CHAVE)->(dbCloseArea())
			If lExcluir
				If U_DBDrop(SX2->X2_CHAVE)  // Exclui a tabela vazia do banco de dados.
					GravaLog(nHdLog, "S", " -- Arquivo " + SX2->(AllTrim(X2_PATH) + AllTrim(X2_ARQUIVO)) + " vazio. Excluido automaticamente.")
				Else
					GravaLog(nHdLog, "S", " -- Arquivo " + SX2->(AllTrim(X2_PATH) + AllTrim(X2_ARQUIVO)) + " vazio. Por้m nใo p๔de ser excluํdo!!!")
				Endif
			Endif
		Endif
	Endif
	
	// Proximo arquivo.
	SX2->(dbSkip())
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza o log.                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
GravaLog(nHdLog, "", "")  // Pula uma linha no arquivo de log.
GravaLog(nHdLog, "", Replicate("-", 20))
GravaLog(nHdLog, "GW")  // Grava os warnings.
GravaLog(nHdLog, "", "Fim de processamento do dicionแrio de dados")
GravaLog(nHdLog, "", Replicate("-", 20))
GravaLog(nHdLog, "", "")  // Pula uma linha no arquivo de log.

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ProcPRW  บ Autor ณ Felipe Raposo      บ Data ณ  03/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Abre, analisa e, havendo necessidade, altera o programa.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ProcPRW(oRegua, lEnd, nHdLog, cProjeto, cSysLoad, lOpcIDN)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local lRet := .T.
Local cSIXBas := cSysLoad + "SIX"
Local lSIXUsr, lSIXBase := .F.
Local cMsg, aAlter[0], nX
Local cDirPRW, cArqPRW, aArqPRW, cArqNovo, cAlias, cOrder, nOrder, nTipo
Local cLinha, cLinLimpa, cAntLimpa, aUsrOrd[0]
Local cIdent, cCmdNovo, cComent, lComent
Local cHrIni := Time()

// Inicio do processamento
GravaLog(nHdLog, "", "Analisando programas de usuแrio")
GravaLog(nHdLog, "", "Projeto: " + cProjeto)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se existe o arquivo SIX.dbf para usar de base.             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If file(cSIXBas)
	GravaLog(nHdLog, "", "Arquivo base: " + cSIXBas)
	
	// Abre o arquivo SX1 Base.
	dbUseArea(.T., nil, cSIXBas, "SIXB", .F., .F.)
	IndRegua("SIXB", cSIXBas, "INDICE+ORDEM")
	
	// Indica que o arquivo de base sera usado.
	lSIXBase := .T.
Else
	GravaLog(nHdLog, "", "Nใo foi encontrado um arquivo SIX para ser usado como base.")
	GravaLog(nHdLog, "", "Serแ considerado o campo SIX->PROPRI para a anแlise.")
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Analisa os indices de usuario.                                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
GravaLog(nHdLog, "", "Analisando ํndices de usuแrio")
SIX->(dbSetOrder(1))
SIX->(dbGoTop())
Do While SIX->(!eof())
	If lSIXBase
		lSIXUsr := SIXB->(!dbSeek(SIX->(INDICE + ORDEM), .F.)) .or. AllTrim(SIX->CHAVE) <> AllTrim(SIXB->CHAVE)
		If SIX->PROPRI <> "U"
			RecLock("SIX", .F.)
			SIX->PROPRI := "U"
			SIX->(msUnLock())
			GravaLog(nHdLog, "S", "อndice: " + SIX->(INDICE + "/" + ORDEM)+ " -> Alterado valor de PROPRI para 'U'")
		Endif
	Else
		lSIXUsr := !(SIX->PROPRI $ "S ") .and. left(SIX->INDICE, 2) <> "SZ" .and. left(SIX->INDICE, 1) <> "Z"
	Endif
	If lSIXUsr
		If SIX->ORDEM > "9"
			nOrdem := asc(SIX->ORDEM) - 55
		Else
			nOrdem := val(SIX->ORDEM)
		Endif
		If empty(SIX->NICKNAME)
			RecLock("SIX", .F.)
			SIX->NICKNAME := tNum2Str(nOrdem)
			SIX->(msUnLock())
			GravaLog(nHdLog, "S", "อndice: " + SIX->INDICE + " -> Nickname: " + AllTrim(SIX->NICKNAME) + " (criado automaticamente)")
		Else
			GravaLog(nHdLog, "S", "อndice: " + SIX->INDICE + " -> Nickname: " + AllTrim(SIX->NICKNAME))
		Endif
		
		aAdd(aUsrOrd, {upper(SIX->INDICE), nOrdem, AllTrim(SIX->NICKNAME)})
	Endif
	SIX->(dbSkip())
EndDo
If lSIXBase
	SIXB->(dbCloseArea())
Endif
GravaLog(nHdLog, "S", "")  // Pula uma linha em branco no log.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Analisa os arquivos de programa.                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aArqPRW := IIf(!empty(aUsrOrd), RetRDMakes(cProjeto), {})
oRegua:SetRegua2(len(aArqPRW))
For nX := 1 to len(aArqPRW)
	cDirPRW := aArqPRW[nX, 1]
	cArqPRW := aArqPRW[nX, 2]
	oRegua:IncRegua2(cDirPRW + cArqPRW)  // Atualiza a pintura da janela.
	If lEnd
		cMsg := "Cancelado pelo usuแrio"
		MsgAlert(cMsg, "Aten็ใo")
		Exit
	Endif
	
	GravaLog(nHdLog, "S", "Analisando " + cDirPRW + cArqPRW)	
	U_FUse(cDirPRW + cArqPRW)
	aAlter   := {}
	cArqNovo := ""
	lComent  := .F.
	Do While !U_FEOF()
		// Para considerar as linhas quebradas por ponto e virgula como uma linha so.
		cLinha := rtrim(U_FReadLn())
		Do While right(tLimpa(cLinha), 1) == ";" .and. !U_FEOF()
			U_FSkip()
			cLinha += CRLF + rtrim(U_FReadLn())
		EndDo
		
		// Analisa a linha corrente.
		cLinLimpa := LimpaLin(tLimpa(cLinha), @lComent)
		If !empty(cLinLimpa) .and. upper(left(cLinLimpa, 3)) <> "IF " .and. !("UPDXFUN" $ cLinha)
			If "DBSETORDER" $ upper(cLinha)
				If SubStr(cLinLimpa, 4, 3) == "->(" .and. left(cLinLimpa, 1) <> "&"
					// Tratamento para considerar linhas do tipo:
					// SA1->(dbSetOrder(99))
					cAlias := left(cLinLimpa, 3)
					cOrder := SubStr(cLinLimpa, 18)
					nOrder := val(left(cOrder, len(cOrder) - 2))
					nTipo  := 1
				ElseIf left(upper(cAntLimpa), 13) == "DBSELECTAREA("
					// Tratamento para considerar linhas do tipo:
					// dbSelectArea("SA1")
					// dbSetOrder(99)
					cAlias := SubStr(cAntLimpa, 15, 3)
					cOrder := SubStr(cLinLimpa, 12)
					nOrder := val(left(cOrder, len(cOrder) - 1))
					nTipo  := 2
				Else
					nOrder := 0
				Endif
				
				If nOrder > 0
					cAlias := upper(cAlias)
					nAlias := aScan(aUsrOrd, {|x| x[1] == cAlias .and. x[2] == nOrder})
					If nAlias > 0
						nY := at("DBSETORDER", upper(cLinha))
						cIdent   := left(cLinha, nY - 1)  // Identacao.
						cCmdNovo := "dbOrderNickName('" + aUsrOrd[nAlias, 3] + "')" + IIf(nTipo == 1, ")", "")
						cComent  := "  // " + SubStr(cLinha, nY) + " // Alterado (UPDXFUN)."
						cLinha   := cIdent + cCmdNovo + cComent
						aAdd(aAlter, {U_FRecNo(), cLinha})
					Endif
				Else
					cLinha += " // Atencao (UPDXFUN)."
					aAdd(aAlter, {U_FRecNo(), cLinha})
				Endif
			Endif
			cAntLimpa := cLinLimpa
		Endif
		cArqNovo += cLinha + CRLF
		
		U_FSkip()
	EndDo
	U_FUse()
	
	If !empty(aAlter)
		// Faz backup do arquivo antigo e grava o arquivo alterado.
		tFRename(cDirPRW + cArqPRW, cDirPRW + cArqPRW + ".OLD")
		MemoWrite(cDirPRW + cArqPRW, cArqNovo)  // Salva o arquivo PRW alterado.
		
		// Informa as alteracoes no log.
		GravaLog(nHdLog, "S", "Arquivo " + cDirPRW + cArqPRW)
		GravaLog(nHdLog, "S", "  Linhas alteradas:")
		aEval(aAlter, {|x| GravaLog(nHdLog, "S", "  " + tNum2Str(x[1]) + ": [" + TrimLin(x[2]) + "]")})
		
		// Identa o arquivo recem criado.
		If lOpcIDN
			GravaLog(nHdLog, "S", "Identando " + cDirPRW + cArqPRW)	
			IdentPRW(cDirPRW + cArqPRW, nHdLog, @lEnd)
		Endif
	Endif
Next nX

// Atualiza regua.
oRegua:IncRegua1("Programas analisados")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza o log.                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
GravaLog(nHdLog, "", "")  // Pula uma linha no arquivo de log.
GravaLog(nHdLog, "", Replicate("-", 20))
GravaLog(nHdLog, "GW")  // Grava os warnings.
GravaLog(nHdLog, "", "Fim de processamento dos programas")
GravaLog(nHdLog, "", "Tempo decorrido: " + U_TDecor(cHrIni, Time()))
GravaLog(nHdLog, "", Replicate("-", 20))
GravaLog(nHdLog, "", "")  // Pula uma linha no arquivo de log.

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ IdentPRW บ Autor ณ Felipe Raposo      บ Data ณ  08/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Abre, identa e fecha o programa PRW passado por parametro. บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function IdentPRW(cPrograma, nHdLog, lEnd)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cArqNovo := ""
Local cTab     := "	"
Local aLinha, cMsg, lErro := .F.
Local nTabAtu := 0
Local nTabPro := 0
Local aAbre   := {"IF ", "#IF", "FOR ", "WHILE ", "DO WHILE ", "BEGIN "}
Local aAbre2  := {"DO CASE"}  // Abre 2 niveis.
Local aMeio   := {"ELSE", "ELSEIF ", "#ELSE", "CASE ", "OTHERWISE"}
Local aFecha  := {"END", "#END", "NEXT"}
Local aFecha2 := {"ENDCASE"}  // Fecha 2 niveis.
Local nTamPRW
Local lComent := .F.  // Variavel para comentar abertura e fechamento de comentario.

U_FUse(cPrograma)
Do While !U_FEOF()
	aLinha := {TrimLin(U_FReadLn())}
	cUpperLin := StrTran(upper(aLinha[1]), "(", " ")
	cUpperLin := tLimpa(cUpperLin)					// Retira os espacos e tabulacoes das pontas.
	cUpperLin := LimpaLin(cUpperLin, @lComent)	// Retira os comentarios.
	
	// Verifica se o usuario cancelou o processamento.
	If lEnd
		cMsg := "Cancelado pelo usuแrio"
		GravaLog(nHdLog, "", cMsg)
		MsgAlert(cMsg, "Aten็ใo")
		Exit
	Endif
	
	// Se nao estiver no meio de um comentario.
	If !lComent
		// Se for quebra de linha, nao verifica a linha seguinte.
		If ";" $ aLinha[1]
			Do While right(LimpaLin(aLinha[len(aLinha)], @lComent), 1) == ";" .and. !U_FEOF()
				U_FSkip()
				aAdd(aLinha, TrimLin(U_FReadLn()))
			EndDo
		Endif
		
		// Se for uma linha de abertura de identacao (ex: if).
		If aScan(aAbre2, {|x| cUpperLin = x}) > 0
			nTabPro += 2
		ElseIf aScan(aAbre, {|x| cUpperLin = x}) > 0
			nTabPro ++
		Endif
		
		// Se for uma linha de meio de identacao (ex: else).
		If aScan(aMeio, {|x| cUpperLin = x}) > 0
			nTabAtu --
		Endif
		
		// Se for uma linha de fim de identacao (ex: endif / endcase).
		If aScan(aFecha2, {|x| cUpperLin = x}) > 0  // Se for uma linha de fim de identacao de dois niveis (ex: endcase).
			nTabAtu -= 2
			nTabPro -= 2
		ElseIf aScan(aFecha, {|x| cUpperLin = x}) > 0  // Se for uma linha de fim de identacao (ex: endif).
			nTabAtu --
			nTabPro --
		Endif
		
		// Nao permite que o valor seja negativo.
		If nTabAtu < 0
			cMsg := "Erro de estrutura no c๓digo."
			GravaLog(nHdLog, "S", cMsg)
			cMsg := "Arquivo " + cPrograma + ", linha " + tNum2Str(U_FRecNo() - 1)
			GravaLog(nHdLog, "S", cMsg)
			cMsg := "[" + aLinha[1] + "]"
			GravaLog(nHdLog, "S", cMsg)
			
			nTabAtu := 0
			nTabPro := 0
			// lErro := .T.
			// Exit
		Endif
	Endif
	
	// Guarda a linha corrente identada.
	aEval(aLinha, {|x, y| cArqNovo += IIf(empty(x), "", replicate(cTab, IIf(y == 1, nTabAtu, nTabPro)) + x) + CRLF})
	
	// Atualiza a proxima identacao.
	nTabAtu := nTabPro
	U_FSkip()
EndDo
U_FUse()  // Fecha o arquivo.

// Verifica se todas as estruturas foram fechadas.
If nTabAtu <> 0
	cMsg := "Erro de estrutura no c๓digo."
	GravaLog(nHdLog, "S", cMsg)
	cMsg := "Arquivo " + cPrograma + "."
	GravaLog(nHdLog, "S", cMsg)
Endif

// Grava o arquivo identado.
If !lErro
	// Salva o arquivo PRW/PRX alterado.
	// Retira o enter do final do arquivo.
	MemoWrite(cPrograma, left(cArqNovo, len(cArqNovo) - 2))
Endif

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ LimpaLin บ Autor ณ Felipe Raposo      บ Data ณ  18/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Elimina da linha do codigo os comentarios feitos com // ou บฑฑ
ฑฑบ          ณ /* comentario * /                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static function LimpaLin(cLinha, lComent)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local nX, cRet := ""
Local cCharAnt := ""
Local cChar    := ""
Local nIni     := 0  // Inicio do comentario.
Local nFim     := 0  // Fim do comentario.
Default lComent := .F.  // Controla se a linha esta dentro de um comentario de multiplas linhas.

// Retira o comentario de multiplas linhas.
nIni := IIf(lComent, 1, at("/*", cLinha))
If nIni > 0  // Se abriu comentario.
	lComent := .T.
	cRet := left(cLinha, nIni - 1)
	nFim := at("*/", cLinha)
	If nFim > 0  // Se fechou comentario.
		cRet += SubStr(cLinha, nFim + 2)
		lComent := .F.
	Endif
Else
	cRet := cLinha
Endif

// Retira os comentarios de linha simples.
If (nX := at("//", cRet)) > 0
	cRet := left(cRet, nX - 1)
Endif
Return cRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TrimLin  บ Autor ณ Felipe Raposo      บ Data ณ  18/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retira as tabulacoes e os espacos em branco no comeco e no บฑฑ
ฑฑบ          ณ final do arquivo.                                          บฑฑ
ฑฑบ          ณ O AllTrim nao funciona pois nao retira as tabulacoes.      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static function TrimLin(cLinha)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local nIni := 0, nFim := 0
Local cTab := "	"

// Pesquisa o primeiro caracter que nao eh nem tab, nem espaco.
For nIni := 1 to len(cLinha)
	If !(SubStr(cLinha, nIni, 1) $ (" " + cTab))
		Exit
	Endif
Next

// Pesquisa o ultimo caracter que nao eh nem tab, nem espaco.
For nFim := len(cLinha) to 1 step -1  // Looping invertido.
	If !(SubStr(cLinha, nFim, 1) $ (" " + cTab))
		Exit
	Endif
Next

Return(SubStr(cLinha, nIni, nFim - nIni + 1))


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetRDMakesบ Autor ณ Felipe Raposo      บ Data ณ  20/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retorna os caminhos dos programas encontrados no projeto   บฑฑ
ฑฑบ          ณ passado por parametro.                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static function RetRDMakes(cProjeto)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local aRet[0], cLinha
Local cDrv, cDir, cArq

// Separa o diretorio do arquivo.
cDrv := left(cProjeto, at(":", cProjeto))

ConOut("Pesquisando arquivos em " + cProjeto)
U_FUse(cProjeto)
Do While !U_FEOF()
	cLinha := tLimpa(U_FReadLn())
	If upper(cLinha) = "FILE "
		cArq := right(cLinha, len(cLinha) - 5)
		If file(cDrv + cArq)
			aAdd(aRet, {cDrv, cArq})
			ConOut(" - " + cArq)
		Else
			ConOut(" - Arquivo " + cArq + " nใo encontrado.")
		Endif
	Endif
	U_FSkip()  // Pula linha.
EndDo
U_FUse()  // Fecha o arquivo do projeto.
ConOut(" - " + tNum2Str(len(aRet)) + " arquivo(s) encontrado(s).")
Return aRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CreateLogบ Autor ณ Felipe Raposo      บ Data ณ  20/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Cria um arquivo de log no disco.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static function CreateLog(cArquivo)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local nHandle

If (nHandle := FCreate(cArquivo)) < 1
	MsgInfo("Nใo foi possํvel criar o arquivo de log.", cArquivo)
Endif

Return nHandle


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GravaLog บ Autor ณ Felipe Raposo      บ Data ณ  20/12/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Grava no arquivo de log e exibe a mensagem no console.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static function GravaLog(nHandle, cTipo, cMsg)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static aWarns[0]

If cTipo == "W"  // Armazena warnings.
	aAdd(aWarns, cMsg)
ElseIf cTipo == "GW"  // Grava warnings.
	aEval(aWarns, {|cMsg| GravaLog(nHandle, "", cMsg)})
	aWarns := {}
Else
	If !empty(cMsg)
		cMsg := dtoc(dDataBase) + " " + Left(time(), 5) + " - " + cMsg
		ConOut(U_TiraAct(cMsg))
	Endif
	FWrite(nHandle, cMsg + CRLF)
Endif

Return .T.