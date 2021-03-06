#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  ��IMPRBOLR    �Autor �Luis Mattos Duarte Jr � Data � 04/07/05���
�������������������������������������������������������������������������͹��
���Desc.     �Impressao de Boletos Banco Real                             ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ImpBolR()
Local oDlg
Local aCA:={OemToAnsi("Confirma"),OemToAnsi("Abandona")} // "Confirma", "Abandona"
Local cCadastro := OemToAnsi("Impressao de Boleto Banco Real")
Local aSays:={}, aButtons:={}
Local nOpca := 0
Private aReturn    := {OemToAnsi('Zebrado'), 1,OemToAnsi('Administracao'), 2, 2, 1, '',1 } // ###
Private nLastKey   := 0
Private nValorTit := 0

Pergunte("IMPBOR", .T. )

CSTRING := "SE1"

//� Variaveis utilizadas para parametros                         �
//��������������������������������������������������������������Ŀ
//� mv_par01            // Sindicato                             �
//� mv_par02            // Natureza                              �
//� mv_par03            // Banco                                 �
//� mv_par04            // Agencia                               �
//� mv_par05            // Conta                                 �
//����������������������������������������������������������������
TITULO := "Boleto Bancario Banco Real"
tamanho := "P"
CDESC1 := "Este programa ira imprimir o Boleto Bancario do Banco Real "
CDESC2 := "obedecendo os parametros escolhidos pelo cliente."
CDESC3 := ""
nHeight:=15
lBold:= .F.
lUnderLine:= .F.
lPixel:= .T.
lPrint:=.F.
oFont1:= TFont():New( "Courier New",,08,,.F.,,,,,.f. )
oFont2:= TFont():New( "Courier New",,12,,.t.,,,,,.f. )
oFont3:= TFont():New( "Times New Roman",,18,,.t.,,,,.T.,.f. )
oFont4:= TFont():New( "Courier New",,20,,.t.,,,,,.f. )
oFont5:= TFont():New( "Courier New",,08,,.T.,,,,,.f. )
oFont6:= TFont():New( "Times New Roman",,12,,.t.,,,,.T.,.f. )
nPag:=1
nTPag:= SE1->(FCount())
nLin:= 0
lpreview := .t.
oprint:=TMSPrinter():New("Boleto Banc�rio Banco Real")
if lPreview
	oPrint:setup()
endif
Private lContinua:= .T.
dbSelectArea( "SE1" )
//002 -- 1874 / 7713319-0
//
cConta 	:= Rtrim( MV_PAR05 )

IF Subst( cConta, Len( cConta ) - 1 ) <> "-"
   MsgStop( "Falta o Digito na Conta " + Rtrim( mv_par05 ) + CHR(13) + CHR(10 ) + ;
				"Favor Corrigir e Retornar" )
	RETURN
ENDIF	

cDigito  := Subst( cConta, Len( cConta ), 1 )
cConta 	:= Subst( cConta, 1, Len( cConta ) - 2  )

cBanco   := "356"
cMoeda   := "9"
cAgencia := Rtrim( mv_par04 ) //"0409"
cAgencia2:= Rtrim( mv_par04 ) //"0409"

cCart    := "57"
cCart2   := "057"
cAno     := Substr(STRZERO(year(DDATABASE),4),3,2)

