#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  ��IMPBOLi  �Autor  �    Nava            � Data � 11/01/08    ���
�������������������������������������������������������������������������͹��
���Desc.     �Impressao de Boletos Banco ITAU                             ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ImpBolI()
Local oDlg
Local aCA:={OemToAnsi("Confirma"),OemToAnsi("Abandona")} // "Confirma", "Abandona"
Local cCadastro := OemToAnsi("Impressao de Boleto Banco ITAU")
Local aSays:={}, aButtons:={}
Local nOpca := 0
Private aReturn    := {OemToAnsi('Zebrado'), 1,OemToAnsi('Administracao'), 2, 2, 1, '',1 } // ###
Private nLastKey   := 0

Pergunte("IMPBOI", .T. )

CSTRING := "SE1"

//� Variaveis utilizadas para parametros                         �
//��������������������������������������������������������������Ŀ
//� mv_par01            // Sindicato                             �
//� mv_par02            // Natureza                              �
//� mv_par03            // Banco                                 �
//� mv_par04            // Agencia                               �
//� mv_par05            // Conta                                 �
//����������������������������������������������������������������
TITULO := "Boleto Bancario Banco ITAU"
tamanho := "P"
CDESC1 := "Este programa ira imprimir o Boleto Bancario do Banco ITAU "
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
oprint:=TMSPrinter():New("Boleto Banc�rio Banco ITAU")
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

cBanco   := "341"
cMoeda   := "9"
cAgencia := Rtrim( mv_par04 ) //"0409"
cAgencia2:= Rtrim( mv_par04 ) //"0409"

cCart    := "175"
//cCart2   := "057"
cAno     := Substr(STRZERO(year(DDATABASE),4),3,2)

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
	CQUERY := "SELECT MAX(SUBSTRING(Z9_TITULO,5,9)) AS TITULO  FROM SZ9010 WHERE LEFT(Z9_TITULO,4)='7000' AND D_E_L_E_T_='' AND (SUBSTRING(Z9_TITULO,13,1)<>'' AND SUBSTRING(Z9_TITULO,13,1)<='9' )"
	TCQUERY cQuery NEW ALIAS "TRB"
	cnumtit  := "7000"+strzero(val(trb->titulo)+1,9)
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
IF SE1->E1_VALOR > 99999999.99
	cValor  := StrZero (100 * (SE1->E1_VALOR), 14)
Else
	_cFatVenc := STRZERO((SE1->E1_VENCREA - CTOD("07/10/1997")),4)
	cValor  :=  _cFatVenc + Strzero(100 * (SE1->E1_VALOR),10)
Endif

//cNumero := Subs(SE1->E1_confed,1,8)
cNumero := Right(Rtrim( SE1->E1_confed ),8 )

DbSelectArea("SE1")
if nPag<>1	&& Fim de Pagina
	oprint:EndPage()
	oprint:StartPage()
endif

CB_RN_NN := aNumbers( cNumero)

