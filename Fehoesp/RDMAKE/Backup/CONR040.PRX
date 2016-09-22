#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#endif

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ Conr040  ³ Autor ³ Wagner Xavier         ³ Data ³ 25.11.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Balancete Analitico e Sintetico em Reais                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Conr040(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Rdmake   ³ Autor  ³  Luiz Carlos Vieira       ³ Data  ³   02.03.1998  ³±±
±±³          ³        ³  Jeremias Luna            ³       ³   03.11.1998  ³±±
±±³          ³        ³  Luiz Eduardo D. da Roz   ³       ³   31.05.1999  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cDesc1    := "Este programa ir  imprimir o Balancete Anal¡tico e Sint‚tico "+;
             "em " + GetMv("MV_MOEDA1")
cDesc2    := "de acordo com os parƒmetros solicitados pelo usu rio."
cDesc3    := ""
wnrel     := ""
cString   := "SI1"
aDataAnt  := {}
lSaldant  := .T.
aDataAtu  := {}
cMesAtu17 := ""
cMesAnt17 := ""
aReturn   := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
nomeprog  := "CONR040"
aLinha    := { }
nLastKey  := 0
cPerg     := "CON040"
cFolha    := "Folha:    "
nQuebra   := 0
dData     := CTOD("")
cNivel1   := ""
nSaldoAtu := 0
nSalant   := 0
nTotDeb   := 0
nTotCrd   := 0
nTregs    := 0
nMult     := 0
CbTxt     := ""
CbCont    := 0
tamanho   :=" "
limite    := 132
bSinal    := { | nSaldo | IIF(nSaldo < 0,cD,IIF(nSaldo > 0,cC," ") ) }
cVar      := ""
nSal      := 0
lEstrang  := .F.
lEnd      := .f.
PULO      := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

li := 80

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

pergunte(cPerg,.f.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01                // Data de referencia do periodo     ³
//³ mv_par02                // Com Centro de Custo               ³
//³ mv_par03                // A partir da conta                 ³
//³ mv_par04                // Ate a conta                       ³
//³ mv_par05                // Imprime sinteticas zeradas        ³
//³ mv_par06                // Analitico ou Sintetico            ³
//³ mv_par07                // Pagina Inicial                    ³
//³ mv_par08                // Descricao Lingua Nacional/Estrang ³
//³ mv_par09                // Cons Desp/Rec Exercicio Anterior  ³
//³ mv_par10                // Grupo Desp/Receita                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas no arquivo SIGACONR.INI ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

titulo   := "Balancete Analitico e Sintetico em " + GetMv("MV_MOEDA1")
cabec1   := " "
cabec2   := " " 
*cLinha   := "*  CODIGO DA CONTA      *   D  E  S  C  R  I  C  A  O    *   SALDO ANTERIOR  *      DEBITO    *      CREDITO   *   SALDO ATUAL     *"
cLinha   := "| CODIGO DA CONTA |  D  E  S  C  R  I  C  A  O           |   SALDO ANTERIOR  |      DEBITO    |      CREDITO   |   SALDO ATUAL     |"

cCancel  := "***** CANCELADO PELO OPERADOR *****"
cTituloA := ""
cTituloS := ""
cTotMes  := "TOTAIS DO PERIODO : "
cD       := "D"
cC       := "C"
cANT     := ""

wnrel    := "CONR040"            //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"")

if nLastKey == 27
	Set Filter To
	Return
endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcula datas iniciais e finais 										³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aDataAtu := CalcData(mv_par01,1)
aDataAnt := CalcAnt(aDataAtu[1],1)

if ! DataMoeda(1, @cMesAtu17, aDataAtu[1])
	#IFNDEF WINDOWS
		Set Device To Screen
	#endif

	Help(" ",1,"MESINVALID")
	Set Filter To
	Return
endif

DataMoeda(1, @cMesAnt17, aDataAnt[1])

cTituloA := "BALANCETE ANALITICO DE " + Dtoc(aDataAtu[1]) + " ATE " + Dtoc(aDataAtu[2]) + " EM " + GetMV("MV_MOEDA1") 
cTituloS := "BALANCETE SINTETICO DE " + Dtoc(aDataAtu[1]) + " ATE " + Dtoc(aDataAtu[2]) + " EM " + GetMV("MV_MOEDA1")

if nLastKey == 27
	Set Filter To
	Return
endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao REPORTINI substituir as variaveis.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

*ReportIni("CONR040")

SetDefault(aReturn,cString)

if nLastKey == 27
	Set Filter To
	Return
endif

#IFDEF WINDOWS
     RptStatus({|| Execute(Cr040Imp) },Titulo)
     Return
     Function Cr040Imp
#endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se descricao em outra lingua        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

lEstrang := .F.

dbSelectArea("SX3")
dbSetOrder(2)
dbSeek("I1_DESCEST")
if X3USO(X3_USADO)
	if mv_par08 == 2
		lEstrang := .T.
	endif
endif

dbSetOrder(1)
dbSelectArea("SI1")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existem contas desatualizadas                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCont := 1 To Val(cMesAtu17)
	if nCont == Val(cMesAtu17)
		if CheckSint(Val(cMesAtu17),Month(mv_par01))
			Set Filter To
			Return
		endif
	else
		if CheckSint(nCont,nCont,.F.)
			cVar := cVar + "N"
		else
			cVar := cVar + "S"
		endif
	endif
Next nCont

if "N" $ cVar
	#IFNDEF WINDOWS
		Set Device To Screen
	#endif

	Help(" ",1,"Cr040SINT",,cVar,5,13)

	#IFNDEF WINDOWS
		Set Device To Print
	#endif
endif

if mv_par06 == 1
    titulo := cTituloA
else
    titulo := cTituloS
endif

m_pag := mv_par07

dbSelectArea("SM0")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza a conta inicial					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SI1")
dbSeek( xFilial()+mv_par03,.T. )

SetRegua(Reccount())

While !Eof() .and. I1_FILIAL == xFilial() .and. I1_CODIGO >= mv_par03 .and. I1_CODIGO <= mv_par04
	#IFNDEF WINDOWS
		Inkey()
		if Lastkey() == 286
			lEnd := .T.
		endif
	#endif

	if lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	endif

	IncRegua()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se sera somente contas sinteticas						  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	if mv_par06 == 2
		if I1_CLASSE == "A"
	                cANT := I1_CODIGO
			dbSkip()
			Loop
		endif
	endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a conta tem centro de custo e se sera impressa   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if I1_NCUSTO > 0 .and. mv_par02 == 2
	        cANT := I1_CODIGO
		dbSkip()
		Loop
	endif

	if nQuebra == 0
		nQuebra := 1
		cNivel1 := Substr(I1_CODIGO,1,1)
	endif

	if cNivel1 != Substr(I1_CODIGO,1,1)  
		nQuebra := 0

		@li,00 PSAY "+" + REPLIC("-",17) + "+" + REPLIC("-",38) + "+" + REPLIC("-",19) + "+" + REPLIC("-",16) + "+" + REPLIC("-",16) + "+" + REPLIC("-",19) + "+"

		li := 60
	endif

	if li > 58
		if li != 80 .and. nQuebra==1
		   @li,00 PSAY "+" + REPLIC("-",17) + "+" + REPLIC("-",38) + "+" + REPLIC("-",19) + "+" + REPLIC("-",16) + "+" + REPLIC("-",16) + "+" + REPLIC("-",19) + "+"
		endif

		nChar  := IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM"))
		dData1 := mv_par01
		dData2 := mv_par02

		cr040Cabec()

		li := li - 1
	endif

	lSaldant := .T.

	if Substr(SI1->I1_CODIGO,1,1) $ mv_par10
		lSaldant := Iif(mv_par09==1,.T.,.F.)
	endif

	if Val(cMesAtu17) <= 12
		lSaldant := .T.
	endif

	nSalant  := CalcSaldo(Val(cMesAnt17),1,lSaldant)
	nSaldoAtu:= CalcSaldo(Val(cMesAtu17),1,lSaldant)

	uDeb := "I1_DEBM"+cMesAtu17
	uDeb := &uDeb
	uCre := "I1_CRDM"+cMesAtu17
	uCre := &uCre

	if (Int(nSaldoAtu*100)/100) == 0 .and. (Int(uDeb*100)/100) == 0;
		.and. (Int(uCre*100)/100) == 0
		
		if I1_CLASSE == "A"
	                cANT := I1_CODIGO
			dbSkip( )
			loop
		endif
		if I1_CLASSE == "S" .and. mv_par05 == 2
	                cANT := I1_CODIGO
			dbSkip( )
			Loop
		endif
	endif

	if ( ( ALLTRIM(SUBSTR(I1_CODIGO,1,6))<>ALLTRIM(SUBSTR(cANT,1,6)) ) .AND. !PULO )   
							   
	   @ li,000  PSAY "|"
	   @ li,018  PSAY "|"
	   @ li,057  PSAY "|"
	   @ li,077  PSAY "|"
	   @ li,094  PSAY "|"
	   @ li,111  PSAY "|"
	   @ li,131  PSAY "|"

	   li := li + 1

	   PULO:=.F.

	endif

	@ li,00 PSAY "|"

	@ li,01 PSAY Trim(Mascara(I1_CODIGO))
	@ li,18 PSAY "|"

	if lEstrang
		@ li,19 PSAY Left( Space(Val(I1_NIVEL))+I1_DESCEST , 38 )
	else
		@ li,19 PSAY Left( Space(Val(I1_NIVEL))+I1_DESC , 38 )
	endif

	@li,57 PSAY "|"

	@li,58 PSAY ABS(nSalant)   Picture tm(nSalant,17)

	if (Int(nSalant*100)/100) != 0 
		@li,76 PSAY Eval ( bSinal , nSalant )
	endif

	@ li,077 PSAY "|"

	uDeb := "I1_DEBM"+cMesAtu17
	uDeb := &uDeb
	uCre := "I1_CRDM"+cMesAtu17
	uCre := &uCre

	@ li,078 PSAY ABS(uDeb)    Picture tm(uDeb,16)
	@ li,094 PSAY "|"

	@ li,095 PSAY ABS(uCre)    Picture tm(uCre,16)

	if SI1-> I1_NIVEL == "1"
		nTotDeb  := nTotDeb + ABS(uDeb)
		nTotCrd  := nTotCrd + ABS(uCre)
	endif

	@li,111 PSAY "|"

	@li,112 PSAY Abs( nSaldoAtu )   Picture tm( nSaldoAtu,17 )

	if (Int(nSaldoAtu*100)/100) != 0 
		@li,130 PSAY Eval ( bSinal , nSaldoAtu )
	endif

	@li,131 PSAY "|"

	cClasseAnterior := i1_classe

	cANT := I1_CODIGO

	dbskip()

	PULO:=.F.

	if ( cClasseAnterior == 'A' .and. i1_classe == "A" ) 
	else
		li := li + 1

		@ li,000  PSAY "|"
		@ li,018  PSAY "|"
		@ li,057  PSAY "|"
		@ li,077  PSAY "|"
		@ li,094  PSAY "|"
		@ li,111  PSAY "|"
		@ li,131  PSAY "|"

		PULO:=.T.
	endif

	li := li + 1
enddo

if li != 80 .And. !lEnd
        @li,00 PSAY "+" + REPLIC("-",17) + "+" + REPLIC("-",38) + "+" + REPLIC("-",19) + "+" + REPLIC("-",16) + "+" + REPLIC("-",16) + "+" + REPLIC("-",19) + "+"

	li := li + 1

        @li,000 PSAY "|"

        @li,020 PSAY cTotMes
        @li,078 PSAY nTotDeb   Picture tm(nTotDeb,16)

        @li,094 PSAY "|"

        @li,095 PSAY nTotCrd   Picture tm(nTotCrd,16)

	@li,111 PSAY "|"
	@li,131 PSAY "|"

	li := li + 1

	@li,00 PSAY "+" + REPLIC("-",17) + "+" + REPLIC("-",38) + "+" + REPLIC("-",19) + "+" + REPLIC("-",16) + "+" + REPLIC("-",16) + "+" + REPLIC("-",19) + "+"
	
	li := li + 1

	@li,0 PSAY " "

	roda(cbcont,cbtxt," ")
endif

Set Filter To
#IFNDEF WINDOWS
	Set Device To Screen
#endif
                     
if aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	Ourspool(wnrel)
endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³cr040Cabec³ Autor ³ Pilar S. Albaladejo   ³ Data ³ 22.03.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Rotina de impressao do cabecalho do balancete	          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ cr040cabec(char)						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso	     ³ Generico							  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Function cr040cabec

cAlias   := Alias()
nLin     := 0
nlargura := 132
nTamanho := " "
aDriver  := ReadDriver()

if nChar == NIL
	cCtl := if(nTamanho=="P",aDriver[1],if(nTamanho=="G",aDriver[5],aDriver[3]))
	cCtl := &cCtl
else
	if nChar == 15
		cCtl := if(nTamanho=="P",aDriver[1],if(nTamanho=="G",aDriver[5],aDriver[3]))
                cCtl := &cCtl
	else
		cCtl := if(nTamanho=="P",aDriver[2],if(nTamanho=="G",aDriver[6],aDriver[4]))
		cCtl := &cCtl
	endif
endif

dbSelectArea( "SM0" )

@nLin,050 PSAY cCtl

nLin := nLin + 1


* cNome:=SM0->M0_NOMECOM
cNome:="Sindicato dos Hospitais Clin.C.Sau.Lab.de Pesq. Anal.Clin. do Est. de S.Paulo"

@ nLin, Int((nlargura - (Len(Trim(cNome))))/2) PSAY cNome

@ nLin, nlargura-18 PSAY cFolha + Transform(m_pag,'99999')

nLin := nLin + 1

@ nLin, Int((nlargura - 18)/2) PSAY "CNPJ: " + Transform(Alltrim(SM0->M0_CGC),"@R 99.999.999/9999-99")
@ nLin, nlargura-18 PSAY "Dt.Ref.: " + DtoC( mv_par01 )

nLin := nLin + 1

@ nLin, Int((nlargura - (Len(Trim( titulo ))))/2) PSAY titulo

nLin := nLin + 1

@ nLin, 01 PSAY "Hora...:" + Time()
@ nLin, nLargura - 18  PSAY "Emissao: " + DtoC( dDataBase )

nLin := nLin + 1

@ nlin,00 PSAY "+" + REPLIC("-",17) + "+" + REPLIC("-",38) + "+" + REPLIC("-",19) + "+" + REPLIC("-",16) + "+" + REPLIC("-",16) + "+" + REPLIC("-",19) + "+"

nLin := nLin + 1

@ nLin, 00 PSAY cLinha

nLin := nLin + 1

@ nlin,00 PSAY "+" + REPLIC("-",17) + "+" + REPLIC("-",38) + "+" + REPLIC("-",19) + "+" + REPLIC("-",16) + "+" + REPLIC("-",16) + "+" + REPLIC("-",19) + "+"

li := nLin + 2
m_pag := m_pag + 1

dbSelectArea( cAlias )

Return