//cConta   := Iif (mv_par01 == "ESP","0483338","0837008")
/*
if ALLTRIM(SE1->E1_NATUREZ) == "1000"
	cConta   := "5005542"
elseif ALLTRIM(SE1->E1_NATUREZ)=="002"
//	cConta   := "7713319"
	cConta   := "1066389"
elseif ALLTRIM(SE1->E1_NATUREZ) == "001"

//	cConta   := "7710534"
//	cConta   := "6066347"

else
//	cConta   := "9721760"
	cConta   := "0067611"
endif

*/
_cDia    := STRZERO(DAY(DDATABASE),2)+"/" + STRZERO(MONTH(DDATABASE),2) +"/"+ STRZERO(YEAR(DDATABASE),4)
Modulo   := 11
_cObs1 := "" //Formula("001")
_cObs2 := "" //Formula("002")
_cObs3 := ""//Formula("003")
_cObs4 := ""//Formula("004")
_cObs5 := ""//Formula("005")
DbSelectArea("SE1")
DbSetOrder(1)
nCont := 0
DbSelectArea("SA1")
DbSetOrder(1)
DbSeek(xFilial()+SE1->E1_CLIENTE+SE1->E1_LOJA)
_cEmissao := STRZERO(DAY(SE1->E1_EMISSAO),2)+"/" + STRZERO(MONTH(SE1->E1_EMISSAO),2) +"/"+ STRZERO(YEAR(SE1->E1_EMISSAO),4)
_cVENCREA  := STRZERO(DAY(SE1->E1_VENCREA),2)+"/" + STRZERO(MONTH(SE1->E1_VENCREA),2) +"/"+ STRZERO(YEAR(SE1->E1_VENCREA),4)
nCont := nCont + 1
cEnd1 := SA1->A1_END
cEnd2 := SA1->A1_MUN+" - "+SA1->A1_EST
cCep  := SA1->A1_CEP
// Calculo do numero bancario + digito e valor do juros
nParcela := SE1->E1_PARCELA // StrZero(At(SE1->E1_PARCELA,"ABCDEFGHIJKLMN"),3)
if empty(se1->e1_confed) .OR. ALLTRIM(SE1->E1_CONFED)=="."
	CQUERY := "SELECT MAX(SUBSTRING(Z9_TITULO,5,9)) AS TITULO  FROM SZ9010 WHERE LEFT(Z9_TITULO,4)='8000' AND D_E_L_E_T_='' AND (SUBSTRING(Z9_TITULO,13,1)<>'' AND SUBSTRING(Z9_TITULO,13,1)<='9' )"
	TCQUERY cQuery NEW ALIAS "TRB"
	cnumtit  := "8000"+strzero(val(trb->titulo)+1,9)
	dbselectarea("trb")
	dbclosearea("trb")
	cNumBco  := cnumtit //"10300000003"//cAno+ SE1->E1_NUM + nParcela
	dbselectarea("sz9")
	RECLOCK("SZ9",.T.)
	SZ9->Z9_TITULO := CNUMBCO
	SZ9->Z9_CGC    := SA1->A1_CGC
	SZ9->Z9_VENCTO := SE1->E1_VENCREA
	SZ9->Z9_PARCELA:= SE1->E1_PREFIXO+SE1->E1_PARCELA
	MSUNLOCK()
else
	cnumbco := left(se1->e1_confed,13)
endif
_cObs1 := SE1->E1_MENS1
_cObs2 := SE1->E1_MENS2
_cObs3 := SE1->E1_MENS3
_cObs4 := ""//Formula("004")
_cObs5 := ""//Formula("005")

strmult  := "2765432765432"
nban     := Left(cNumBco, 13)
//	BaseDac  := cCart + nban
//	VarDac   := 0
//	For idac := 1 To 13
//		VarDac := VarDac + Val(Subs(BaseDac, idac, 1)) * Val (Subs (strmult, idac, 1))
//	Next idac
//	VarDac  := Modulo - VarDac % Modulo
//	VarDac  := Iif (VarDac == 10, "P", Iif (VarDac == 11, "0", Str (VarDac, 1)))
//	nJuros  := Round(SE1->E1_SALDO * (0 / 3000),2)
RecLock("SE1",.F.)
Replace E1_confed  with cNumBco
Replace E1_NUMBCO  with cNumBco
//   Replace E1_VALJUR  with nJuros
//   Replace E1_PORCJUR with Round((0/30),2)
MsUnLock()
// Calculo do codigo de barras + digito
strmult := "4329876543298765432987654329876543298765432"

nValorTit := SE1->E1_VALOR

IF nValorTit > 99999999.99
	cValor  := StrZero (100 * (nValorTit), 14)
Elseif nValorTit > 0 .and. nValorTit < 0.02 //  igual a 0.01
	nValorTit := 0
	_cFatVenc := STRZERO((SE1->E1_VENCREA - CTOD("07/10/1997")),4)
	cValor  :=  _cFatVenc + Strzero(0, 10 ) // Imprime valor em branco
Else
	_cFatVenc := STRZERO((SE1->E1_VENCREA - CTOD("07/10/1997")),4)
	cValor  :=  _cFatVenc + Strzero(100 * (nValorTit),10)
Endif