oprint:Say(100,0000,"Banco ITAU S.A.",oFont6,100)
oprint:Say(103,0470,"341-7",oFont2,100)
oprint:Say(100,0700,"Recibo do Sacado  ",oFont2,100)
oprint:Box(100,0428,220,0431) // divisao entre Bradesco e no. banco
oprint:Box(100,0610,220,0613) // divisao entre no. banco e sacado
oprint:Box(180,0000,260,1670) // Local Pagamento *******    1470+50
oprint:Box(180,1670,880,2170) // Logotipo
cBitMap:= "NOVOSIND.BMP"
//cBitMap:= "SIND_" + MV_PAR01 + ".Bmp"
oprint:SayBitmap( 300,1695,cBitMap,450,360 )
//   oprint:SayBitmap( 400,1750,cBitMap,300,300 )
//                 superior,esquerda,        ,direita,inferior
oprint:Say(180,0010,"Local de Pagamento: ",oFont1,100)
oprint:Say(180,0405,"AT� O VENCIMENTO, PREFERENCIALMENTE NO ITA� OU BANERJ",oFont5,100)
oprint:Say(210,0405,"AP�S O VENCIMENTO, SOMENTE NO ITA� OU BANERJ",oFont5,100)
oprint:Box(260,0000,340,1670) // Cedente
oprint:Say(260,0010,"Cedente",oFont1,100)
//oprint:Say(300,0060,SM0->M0_NOMECOM,oFont5,100)
oPrint:Say(300,0060,Posicione( "SZQ", 1, xFilial("SZQ")+mv_par01, "ZQ_NOME" ),oFont5,400)
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
oprint:Box(499,0850,501,1470) // Linha para fechar
oprint:Say(440,1084,"X",oFont5,100) // Sinal de X
oprint:Say(420,0005,"Uso Banco",oFont1,100) // Uso do Banco
oprint:Say(420,0255,"Cip",oFont1,100) // Cip
oprint:Say(420,0355,"Carteira",oFont1,100) // Carteira
oprint:Say(420,0555,"Esp�cie Moeda",oFont1,100) // Especie Moeda
oprint:Say(420,0855,"Quantidade",oFont1,100) // Quantidade
oprint:Say(420,1120,"Valor",oFont1,100) // Valor
oprint:Say(460,0025,"",oFont5,100) // Uso do Banco
oprint:Say(460,0265,"",oFont5,100) // Cip
oprint:Say(460,0375,cCart,oFont5,100) // Carteira
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
oprint:Say(1000,1770,cagencia+"/"+cConta +"-"+cDigito,oFont5,150)
oprint:Box(1040,1670,1120,2170) // Cart./Nosso numero
oprint:Say(1040,1770,"Cart./Nosso N�mero",oFont1,100) // Cart./Nosso numero
//	oprint:Say(1080,1770,Substr(cCart2+"/"+cNumBco2,oFont5,100) // Cart./Nosso numero
oprint:Say(1080,1770,cCart + "/"+Subst( CB_RN_NN[4], 1, 8 ) + "-"+Subst( CB_RN_NN[4], 9, 1 ),oFont5,100) // Cart./Nosso numero
oprint:Box(1120,1670,1200,2170) // Valor do Documento
oprint:Say(1120,1690,"1 (=) Valor do Documento",oFont1,100) // Valor do documento
IF SE1->E1_VALOR <> 0
	oprint:Say(1160,1730,Transform(SE1->E1_VALOR,PesqPict("SE1","E1_VALOR")),oFont5,100) // Valor do documento
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
	oprint:Say(1640,1170,"CGC "+Transform(SA1->A1_CGC,"@R 999.999.999-99"),oFont5,100)
Else
	oprint:Say(1640,1170,"CGC "+Transform(SA1->A1_CGC,"@R 99.999.999/9999-99"),oFont5,100)
EndIf
oprint:Say(1660,0010,AllTrim(SA1->A1_END)+" - "+Alltrim(SA1->A1_BAIRRO),oFont5,100)
oprint:Say(1690,0010,Transform(SA1->A1_CEP,"@R 99999-999")+"   "+Alltrim(SA1->A1_MUN)+" - "+SA1->A1_EST,oFont5,100)
oprint:Say(1760,0010,"Sacador/Avalista",oFont1,100)//1060
oprint:Say(1760,1370,"Autentica��o Mec�nica  ",oFont1,100)//1060

oprint:Say(2000,0000,Repl("-",145),oFont1,100)


///// Segunda Parte +700

oprint:Say(2100,0000,"Banco ITA� S.A.",oFont6,100)
oprint:Say(2103,0470,"341-7",oFont2,100)
oprint:Say(2100,0700,CB_RN_NN[2],oFont2,100)
//oPrint:Say (_nLin+1934,0820,CB_RN_NN[2],oFont14n)		// [2] Linha Digitavel do Codigo de Barras

oprint:Box(2100,0428,2220,0431) // divisao entre Bradesco e no. banco
oprint:Box(2100,0610,2220,0613) // divisao entre no. banco e sacado
oprint:Box(2180,0000,2260,1670) // Local Pagamento
oprint:Box(2180,1670,2260,2170) // Vencimento