cNumero := Subs(SE1->E1_confed,1,13)
cobdigitao:= cnumero+cagencia2+cconta
AUXI := 0
CAUXI := ""
v_base  := cobdigitao
cDigi()
DIGITAOcob := CAUXI
livre   := cAgencia2 + cConta +DIGITAOcob+CNUMERO  // 	livre   := cAgencia2 + cCart + cNumero + cConta + '0'
//	sBarra  := cBanco + cMoeda + cValor + livre
//	CALCDIG := '2759'+STRzero((SE1->E1_VENCREA - CTOD("07/10/1997")),4)+ StrZero(Int(nValorTit*100),10) +cAgencia2 + cConta +DIGITAOcob+_CNUMERO
sBarra  := '3569'+STRzero((SE1->E1_VENCREA - CTOD("07/10/1997")),4)+ StrZero(Int(nValorTit*100),10) +cAgencia2 + cConta +DIGITAOcob+CNUMERO
BaseDiv := 0
For xx := 1 To 43
	BaseDiv := BaseDiv + Val (Subs (sBarra, xx, 1)) * Val (Subs (strmult, xx, 1))
Next xx
resto  := BaseDiv % modulo
resto  := modulo - resto
resto  := Str (Iif (resto > 9 .or. resto == 0 .or. resto == 1, 1,resto),1)
sBarra := '3569'+ resto + STR((SE1->E1_VENCREA - CTOD("07/10/1997")),4)+ StrZero(Int(nValorTit*100),10) +cAgencia2 + cConta +DIGITAOcob+CNUMERO
Barra  := sBarra
// Calculo da linha digit�vel
sDigit := cBanco + cMoeda + cAgencia2 + cCart + cNumero + cConta
sDigi1 := cBanco + cMoeda + cAgencia2 + subs(cConta,1,1)
sDigi2 := subs(cConta,2,6)+	DIGITAOcob+Subs (cnumero,1,3)
sDigi3 := Subs (cnumero,4,10)
cNumBco2 := cAno + SE1->E1_NUM + nParcela
V_Base := cNumbco2
cDigi()
cNumBco2 := substr(V_BASE,1,11)+"-"+substr(V_BASE,12,1)
V_Base := sDigi1
cDigi()
sDigi1 := V_Base
V_Base := sDigi2
cDigi()
sDigi2 := V_Base
V_Base := sDigi3
cDigi()
sDigi3 := V_Base
sDigi1    := Subs (sDigi1, 1, 5) + "." + Subs (sdigi1, 6, 5) + " "
sDigi2    := Subs (sDigi2, 1, 5) + "." + Subs (sdigi2, 6, 6) + " "
sDigi3    := Subs (sDigi3, 1, 5) + "." + Subs (sdigi3, 6, 6) + " "
//	sDigit := sDigi1 + sDigi2 + sDigi3 + " " + resto + Str (100 * (nValorTit),14,0)
sDigit := sDigi1 + sDigi2 + sDigi3 + " " + resto +" "+ cValor
//	SDIGIT:="23790.19801 61015.000005 85016.964109 1 27620000000000"
DbSelectArea("SE1")
if nPag<>1	&& Fim de Pagina
	oprint:EndPage()
	oprint:StartPage()