oprint:Say(2180,0010,"Local de Pagamento: ",oFont1,100)
oprint:Say(2180,0405,"AT� O VENCIMENTO, PREFERENCIALMENTE NO ITA� OU BANERJ",oFont5,100)
oprint:Say(2180,1680,"Vencimento",oFont1,100)
oprint:Say(2210,0405,"AP�S O VENCIMENTO, SOMENTE NO ITA� OU BANERJ",oFont5,100)
oprint:Say(2210,1770,_cVENCREA,oFont5,100)

oprint:Box(2260,0000,2340,1670) // Cedente
oprint:Box(2260,1670,2340,2170) // Agencia / Codigo Cedente
oprint:Say(2260,0010,"Cedente",oFont1,100)
oprint:Say(2260,1770,"Ag�ncia/C�digo Cedente",oFont1,100)
//oprint:Say(2300,0060,SM0->M0_NOMECOM,oFont5,100)
oprint:Say(2300,0060,Posicione( "SZQ", 1, xFilial("SZQ")+mv_par01, "ZQ_NOME" ),oFont5,400)
//XAGENCIA := cagencia2+"/"+cconta+"/"+digitaocob
oprint:Say(2300,1770,cagencia+"/"+cConta +"-"+cDigito,oFont5,150)

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
oprint:Say(2380,1770,cCart + "/"+Subst( CB_RN_NN[4], 1, 8 ) + "-"+Subst( CB_RN_NN[4], 9, 1 ),oFont5,100) // Cart./Nosso numero

oprint:Box(2420,0000,2500,0250) // Uso do Banco
oprint:Box(2420,0250,2500,0350) // Cip
oprint:Box(2420,0350,2500,0550) // Carteira
oprint:Box(2420,0550,2500,0850) // Especie Moeda
oprint:Box(2420,1090,2440,1092) // Quantidade
oprint:Box(2470,1090,2500,1092) // Valor
oprint:Box(2499,0850,2501,1470) // Linha para fechar
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
oprint:Say(2460,0375,cCart,oFont5,100) // Carteira
oprint:Say(2460,0590,"R$",oFont5,100) // Especie Moeda
IF SE1->E1_VALOR <> 0
	oprint:Say(2460,1730,Transform(SE1->E1_VALOR,PesqPict("SE1","E1_VALOR")),oFont5,100) // Valor do documento
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
	oprint:Say(2940,1170,"CGC "+Transform(SA1->A1_CGC,"@R 999.999.999-99"),oFont5,100)
Else
	oprint:Say(2940,1170,"CGC "+Transform(SA1->A1_CGC,"@R 99.999.999/9999-99"),oFont5,100)
EndIf
oprint:Say(2960,0010,AllTrim(SA1->A1_END)+" - "+Alltrim(SA1->A1_BAIRRO),oFont5,100)
oprint:Say(2990,0010,Transform(SA1->A1_CEP,"@R 99999-999")+"   "+Alltrim(SA1->A1_MUN)+" - "+SA1->A1_EST,oFont5,100)
oprint:Say(3060,0010,"Sacador/Avalista",oFont1,100)
oprint:Say(3060,1370,"Autentica��o Mec�nica    Ficha de Compensa��o",oFont1,100)
MsBar("INT25",27.5,1,CB_RN_NN[1],oprint,.F.,,.T.,0.025,1.35,,,)
nPag ++
//MSBAR("INT25",14,0.8,CB_RN_NN[1],oPrint,.F.,,.T.,0.013,0.7,,,"A",.F.)
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