endif
//oprint:Say(100,0000,"Banco Real ABN AMRO",oFont6,100)  
oprint:SayBitmap( 050,0000,"LOGO3562.BMP",420,100 )                  
oprint:Say(103,0470,"356-5",oFont2,100)
oprint:Say(100,0700,"Recibo do Sacado  ",oFont2,100)
oprint:Box(100,0428,180,0431) // divisao entre Bradesco e no. banco
oprint:Box(100,0610,180,0613) // divisao entre no. banco e sacado
oprint:Box(180,0000,260,1670) // Local Pagamento *******    1470+50
oprint:Box(180,1670,880,2170) // Logotipo
//cBitMap:= "NOVOSIND.BMP"
cBitMap:= "SIND_" + MV_PAR01 + ".Bmp"
oprint:SayBitmap( 300,1695,cBitMap,450,360 )
//   oprint:SayBitmap( 400,1750,cBitMap,300,300 )
//                 superior,esquerda,        ,direita,inferior
oprint:Say(180,0010,"Local de Pagamento: ",oFont1,100)
oprint:Say(180,0405,"Pag�vel em qualquer banco at� o vencimento",oFont5,100)
//	oprint:Say(210,0405,"PAGAR PREFERENCIALMENTE EM QUALQUER AG�NCIA BRADESCO",oFont5,100)
oprint:Box(260,0000,340,1670) // Cedente
oprint:Say(260,0010,"Cedente",oFont1,100)
//oprint:Say(300,0060,SM0->M0_NOMECOM,oFont5,100)
oprint:Say(300,0060,Posicione( "SZQ", 1, xFilial("SZQ")+mv_par01, "ZQ_NOME" ),oFont5,400)
oprint:Box(340,0000,420,0400) // Data do Documento
oprint:Box(340,0400,420,0670) // Numero do Documento
oprint:Box(340,0670,420,0920) // Especie Doc.
oprint:Box(340,0920,420,1270) // Aceite
oprint:Box(340,1270,420,1670) // Data Processamento
oprint:Say(340,0005,"Data do Documento",oFont1,100) // Data do Documento
oprint:Say(340,0405,"No.Documento",oFont1,100) // Numero do Documento
oprint:Say(340,0675,"Esp�cie Doc.",oFont1,100) // Especie Doc.
oprint:Say(340,0925,"Aceite",oFont1,100) // Aceite
oprint:Say(340,1275,"Data Processamento",oFont1,100) // Dia Processamento
oprint:Say(380,0010,_cEmissao,oFont5,100) // Data do Documento
oprint:Say(380,0410,SE1->E1_PREFIXO+SE1->E1_NUM,oFont5,100) // Numero do Documento
oprint:Say(380,0680,"NB",oFont5,100) // Especie Doc.
oprint:Say(380,0930,"A",oFont5,100) // Aceite
oprint:Say(380,1280,_cdia,oFont5,100) // Dia Processamento
oprint:Say(380,1480,"",oFont5,100) // Cart./Nosso numero
oprint:Box(420,0000,500,0250) // Uso do Banco
oprint:Box(420,0250,500,0350) // Cip
oprint:Box(420,0350,500,0550) // Carteira
oprint:Box(420,0550,500,0850) // Especie Moeda
oprint:Box(420,1090,440,1092) // Quantidade
oprint:Box(420,1090,500,1670) // Valor
//oprint:Box(499,0850,501,1470) // Linha para fechar
oprint:Say(440,1084,"X",oFont5,100) // Sinal de X
oprint:Say(420,0005,"Uso Banco",oFont1,100) // Uso do Banco
oprint:Say(420,0255,"Cip",oFont1,100) // Cip
oprint:Say(420,0355,"Carteira",oFont1,100) // Carteira
oprint:Say(420,0555,"Esp�cie Moeda",oFont1,100) // Especie Moeda
oprint:Say(420,0855,"Quantidade",oFont1,100) // Quantidade
oprint:Say(420,1120,"Valor",oFont1,100) // Valor
oprint:Say(460,0025,"",oFont5,100) // Uso do Banco
oprint:Say(460,0265,"",oFont5,100) // Cip
oprint:Say(460,0375,"57",oFont5,100) // Carteira
oprint:Say(460,0590,"R$",oFont5,100) // Especie Moeda

oprint:Box(500,0000,1600,1670) // Instrucoes para o banco

oprint:Say(500,0030,"Instru��es de Responsabilidade do Cedente",oFont1,100) // Instrucoes para o banco

oprint:Say(570,0030,"** Valores Expressos em R$",oFont1,100)

oprint:Say(630,0030,_cObs1,oFont5,100)
oprint:Say(670,0030,_cObs2,oFont5,100)
oprint:Say(710,0030,_cObs3,oFont5,100)
oprint:Say(750,0030,_cObs4,oFont5,100)
oprint:Say(790,0030,_cObs5,oFont5,100)

oprint:Box(880,1670,960,2170) // Vencimento
oprint:Say(880,1680,"Vencimento",oFont1,100)
oprint:Say(910,1770,_cVENCREA,oFont5,100)

oprint:Box(960,1670,1040,2170) // Agencia / Codigo Cedente
oprint:Say(960,1770,"Ag�ncia/C�digo Cedente",oFont1,100)
oprint:Say(1000,1770,cagencia+"/"+cconta+"/"+DIGITAOcob,oFont5,150)
oprint:Box(1040,1670,1120,2170) // Cart./Nosso numero
oprint:Say(1040,1770,"Cart./Nosso N�mero",oFont1,100) // Cart./Nosso numero
//	oprint:Say(1080,1770,Substr(cCart2+"/"+cNumBco2,oFont5,100) // Cart./Nosso numero
oprint:Say(1080,1770,cnumero,oFont5,150) // Cart./Nosso numero
oprint:Box(1120,1670,1200,2170) // Valor do Documento
oprint:Say(1120,1690,"1 (=) Valor do Documento",oFont1,100) // Valor do documento
IF nValorTit <> 0
	oprint:Say(1160,1730,Transform(nValorTit,PesqPict("SE1","E1_VALOR")),oFont5,100) // Valor do documento
ENDIF
oprint:Box(1200,1670,1280,2170) // (-)Desconto/Abatimento
oprint:Say(1200,1690,"2 (-) Desconto/Abatimento",oFont1,100) // (-)Desconto/Abatimento

oprint:Box(1280,1670,1360,2170) // (-)Outras Dedu��es

oprint:Say(1280,1690,"3 (-) Outras Dedu��es",oFont1,100) // (-)Outras Dedu��es
oprint:Box(1360,1670,1440,2170) // (-)Mora/Multa

oprint:Say(1360,1690,"4 (+) Mora/Multa",oFont1,100) // (-)Mora/Multa

oprint:Box(1440,1670,1520,2170) // (-)Outros Acrescimos

oprint:Say(1440,1690,"5 (+)Outros Acr�scimos",oFont1,100) // (-)Outros Acrescimos

oprint:Box(1520,1670,1600,2170) // (=)Valor Cobrado

oprint:Say(1520,1690,"6 (=) Valor Cobrado",oFont1,100) // (=)Valor Cobrado

oprint:Box(1600,0000,1760,2170) // Sacado
oprint:Say(1630,0010,"Sacado ",oFont1,100)
oprint:Say(1630,0150,SA1->A1_NOME,oFont5,100)
If Len(Alltrim(SA1->A1_CGC))==11
	oprint:Say(1640,1170,"CNPJ "+Transform(SA1->A1_CGC,"@R 999.999.999-99"),oFont5,100)
Else
	oprint:Say(1640,1170,"CNPJ "+Transform(SA1->A1_CGC,"@R 99.999.999/9999-99"),oFont5,100)
EndIf
oprint:Say(1660,0010,AllTrim(SA1->A1_END)+" - "+Alltrim(SA1->A1_BAIRRO),oFont5,100)
oprint:Say(1690,0010,Transform(SA1->A1_CEP,"@R 99999-999")+"   "+Alltrim(SA1->A1_MUN)+" - "+SA1->A1_EST,oFont5,100)
oprint:Say(1760,0010,"Sacador/Avalista",oFont1,100)//1060
oprint:Say(1760,1370,"Autentica��o Mec�nica  ",oFont1,100)//1060

oprint:Say(2000,0000,Repl("-",145),oFont1,100)


///// Segunda Parte +700



//oprint:Say(2100,0000,"Banco Real ABN AMRO",oFont6,100)
oprint:SayBitmap( 2050,0000,"LOGO3562.BMP",420,100 )    
oprint:Say(2103,0470,"356-5",oFont2,100)
oprint:Say(2100,0700,sDigit,oFont2,100)

oprint:Box(2100,0428,2180,0431) // divisao entre Bradesco e no. banco
oprint:Box(2100,0610,2180,0613) // divisao entre no. banco e sacado
oprint:Box(2180,0000,2260,1670) // Local Pagamento
oprint:Box(2180,1670,2260,2170) // Vencimento

oprint:Say(2180,0010,"Local de Pagamento: ",oFont1,100)
oprint:Say(2180,0405,"Pagavel em qualquer Banco at� o vencimento",oFont5,100)
oprint:Say(2180,1680,"Vencimento",oFont1,100)

oprint:Say(2210,0405,"",oFont5,100)
oprint:Say(2210,1770,_cVENCREA,oFont5,100)