STATIC FUNCTION aNumbers( cNumero )

	aDadosBanco := {"341-7",;																	//SA6->A6_COD [1]Numero do Banco
						 "Banco Ita� S.A.",;															// [2]Nome do Banco
						 SUBSTR(MV_PAR04,1,4),;										// [3]Agencia
						 cConta,;	// [4]Conta Corrente
						 cDigito,;	// [5]Digito da conta corrente
						 " "}																			// [6]Codigo da Carteira
	IF EMPTY(SA1->A1_ENDCOB)
		aDatSacado := {AllTrim(SA1->A1_NOME),;											// [1]Razao Social
							AllTrim(SA1->A1_COD)+"-"+SA1->A1_LOJA,;						// [2]Codigo
							AllTrim(SA1->A1_END)+"-"+AllTrim(SA1->A1_BAIRRO),;		// [3]Endereco
							AllTrim(SA1->A1_MUN),;												// [4]Cidade
							SA1->A1_EST,;															// [5]Estado
							SA1->A1_CEP,;															// [6]CEP
							SA1->A1_CGC}															// [7]CGC
	ELSE
		aDatSacado := {AllTrim(SA1->A1_NOME),;											// [1]Razao Social
							AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA,;						// [2]Codigo
							AllTrim(SA1->A1_ENDCOB)+"-"+AllTrim(SA1->A1_BAIRROC),;	// [3]Endereco
							AllTrim(SA1->A1_MUNC),;												// [4]Cidade
							SA1->A1_ESTC,;															// [5]Estado
							SA1->A1_CEPC,;															// [6]CEP
							SA1->A1_CGC}															// [7]CGC
	ENDIF
	_nVlrAbat := SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
	CB_RN_NN  := Ret_cBarra(Subs(aDadosBanco[1],1,3)+"9",aDadosBanco[3],aDadosBanco[4],aDadosBanco[5],AllTrim(E1_NUM),(E1_VALOR-_nVlrAbat),E1_VENCREA, cNumero, cCart )
	aDadosTit := {AllTrim(E1_NUM)+AllTrim(E1_PARCELA),;	// [1] Numero do Titulo
					  E1_EMISSAO,;										// [2] Data da Emissao do Titulo
					  Date(),;											// [3] Data da Emissao do Boleto
					  E1_VENCTO,;										// [4] Data do Vencimento
					  (E1_SALDO - _nVlrAbat),;						// [5] Valor do Titulo
					  CB_RN_NN[3],;									// [6] Nosso Numero (Ver Formula para Calculo)
					  E1_PREFIXO,;										// [7] Prefixo da NF
					  E1_TIPO}											// [8] Tipo do Titulo

RETURN CB_RN_NN

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
��� Funcao    � MODULO10()  � Autor � Flavio Novaes    � Data � 03/02/2005 ���
��������������������������������������������������������������������������Ĵ��
��� Descricao � Impressao de Boleto Bancario do Banco Itau com Codigo de   ���
���           � Barras, Linha Digitavel e Nosso Numero.                    ���
���           � Baseado no Fonte TBOL001 de 01/08/2002 de Raimundo Pereira.���
��������������������������������������������������������������������������Ĵ��
��� Uso       � FINANCEIRO                                                 ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
STATIC FUNCTION Modulo10(cData)
LOCAL L,D,P := 0
LOCAL B     := .F.
L := Len(cData)
B := .T.
D := 0
WHILE L > 0
	P := VAL(SUBSTR(cData, L, 1))
	IF (B)
		P := P * 2
		IF P > 9
			P := P - 9
		ENDIF
	ENDIF
	D := D + P
	L := L - 1
	B := !B
ENDDO
D := 10 - (Mod(D,10))
IF D = 10
	D := 0
ENDIF
RETURN(D)
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
��� Funcao    � MODULO11()  � Autor � Flavio Novaes    � Data � 03/02/2005 ���
��������������������������������������������������������������������������Ĵ��
��� Descricao � Impressao de Boleto Bancario do Banco Itau com Codigo de   ���
���           � Barras, Linha Digitavel e Nosso Numero.                    ���
���           � Baseado no Fonte TBOL001 de 01/08/2002 de Raimundo Pereira.���
��������������������������������������������������������������������������Ĵ��
��� Uso       � FINANCEIRO                                                 ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
STATIC FUNCTION Modulo11(cData)
LOCAL L, D, P := 0
L := LEN(cdata)
D := 0
P := 1
WHILE L > 0
	P := P + 1
	D := D + (VAL(SUBSTR(cData, L, 1)) * P)
	IF P = 9
		P := 1
	ENDIF
	L := L - 1
ENDDO
D := 11 - (mod(D,11))
IF (D == 0 .Or. D == 1 .Or. D == 10 .Or. D == 11)
	D := 1