oprint:Box(2260,0000,2340,1670) // Cedente
oprint:Box(2260,1670,2340,2170) // Agencia / Codigo Cedente
oprint:Say(2260,0010,"Cedente",oFont1,100)
oprint:Say(2260,1770,"Ag�ncia/C�digo Cedente",oFont1,100)
//oprint:Say(2300,0060,SM0->M0_NOMECOM,oFont5,100)
oprint:Say(2300,0060,Posicione( "SZQ", 1, xFilial("SZQ")+mv_par01, "ZQ_NOME" ),oFont5,400)
XAGENCIA := cagencia2+"/"+cconta+"/"+digitaocob
oprint:Say(2300,1770,Xagencia,oFont5,110)
oprint:Box(2340,0000,2420,0400) // Data do Documento
oprint:Box(2340,0400,2420,0670) // Numero do Documento
oprint:Box(2340,0670,2420,0920) // Especie Doc.
oprint:Box(2340,0920,2420,1270) // Aceite
oprint:Box(2340,1270,2420,1670) // Dia Processamento
oprint:Box(2340,1670,2420,2170) // Cart./Nosso numero

oprint:Say(2340,0005,"Data do Documento",oFont1,100) // Data do Documento
oprint:Say(2340,0405,"No.Documento",oFont1,100) // Numero do Documento
oprint:Say(2340,0675,"Esp�cie Doc.",oFont1,100) // Especie Doc.
oprint:Say(2340,0925,"Aceite",oFont1,100) // Aceite
oprint:Say(2340,1275,"Data Processamento",oFont1,100) // Dia Processamento
oprint:Say(2340,1675,"Cart./Nosso N�mero",oFont1,100) // Cart./Nosso numero

oprint:Say(2380,0010,_cEmissao,oFont5,100) // Data do Documento
oprint:Say(2380,0410,SE1->E1_PREFIXO+SE1->E1_NUM,oFont5,100) // Numero do Documento
oprint:Say(2380,0680,"NB",oFont5,100) // Especie Doc.
oprint:Say(2380,0930,"A",oFont5,100) // Aceite
oprint:Say(2380,1280,_cDia,oFont5,100) // Dia Processamento
//	oprint:Say(2380,1770,cCart2+"/" + cNumBco2,oFont5,100) // Cart./Nosso numero
oprint:Say(2380,1770,Cnumero,oFont5,100) // Cart./Nosso numero

oprint:Box(2420,0000,2500,0250) // Uso do Banco
oprint:Box(2420,0250,2500,0350) // Cip
oprint:Box(2420,0350,2500,0550) // Carteira
oprint:Box(2420,0550,2500,0850) // Especie Moeda
oprint:Box(2420,1090,2440,1092) // Quantidade
oprint:Box(2470,1090,2500,1092) // Valor
//oprint:Box(2499,0850,2501,1470) // Linha para fechar
oprint:Say(2440,1084,"X",oFont5,100) // Sinal de X
oprint:Box(2420,1670,2500,2170) // Valor do Documento

oprint:Say(2420,0005,"Uso Banco",oFont1,100) // Uso do Banco
oprint:Say(2420,0255,"Cip",oFont1,100) // Cip
oprint:Say(2420,0355,"Carteira",oFont1,100) // Carteira
oprint:Say(2420,0555,"Esp�cie Moeda",oFont1,100) // Especie Moeda
oprint:Say(2420,0855,"Quantidade",oFont1,100) // Quantidade
oprint:Say(2420,1120,"Valor",oFont1,100) // Valor
oprint:Say(2420,1690,"1 (=) Valor do Documento",oFont1,100) // Valor do documento

oprint:Say(2460,0025,"",oFont5,100) // Uso do Banco
oprint:Say(2460,0265,"",oFont5,100) // Cip
oprint:Say(2460,0375,"57",oFont5,100) // Carteira
oprint:Say(2460,0590,"REAL",oFont5,100) // Especie Moeda
IF nValorTit <> 0
	oprint:Say(2460,1730,Transform(nValorTit,PesqPict("SE1","E1_VALOR")),oFont5,100) // Valor do documento
ENDIF
oprint:Box(2500,1670,2580,2170) // (-)Desconto/Abatimento
oprint:Box(2500,0000,2900,1670) // Instrucoes para o banco

oprint:Say(2500,1690,"2 (-) Desconto/Abatimento",oFont1,100) // (-)Desconto/Abatimento
oprint:Say(2500,0030,"Instru��es de Responsabilidade do Cedente",oFont1,100) // Instrucoes para o banco

oprint:Box(2580,1670,2660,2170) // (-)Outras Dedu��es

oprint:Say(2570,0030,"** Valores Expressos em R$",oFont1,100)
oprint:Say(2580,1690,"3 (-) Outras Dedu��es",oFont1,100) // (-)Outras Dedu��es

oprint:Say(2630,0030,_cObs1,oFont5,100)

oprint:Box(2660,1670,2740,2170) // (-)Mora/Multa

oprint:Say(2660,1690,"4 (+) Mora/Multa",oFont1,100) // (-)Mora/Multa

oprint:Say(2660,0030,_cObs2,oFont5,100)
oprint:Say(2690,0030,_cObs3,oFont5,100)
oprint:Say(2720,0030,_cObs4,oFont5,100)
oprint:Box(2740,1670,2820,2170) // (-)Outros Acrescimos

oprint:Say(2740,1690,"5 (+)Outros Acr�scimos",oFont1,100) // (-)Outros Acrescimos
oprint:Say(2750,0030,_cObs5,oFont5,100)


oprint:Box(2820,1670,2900,2170) // (=)Valor Cobrado

oprint:Say(2820,1690,"6 (=) Valor Cobrado",oFont1,100) // (=)Valor Cobrado


oprint:Box(2900,0000,3060,2170) // Sacado 1970
oprint:Say(2930,0010,"Sacado ",oFont1,100)
oprint:Say(2930,0150,SA1->A1_NOME,oFont5,100)
If Len(Alltrim(SA1->A1_CGC))==11
	oprint:Say(2940,1170,"CNPJ "+Transform(SA1->A1_CGC,"@R 999.999.999-99"),oFont5,100)
Else
	oprint:Say(2940,1170,"CNPJ "+Transform(SA1->A1_CGC,"@R 99.999.999/9999-99"),oFont5,100)
EndIf
oprint:Say(2960,0010,AllTrim(SA1->A1_END)+" - "+Alltrim(SA1->A1_BAIRRO),oFont5,100)
oprint:Say(2990,0010,Transform(SA1->A1_CEP,"@R 99999-999")+"   "+Alltrim(SA1->A1_MUN)+" - "+SA1->A1_EST,oFont5,100)
oprint:Say(3060,0010,"Sacador/Avalista",oFont1,100)
oprint:Say(3060,1370,"Autentica��o Mec�nica    Ficha de Compensa��o",oFont1,100)
MsBar("INT25",27.5,1,Barra,oprint,.F.,,.T.,0.025,1.35,,,)
nPag ++
dbSelectArea("SE1")
//oprint:Setup() // para configurar impressora
//oprint:Preview()
If lPreview
	oPrint:Preview()
Else
	oPrint:Print()
Endif
MS_FLUSH()
Return .T.

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �VALIDPERG � Autor � Rdmake        � Data �  21/08/01        ���
�������������������������������������������������������������������������͹��
���Descri��o � Verifica a existencia das perguntas criando-as caso seja   ���
���          � necessario (caso nao existam).                             ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������

Static Function ValidPerg
Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)
If ALLTRIM(cVersao) == "5.07"
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Prefixo       ?","mv_ch1","C",03,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Numero de     ?","mv_ch2","C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"03","Numero ate    ?","mv_ch3","C",06,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
Else
	aAdd(aRegs,{cPerg,"01","Prefixo       ?","Prefixo       ?","Prefixo       ?","mv_ch1","C",03,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Numero de     ?","Numero de     ?","Numero de     ?","mv_ch2","C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"03","Parcela       ?","Numero ate    ?","Numero ate    ?","mv_ch3","C",01,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"04","Qual Conta    ?","Qual Conta    ?","Qual Conta    ?","mv_ch4","N",01,0,0,"C","","mv_par03","5005542","","","","","7713319","","","","","7710534","","","","","9721760","","","","","6713314","","","",""})
Endif

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
dbSelectArea(_sAlias)
Return
/*/

***********************
Static Function cDigi()
lBase  := Len(V_Base)
umdois := 2
sumdig := 0
auxi   := 0
CAUXI  := ""
iDig := lBase
While iDig >= 1
	auxi   := Val (Subs(V_base, idig, 1)) * umdois
	sumdig := SumDig + Iif (auxi < 10, auxi, INT (auxi / 10) + auxi % 10)
	umdois := 3 - umdois
	iDig   := iDig - 1
Enddo
Cauxi   := Str (Round (sumdig / 10 + 0.49, 0) * 10 - sumdig, 1)
auxi   := Str (Round (sumdig / 10 + 0.49, 0) * 10 - sumdig, 1)
V_Base := V_Base + Cauxi
Return