ENDIF
RETURN(D)
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
��� Funcao    � RET_CBARRA()� Autor � Flavio Novaes    � Data � 03/02/2005 ���
��������������������������������������������������������������������������Ĵ��
��� Descricao � Impressao de Boleto Bancario do Banco Itau com Codigo de   ���
���           � Barras, Linha Digitavel e Nosso Numero.                    ���
���           � Baseado no Fonte TBOL001 de 01/08/2002 de Raimundo Pereira.���
��������������������������������������������������������������������������Ĵ��
��� Uso       � FINANCEIRO                                                 ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
STATIC FUNCTION RET_CBARRA(cBanco,cAgencia,cConta1,cDacCC,cNroDoc,nValor,dVencto, cNumero, cCart )
LOCAL bldocnufinal := STRZERO(VAL(cNroDoc),8)
LOCAL blvalorfinal := STRZERO(int(nValor*100),10)
LOCAL dvnn         := 0
LOCAL dvcb         := 0
LOCAL dv           := 0
LOCAL NN           := ''
LOCAL RN           := ''
LOCAL CB           := ''
LOCAL s            := ''
LOCAL _cfator      := STRZERO(dVencto - ctod("07/10/97"),4)
LOCAL cConta       := cConta1
LOCAL _cNossoNum   := ''
LOCAL _cDac

_cDac := Str( Modulo10( cAgencia + cConta + cCart + cNumero ), 1 )

_cNossoNum := cNumero + _cDac

//-------- Definicao do NOSSO NUMERO

NN   := cCart+SUBSTR(_cNossoNum,1,8)+'-'+SUBSTR(_cNossoNum,9,1)
//	-------- Definicao do CODIGO DE BARRAS
s    := cBanco + _cfator + blvalorfinal + cCart + SUBSTR(_cNossoNum,1,8) + SUBSTR(_cNossoNum,9,1) + cAgencia + cConta + cDacCC + '000'
dvcb := modulo11(s)
CB   := SUBSTR(s, 1, 4) + AllTrim(Str(dvcb)) + SUBSTR(s,5)
//-------- Definicao da LINHA DIGITAVEL (Representacao Numerica)
//	CAMPO 1:
//	AAA = Codigo do banco na Camara de Compensacao
//	  B = Codigo da moeda, sempre 9
//	CCC = Codigo da Carteira de Cobranca
//	 DD = Dois primeiros digitos no nosso numero
//	  X = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
s    := cBanco + cCart + SUBSTR(_cNossoNum,1,2)
dv   := modulo10(s)
RN   := SUBSTR(s, 1, 5) + '.' + SUBSTR(s, 6, 4) + AllTrim(Str(dv)) + '  '
//	CAMPO 2:
//	DDDDDD = Restante do Nosso Numero
//	     E = DAC do campo Agencia/Conta/Carteira/Nosso Numero
//	   FFF = Tres primeiros numeros que identificam a agencia
//	     Y = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
s    := SUBSTR(_cNossoNum,3,6) + SUBSTR(_cNossoNum,9,1) + SUBSTR(cAgencia, 1, 3)
dv   := modulo10(s)
RN   := RN + SUBSTR(s, 1, 5) + '.' + SUBSTR(s, 6, 5) + AllTrim(Str(dv)) + '  '
//	CAMPO 3:
//	     F = Restante do numero que identifica a agencia
//	GGGGGG = Numero da Conta + DAC da mesma
//	   HHH = Zeros (Nao utilizado)
//	     Z = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
s    := SUBSTR(cAgencia, 4, 1) + cConta + cDacCC + '000'
dv   := modulo10(s)
RN   := RN + SUBSTR(s, 1, 5) + '.' + SUBSTR(s, 6, 5) + AllTrim(Str(dv)) + '  '
//	CAMPO 4:
//	     K = DAC do Codigo de Barras
RN   := RN + AllTrim(Str(dvcb)) + '  '
//	CAMPO 5:
//	      UUUU = Fator de Vencimento
//	VVVVVVVVVV = Valor do Titulo
RN   := RN + _cfator + STRZERO(Int(nValor * 100),14-LEN(_cfator))

RETURN({CB,RN,NN, _cNossoNum })

