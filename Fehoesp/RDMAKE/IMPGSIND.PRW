#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
#include "protheus.ch"
User Function IMPGSIND()

// definição variáeis locais
Local oDlg
Local aCA		:= {OemToAnsi("Confirma"),OemToAnsi("Abandona")} // "Confirma", "Abandona"
Local cCadastro := OemToAnsi("Impressao de Guia Sindical")
Local aSays		:= {}, aButtons:={}
Local nOpca 	:= 0

// definição variaveis privadas
Private aReturn 	:= {OemToAnsi('Zebrado'), 1,OemToAnsi('Administracao'), 2, 2, 1, '',1 } // ###
Private nLastKey	:= 0
Private nValorTit 	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01            // Sindicato                             ³
//³ mv_par02            // Natureza                              ³
//³ mv_par03            // Banco                                 ³
//³ mv_par04            // Agencia                               ³
//³ mv_par05            // Conta                                 ³
//³ mv_par06            // Valor                                 ³
//³ mv_par07            // Vencimento                            ³
//³ mv_par08            // Cliente                               ³
//³ mv_par09            // Loja                                  ³
//³ mv_par10            // Mensagem 1                            ³
//³ mv_par11            // Mensagem 2                            ³
//³ mv_par12            // Mensagem 3                            ³
//³ mv_par13            // Mora/Multa                            ³
//³ mv_par14			// Outros Acréscimos                     ³
//³ mv_par15			// Exercicio                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ValidPerg("IMPGUIASIN")

// chama perguntas da rotina
Pergunte("IMPGUIASIN", .T. )

// definição variáveis
CSTRING := "SE1"
TITULO 	:= "GUIA SINDICAL"
tamanho := "P"
CDESC1 	:= "Este programa ira imprimir o Guia Sindical       "
CDESC2 	:= "obedecendo os parametros escolhidos pelo cliente."
CDESC3 	:= ""

nHeight	:= 15
lBold	:= .F.
lUnderLine	:= .F.
lPixel	:= .T.
lPrint	:=.F.

// posiciona entidade sindical
SZQ->(dbSetOrder(1))
SZQ->(dbSeek(xFilial("SZQ")+MV_PAR01))

// posiciona cliente
SE1->(DbSetOrder(1))
SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial()+MV_PAR08+MV_PAR09)) // CGC

// definição das fontes
oFont1:= TFont():New( "Courier New",,08,,.F.,,,,,.f. )
oFont2:= TFont():New( "Courier New",,12,,.t.,,,,,.f. )
oFont3:= TFont():New( "Times New Roman",,18,,.t.,,,,.T.,.f. )
oFont4:= TFont():New( "Courier New",,20,,.t.,,,,,.f. )
oFont5:= TFont():New( "Courier New",,08,,.T.,,,,,.f. )
oFont6:= TFont():New( "Courier New",,10,,.t.,,,,,.f. )

nPag	:=1
nLin	:= 0
lpreview:= .t.

oprint:=TMSPrinter():New("Guia Sindical")

if lPreview
	oPrint:setup()
endif

Private lContinua:= .T.

if nPag<>1	&& Fim de Pagina
	oprint:EndPage()
	oprint:StartPage()
endif

//	título / logotipos cabeçalho da guia
// oprint:SayBitmap( 100,0300,"LOGO104.BMP",300,100 )
oprint:SayBitmap( 100,0300,"LOGO104.BMP",300,100 )  
oprint:Say(100,0690,"GRCSU - Guia de Recolhimento da Contribuicao",oFont6,100)
oprint:Say(150,0690,"Sindical Urbana",oFont6,100)
logosind := "sind_"+mv_par01+".bmp"
oprint:SayBitmap( 050,1850,logosind,300,200 ) // 300 Largura da imagem/ Altura 

// vencimento
oprint:Box(250,1750,350,1950)
oprint:Say(260,1760,"Vencimento",oFont1,100)
oprint:Say(300,1760,Dtoc(mv_par07),oFont1,100)

// exercicio
oprint:Box(250,1950,350,2150)
oprint:Say(260,1960,"Exercicio",oFont1,100)
oprint:Say(300,1960,mv_par15,oFont1,100)

// dados da entidade sindical
oprint:Say(300,0300,"Dados da Entidade Sindical",oFont2,100)
oprint:Box(350,0300,450,1650)
oprint:Say(360,0300,"Nome da Entidade",oFont1,100)
oprint:Say(400,0300,AllTrim(SZQ->ZQ_NOME),oFont1,100)
oprint:Box(350,1650,450,2150)
oprint:Say(360,1660,"Codigo da Entidade Sindical",oFont1,100)
oprint:Say(400,1660,SZQ->ZQ_ENTSIN2,oFont1,100)

// endereço
oprint:Box(450,0300,550,1150)
oprint:Say(460,0300,"Endereco",oFont1,100)
oprint:Say(500,0300,SubStr(SZQ->ZQ_END,1,At(",",SZQ->ZQ_END)-1),oFont1,100)

// número
oprint:Box(450,1150,550,1400)
oprint:Say(460,1150,"Numero",oFont1,100)
oprint:Say(500,1150,SubStr(SZQ->ZQ_END,At(",",SZQ->ZQ_END)+1,10),oFont1,100)
// complemento
oprint:Box(450,1400,550,1740)
oprint:Say(460,1410,"Complemento",oFont1,100)
oprint:Say(500,1410,"",oFont1,100)
// cnpj
oprint:Box(450,1740,550,2150)
oprint:Say(460,1750,"CNPJ da Entidade",oFont1,100)
oprint:Say(500,1750,Transform(SZQ->ZQ_CGC,"@R 99.999.999/9999-99"),oFont1,100)
// bairro/distrito
oprint:Box(550,0300,650,1150)
oprint:Say(560,0310,"Bairro/Distrito",oFont1,100)
oprint:Say(600,0310,SZQ->ZQ_BAIRRO,oFont1,100)
// cep
oprint:Box(550,1150,650,1350)
oprint:Say(560,1160,"CEP",oFont1,100)
oprint:Say(600,1160,SZQ->ZQ_CEP,oFont1,100)
// cidade/municipio
oprint:Box(550,1350,650,2050)
oprint:Say(560,1360,"Cidade/Municipio",oFont1,100)
oprint:Say(600,1360,SZQ->ZQ_MUN,oFont1,100)
// UF
oprint:Box(550,2050,650,2150)
oprint:Say(560,2060,"UF",oFont1,100)
oprint:Say(600,2060,SZQ->ZQ_EST,oFont1,100)

// dados do contribuinte
oprint:Say(700,0300,"Dados do Contribuinte",oFont2,100)

// nome
oprint:Box(750,0300,0850,1650)
oprint:Say(760,0310,"Nome/Razao Social/Denominacao Social",oFont1,100)
oprint:Say(0800,0310,SA1->A1_NOME,oFont1,100)

// cpf/cnpj
oprint:Box(750,1650,0850,2150)
oprint:Say(760,1660,"CPF/CNPJ/Codigo Contribuinte",oFont1,100)
oprint:Say(0800,1660,Transform(SA1->A1_CGC,"@R 99.999.999/9999-99"),oFont1,100)

// endereço
oprint:Box(0850,0300,0950,1450)
oprint:Say(0860,0310,"Endereco",oFont1,100)
oprint:Say(0900,0310,SubStr(SA1->A1_END,1,At(",",SA1->A1_END)-1),oFont1,100) // AllTrim(SubStr(SM0->M0_ENDENT,1,At(SM0->M0_ENDENT,"N")-1))

// número
oprint:Box(0850,1450,0950,1750)
oprint:Say(0860,1460,"Numero",oFont1,100)
oprint:Say(0900,1460,Right(AllTrim(SA1->A1_END),3),oFont1,100)

// complemento
oprint:Box(0850,1750,0950,2150)
oprint:Say(0860,1760,"Complemento",oFont1,100)
oprint:Say(0900,1760,SA1->A1_COMPLEM,oFont1,100)

// cep
oprint:Box(0950,0300,1050,0650)
oprint:Say(0960,0310,"CEP",oFont1,100)
oprint:Say(1000,0310,Transform(SA1->A1_CEP,"@R 99999-999"),oFont1,100)

// bairro/distrito
oprint:Box(0950,0650,1050,1200)
oprint:Say(0960,0660,"Bairro/Distrito",oFont1,100)
oprint:Say(1000,0660,SA1->A1_BAIRRO,oFont1,100)

// cidade/municipio
oprint:Box(0950,1200,1050,1700)
oprint:Say(0960,1210,"Cidade/Municipio",oFont1,100)
oprint:Say(1000,1210,SA1->A1_MUN,oFont1,100)

// UF
oprint:Box(0950,1700,1050,1800)
oprint:Say(0960,1710,"UF",oFont1,100)
oprint:Say(1000,1710,SA1->A1_EST,oFont1,100)

// Atividade
oprint:Box(0950,1800,1050,2150)
oprint:Say(0960,1810,"Codigo da Atividade",oFont1,100)
oprint:Say(1000,1810,Iif(Empty(SA1->A1_ATIVIDA),"861",SA1->A1_ATIVIDA),oFont1,100) // A1_DPMATV // A1_SATIV2

// dados de referência da contribuição / dados da contribuição
oprint:Say(1100,0300,"Dados de Referencia da Contribuicao",oFont2,100)

// categoria
oprint:Box(1150,0300,1250,1700)
oprint:Say(1160,0310,"Categoria",oFont1,100)
oprint:Say(1200,0310,"[X] Patronal/Empregador  [ ]Empregados   [ ]Prof. Liberal  [ ]Autônomos",oFont1,100) // A1_DPMATV // A1_SATIV2

// valor documento
oprint:Box(1150,1700,1250,2150)
oprint:Say(1160,1710,"(=) Valor do Documento",oFont1,100)
// oprint:Say(1400,1710,Replicate("*",TamSX3("E1_SALDO")[1]-Len(AllTrim(Str(SE1->E1_SALDO))))+AllTrim(Transform(Str(SE1->E1_SALDO),PesqPict("SE1","E1_SALDO"))),oFont1,100)
if mv_par06 <> 0
oprint:Say(1200,1710,Transform(mv_par06,PesqPict("SE1","E1_VALOR")),oFont1,100)
endif
// capital social empresa
oprint:Box(1250,0300,1350,0900)
oprint:Say(1260,0310,"Capital Social - Empresa",oFont1,100)
//oprint:Say(1500,0310,Replicate("*",TamSX3("A1_CAPITAL")[1]-Len(AllTrim(Str(SA1->A1_CAPITAL))))+AllTrim(Transform(Str(SA1->A1_CAPITAL),PesqPict("SA1","A1_CAPITAL"))),oFont1,100)
oprint:Say(1300,0310,Transform(SA1->A1_CAPITAL,PesqPict("SA1","A1_CAPITAL")),oFont1,100)

// número empregados
oprint:Box(1250,0900,1350,1700)
oprint:Say(1260,0910,"No. Empregados Contribuintes",oFont1,100)
oprint:Say(1300,0910,"",oFont1,100)

// valor documento
oprint:Box(1250,1700,1350,2150)
oprint:Say(1260,1710,"(-) Desconto/Abatimentos",oFont1,100)
oprint:Say(1300,1710,"",oFont1,100)

// capital social - estabelecimento
oprint:Box(1350,0300,1450,0900)
oprint:Say(1360,0310,"Capital Social - Estabelecimento",oFont1,100)
oprint:Say(1400,0310,"",oFont1,100)

// total remuneração
oprint:Box(1350,0900,1450,1700)
oprint:Say(1360,0910,"Total Remuneracao - Contribuinte",oFont1,100)
oprint:Say(1400,0910,"",oFont1,100)

// outras deduções
oprint:Box(1350,1700,1450,2150)
oprint:Say(1360,1710,"(-) Outras Deducoes",oFont1,100)
oprint:Say(1400,1710,"",oFont1,100)

oprint:Box(1450,0300,1750,2150)
oprint:Say(1550,0310,"Mensagem Destinada ao Contibuinte",oFont1,100)

// total empregados - estabelecimento
oprint:Box(1450,0900,1550,1700)
oprint:Say(1460,0910,"Total Empregados - Estabelecimento",oFont1,100)
oprint:Say(1500,0910,"",oFont1,100)

// mora/multa
oprint:Box(1450,1700,1550,2150)
oprint:Say(1460,1710,"(+) Mora/Multa",oFont1,100)
if mv_par13<>0
oprint:Say(1500,1710,Transform(mv_par13,PesqPicT("SE1","E1_VALOR")),oFont1,100)
endif
// outros acréscimos
oprint:Box(1550,1700,1650,2150)
oprint:Say(1560,1710,"(+) Outros Acrescimos",oFont1,100) 
if mv_par14<>0
oprint:Say(1600,1710,Transform(mv_par14,PesqPict("SE1","E1_VALOR")),oFont1,100)
           endif
// valor cobrado
oprint:Box(1650,1700,1750,2150)
oprint:Say(1660,1710,"(=) Valor Cobrado",oFont1,100)
_nX := mv_par06+MV_PAR13+MV_PAR14                     
if _nx<>0
oprint:Say(1700,1710,Transform(_nX,PesqPict("SE1","E1_VALOR")),oFont1,100)
      endif
// cálculo do DV Geral
Modulo  := 11                                          
cCNAE	:= "861"                               
//cCodCed	:= "S-86276"
cCodCed	:= alltrim(SZQ->ZQ_ENTSIN2)
          //         1         2         3         4
          //1234567890123456789012345678901234567890123
strmult := "4329876543298765432987654329876543298765432"
_cFatVenc := STRZERO((mv_par07 - CTOD("07/10/1997")),4) 
nValorTit := mv_par06 
cValor  :=  Strzero(100 * (nValorTit),10)
sBarra  := mv_par03+"9"+_cFatVenc+cValor+"97"+Right(cCodCed,5)+Left(cCNAE,1)+"1"+"77"+Left(SA1->A1_CGC,12)+Right(cCNAE,2)
BaseDiv := 0
For xx := 1 To 43
	BaseDiv := BaseDiv + Val (Subs (sBarra, xx, 1)) * Val (Subs (strmult, xx, 1))
Next xx

resto  := BaseDiv % Modulo	
resto := Str(Iif(resto == 0 .Or. resto == 1,1,Modulo - resto),1)	// Str(Modulo - resto,1) // 
sBarra := MV_PAR03+'9'+resto+_cFatVenc+cValor+"97"+Right(cCodCed,5)+Left(cCNAE,1)+"1"+"77"+Left(SA1->A1_CGC,12)+Right(cCNAE,2)
Barra  := sBarra                                                                           

// Calculo da linha digitável
// primeiro grupo
// sDigit1	:= mv_par03+"9"+"97"+Left(Right(cCodCed,5),3) // banco + moeda + fixo + três primeiras posição do cedente
sDigit1	:= SubStr(sBarra,1,4)+SubStr(sBarra,20,5)
sMult	:= "212121212"
nSoma	:= 0
For i:= 1 to Len(sDigit1)
	nMult := Val(SubStr(sDigit1,i,1)) * Val(SubStr(sMult,i,1))	
	If nMult > 9 // dois digito
		sSoma := Str(nMult,2)
		For j := 1 to Len(sSoma) 
			nSoma += Val(SubStr(sSoma,j,1))
		Next j
	Else
		nSoma += nMult 
	EndIf             
Next i     

resto2 := (nSoma) % 10  
resto2 := Iif(resto2 == 0,0,10 - resto2) // Iif(resto2 == 0 .Or. resto2 == 1 .or. resto2 == 10,1,resto2)
// nSoma := 10 - resto2

sDigit1	+= Str(resto2,1)	// Str(nSoma,1)

// segundo grupo                                          /
// sDigit2	:= Right(cCodCed,2) + Left(cCNAE,1) + "1" + "77" + Left(SZQ->ZQ_CGC,4) // duas últimas posições do cedente + 1 posição do CNAE + sindicato + fixo + quatro primeiras posição do CNPJ 
sDigit2	:= SubStr(sBarra,25,10)
sMult	:= "1212121212"
nSoma	:= 0
For i:= 1 to Len(sDigit2)
	nMult := Val(SubStr(sDigit2,i,1)) * Val(SubStr(sMult,i,1))	
	If nMult > 9 // dois digito
		sSoma := Str(nMult,2)
		For j := 1 to Len(sSoma) 
			nSoma += Val(SubStr(sSoma,j,1))
		Next j
	Else
		nSoma += nMult
	EndIf             
Next i     

resto2 := (nSoma) % 10
resto2 := Iif(resto2 == 0,0,10-resto2)
//nSoma := 10 - resto2

sDigit2	+= Str(resto2,1)        

// terceiro grupo
// sDigit3	:= SubStr(SZQ->ZQ_CGC,5,8) + Right(cCNAE,2) // últimas posições do CNPJ + duas últimas posições do CNAE
sDigit3	:= SubStr(sBarra,35,10)
sMult	:= "1212121212"
nSoma	:= 0
For i:= 1 to Len(sDigit3)
	nMult := Val(SubStr(sDigit3,i,1)) * Val(SubStr(sMult,i,1))	
	If nMult > 9 // dois digito
		sSoma := Str(nMult,2)
		For j := 1 to Len(sSoma) 
			nSoma += Val(SubStr(sSoma,j,1))
		Next j
	Else
		nSoma += nMult
	EndIf             
Next i     

resto2 := (nSoma) % 10
resto2 := Iif(resto2 == 0,0,10-resto2)
//nSoma := 10 - resto2
sDigit3	+= Str(resto2,1) 

sDigi1    := Subs (sDigit1, 1, 5) + "." + Subs (sdigit1, 6, 5) + " "
sDigi2    := Subs (sDigit2, 1, 5) + "." + Subs (sdigit2, 6, 6) + " "
sDigi3    := Subs (sDigit3, 1, 5) + "." + Subs (sdigit3, 6, 6) + " "

sDigit := sDigi1 + sDigi2 + sDigi3 + " " + resto +" " + _cFatVenc + cValor

_cObs1 := "" //Formula("001")
_cObs2 := "" //Formula("002")
_cObs3 := ""//Formula("003")
_cObs4 := ""//Formula("004")
_cObs5 := ""//Formula("005")

_cEmissao := STRZERO(DAY(dDataBase),2)+"/" + STRZERO(MONTH(dDataBase),2) +"/"+ STRZERO(YEAR(dDataBase),4)
_cVENCREA  := STRZERO(DAY(mv_par07),2)+"/" + STRZERO(MONTH(mv_par07),2) +"/"+ STRZERO(YEAR(mv_par07),4)

// Calculo do numero bancario + digito e valor do juros
nParcela := "1" // StrZero(At(SE1->E1_PARCELA,"ABCDEFGHIJKLMN"),3)
// if empty(se1->e1_confed) .OR. ALLTRIM(SE1->E1_CONFED)=="."
	 CQUERY := "SELECT MAX(SUBSTRING(Z9_TITULO,5,9)) AS TITULO  FROM SZ9010 WHERE LEFT(Z9_TITULO,4)='6000' AND D_E_L_E_T_='' AND (SUBSTRING(Z9_TITULO,13,1)<>'' AND SUBSTRING(Z9_TITULO,13,1)<='9' )"
//CQUERY := "SELECT MAX(Z9_TITULO) AS TITULO  FROM SZ9010 WHERE Z9_BANCO = '"+mv_par03+"' AND D_E_L_E_T_='' " // LEFT(Z9_TITULO,1)='G' AND
TCQUERY cQuery NEW ALIAS "TRB"

If TRB->(Eof()) 
	cnumtit  := "0000000000001"	// "G000000000001"
Else
	cnumtit  := "6000"+strzero(val(trb->titulo)+1,9)	// "G"+strzero(val(Right(trb->titulo,12))+1,12)
EndIf
CNUMTIT := SA1->A1_CGC
IF EMPTY(SA1->A1_CAPITAL) .OR. SA1->A1_CAPCENT='S' 
	ALERT("VERIFIQUE O CAPITAL SOCIAL")
ENDIF 
dbselectarea("trb")
dbclosearea("trb")
	
dbselectarea("sz9")
RECLOCK("SZ9",.T.) 
SZ9->Z9_FILIAL := xFilial("SZ9")
SZ9->Z9_TITULO := cnumtit
SZ9->Z9_CGC    := SA1->A1_CGC
SZ9->Z9_VENCTO := mv_par07
SZ9->Z9_VREAL  := DataValida(mv_par07)
SZ9->Z9_VALOR  := mv_par06
SZ9->Z9_PARCELA:= "1"
//SZ9->Z9_BANCO  := mv_par03//"104"
SZ9->Z9_NATUR 	:= mv_par02
SZ9->Z9_EMISSAO := dDataBase
SZ9->Z9_SINDIC	:= MV_PAR01
SZ9->Z9_BASE	:= SA1->A1_BASE
SZ9->Z9_ANO		:= mv_par15
MSUNLOCK()
	
_cObs1 := MV_PAR10
_cObs2 := MV_PAR11
_cObs3 := MV_PAR12
_cObs4 := ""//Formula("004")
_cObs5 := ""//Formula("005")

// impressão da linha digitável 
oprint:Box(1750,0300,0850,2150)
oprint:Say(1770,0320,"104-0",oFont2,100)
oprint:Say(1770,0450,"|",oFont2,100)
oprint:Say(1770,0500,sDigit,oFont2,100)

oprint:Box(1850,0300,1950,0750) // divisao entre CEF e no. banco
oprint:Say(1870,0320,"Codigo do Cedente",oFont1,100)
oprint:Say(1900,0320,SZQ->ZQ_ENTSIN2,oFont1,100)

_cNosNum := cnumtit// cCart+ "00" + cnumtit+"-"+VarDac

oprint:Box(1850,0750,1950,1200) // divisao entre CEF e no. banco
oprint:Say(1870,0770,"Nosso Numero",oFont1,100)
oprint:Say(1900,0770,Left(SA1->A1_CGC,12),oFont1,100) // _cNosNum

oprint:Box(1850,1200,1950,1650) // divisao entre CEF e no. banco
oprint:Say(1870,1220,"Valor do Documento",oFont1,100)   
if mv_par06<>0
oprint:Say(1900,1220,Transform(mv_par06,PesqPict("SE1","E1_VALOR")),oFont1,100)
endif
oprint:Box(1850,1650,1950,1950) // divisao entre CEF e no. banco
oprint:Say(1870,1670,"Data Vencimento",oFont1,100)
oprint:Say(1900,1670,Dtoc(mv_par07),oFont1,100)

oprint:Box(1850,1950,1950,2150) // divisao entre CEF e no. banco
oprint:Say(1870,1970,"Exercicio",oFont1,100)
oprint:Say(1900,1970,mv_par15,oFont1,100)

oprint:Say(1950,0320,"1a Via - Contribuinte",oFont2,100)
oprint:Say(1950,1220,"| Autenticacao Mecanica",oFont2,100)
// oprint:Say(1980,0320,Replicate("-",0400),oFont2,100)
oprint:Line(2040,0320,2040,2150)


oprint:SayBitmap( 2050,0300,"LOGO104.BMP",420,100 )  

oprint:Say(2103,0730,"104-0",oFont6,100)
oprint:Say(2100,0920,sDigit,oFont6,100)

oprint:Box(2100,0728,2180,0731) // divisao entre CEF e no. banco
oprint:Box(2100,0910,2180,0913) // divisao entre no. banco e sacado

oprint:Box(2180,0300,2260,1670) // Local Pagamento
oprint:Box(2180,1670,2260,2150) // Vencimento

oprint:Say(2180,0310,"Local de Pagamento: ",oFont1,100)
oprint:Say(2180,1680,"Vencimento",oFont1,100)

oprint:Say(2210,0305,"Casas Lotericas, Ag. da Caixa, Rede Bancarias e Internet.",oFont5,100) // PREFERENCIALMENTE NAS CASAS LOTERICAS E AGENCIAS DA CAIXA
oprint:Say(2210,1680,_cVENCREA,oFont5,100)

oprint:Box(2260,0300,2340,1670) // Cedente
oprint:Box(2260,1670,2340,2150) // Agencia / Codigo Cedente
oprint:Say(2260,0310,"Cedente",oFont1,100)
oprint:Say(2260,1680,"Agencia/Codigo Cedente",oFont1,100)
oprint:Say(2300,0310,Posicione( "SZQ", 1, xFilial("SZQ")+mv_par01, "ZQ_NOME" ),oFont5,400)
oprint:Say(2300,1680, mv_par04 + "/" + SZQ->ZQ_ENTSIN2,oFont5,100) // cAgencia + "/" + cConta + "-" + cDigito

oprint:Box(2340,0300,2420,0700) // Data do Documento
oprint:Box(2340,0700,2420,0970) // Numero do Documento
oprint:Box(2340,0970,2420,1220) // Especie Doc.
oprint:Box(2340,1220,2420,1350) // Aceite
oprint:Box(2340,1350,2420,1670) // Dia Processamento
oprint:Box(2340,1670,2420,2150) // Cart./Nosso numero

oprint:Say(2340,0305,"Data do Documento",oFont1,100) // Data do Documento
oprint:Say(2340,0705,"No.Documento",oFont1,100) // Numero do Documento
oprint:Say(2340,0975,"Especie Doc.",oFont1,100) // Especie Doc.
oprint:Say(2340,1225,"Aceite",oFont1,100) // Aceite
oprint:Say(2340,1355,"Data Processamento",oFont1,100) // Dia Processamento
oprint:Say(2340,1675,"Nosso Numero",oFont1,100) // Cart./Nosso numero

oprint:Say(2380,0310,_cEmissao,oFont5,100) // Data do Documento
oprint:Say(2380,0710,Left(SA1->A1_CGC,12),oFont5,100) // Numero do Documento // SE1->E1_PREFIXO+SE1->E1_NUM
oprint:Say(2380,0980,"GRCSU",oFont5,100) // Especie Doc.
oprint:Say(2380,1230," ",oFont5,100) // Aceite
oprint:Say(2380,1380,Dtoc(dDataBase),oFont5,100) // Dia Processamento
oprint:Say(2380,1670,Left(SA1->A1_CGC,12),oFont5,100) // Cart./Nosso numero _cNosNum

oprint:Box(2420,0300,2500,0650) // Uso do Banco
//oprint:Box(2420,0550,2500,0650) // Cip
oprint:Box(2420,0650,2500,0850) // Carteira
oprint:Box(2420,0850,2500,1150) // Especie Moeda
oprint:Box(2420,1390,2440,1392) // Quantidade
oprint:Box(2470,1390,2500,1392) // Valor
oprint:Say(2440,1384,"X",oFont5,100) // Sinal de X
oprint:Box(2420,1670,2500,2150) // Valor do Documento

oprint:Say(2420,0305,"Uso Banco",oFont1,100) // Uso do Banco
//oprint:Say(2420,0555,"Cip",oFont1,100) // Cip
oprint:Say(2420,0655,"Carteira",oFont1,100) // Carteira
oprint:Say(2420,0855,"Especie Moeda",oFont1,100) // Especie Moeda
oprint:Say(2420,1155,"Quantidade",oFont1,100) // Quantidade

oprint:Say(2420,1420,"Valor",oFont1,100) // Valor
oprint:Say(2420,1690,"1 (=) Valor do Documento",oFont1,100) // Valor do documento

oprint:Say(2460,0325,"EXERC ("+mv_par15+")",oFont5,100) // Uso do Banco
oprint:Say(2460,0565,"   ",oFont5,100) // Cip
oprint:Say(2460,0675,"SIND",oFont5,100) // Carteira
oprint:Say(2460,0890,"R$  ",oFont5,100) // Especie Moeda
IF nValorTit <> 0
	oprint:Say(2460,1730,Transform(nValorTit,PesqPict("SE1","E1_VALOR")),oFont5,100) // Valor do documento
ENDIF
oprint:Box(2500,1670,2580,2150) // (-)Desconto/Abatimento
oprint:Box(2500,0300,2900,1670) // Instrucoes para o banco

oprint:Say(2500,1690,"2 (-) Desconto/Abatimento",oFont1,100) // (-)Desconto/Abatimento
oprint:Say(2500,0330,"Instrucoes de Responsabilidade do Cedente",oFont1,100) // Instrucoes para o banco

oprint:Box(2580,1670,2660,2150) // (-)Outras Deduções

oprint:Say(2570,0330,"** Valores Expressos em R$",oFont1,100)
oprint:Say(2580,1690,"3 (-) Outras Deducoes",oFont1,100) // (-)Outras Deduções

oprint:Say(2630,0330,_cObs1,oFont5,100)

oprint:Box(2660,1670,2740,2150) // (-)Mora/Multa

oprint:Say(2660,1690,"4 (+) Mora/Multa",oFont1,100) // (-)Mora/Multa
if mv_par13<>0
oprint:Say(2700,1690,Transform(mv_par13,PesqPicT("SE1","E1_VALOR")),oFont1,100)
          endif
oprint:Say(2660,0330,_cObs2,oFont5,100)
oprint:Say(2690,0330,_cObs3,oFont5,100)
oprint:Say(2720,0330,_cObs4,oFont5,100)  
//oprint:Say(2750,0330,"APÓS "+Dtoc(SE1->E1_VENCREA)+" IMPRIMIR NOVA GUIA NO SITE:",oFont5,100)  
//oprint:Say(2780,0330,"www.fehoesp.com.br",oFont5,100)  
//oprint:Say(2840,0330,"NA OPÇÃO DE EXTRATO/BOLETOS",oFont5,100)  

oprint:Box(2740,1670,2820,2150) // (-)Outros Acrescimos

oprint:Say(2740,1690,"5 (+)Outros Acrescimos",oFont1,100) // (-)Outros Acrescimos
if mv_par14<>0
oprint:Say(2780,1710,Transform(mv_par14,PesqPicT("SE1","E1_VALOR")),oFont5,100)
           endif
oprint:Box(2820,1670,2900,2150) // (=)Valor Cobrado

oprint:Say(2820,1690,"6 (=) Valor Cobrado",oFont1,100) // (=)Valor Cobrado 
_nX := mv_par06+MV_PAR13+MV_PAR14
if _nx<>0
oprint:Say(2860,1710,Transform(_nX,PesqPict("SE1","E1_VALOR")),oFont1,100)
      endif
oprint:Box(2900,0300,3060,2150) // Sacado 1970
oprint:Say(2910,0310,"Sacado ",oFont1,100)
oprint:Say(2940,0310,SA1->A1_NOME,oFont5,100)
If Len(Alltrim(SA1->A1_CGC))==11
	oprint:Say(2940,1470,"CNPJ "+Transform(SA1->A1_CGC,"@R 999.999.999-99"),oFont5,100)
Else
	oprint:Say(2940,1470,"CNPJ "+Transform(SA1->A1_CGC,"@R 99.999.999/9999-99"),oFont5,100)
EndIf
oprint:Say(2970,0310,AllTrim(SA1->A1_END)+" - "+Alltrim(SA1->A1_BAIRRO),oFont5,100)
oprint:Say(3000,0310,Transform(SA1->A1_CEP,"@R 99999-999")+"   "+Alltrim(SA1->A1_MUN)+" - "+SA1->A1_EST,oFont5,100)
oprint:Say(3030,0310,"Sacador/Avalista",oFont1,100)
oprint:Say(3060,0310,"Codigo de Barras",oFont1,100)
oprint:Say(3060,1370,"Ficha de Compensacao/Autenticacao Mecanica",oFont1,100)

MsBar("INT25",26.5,2.5,Barra,oprint,.F.,,.T.,0.025,1.35,,,)

// oprint:Say(3070,0320,Replicate("_",1530),oFont2,100)

//oprint:Line(3200,0320,3200,2150)



nPag ++
dbSelectArea("SE1")

If lPreview
	oPrint:Preview()
Else
	oPrint:Print()
Endif

MS_FLUSH()

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ValidPerg  ºAutor  ³Microsiga           º Data ³  11/05/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Perguntas da rotina.                                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ fehoesp                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg(cPerg)

local j,i
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3
aAdd(aRegs,{cPerg,"01","Sindicato          ?","","","mv_ch1","C",02,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SZQ"})
aAdd(aRegs,{cPerg,"02","Natureza           ?","","","mv_ch2","C",03,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SED"})
aAdd(aRegs,{cPerg,"03","Banco              ?","","","mv_ch3","C",03,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SA6"})
aAdd(aRegs,{cPerg,"04","Agencia            ?","","","mv_ch4","C",05,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Conta              ?","","","mv_ch5","C",10,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Valor	           ?","","","mv_ch6","N",17,2,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Vencimento         ?","","","mv_ch7","D",08,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","Cliente            ?","","","mv_ch8","C",06,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
aAdd(aRegs,{cPerg,"09","Loja               ?","","","mv_ch9","C",02,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"10","Mensagem 1         ?","","","mv_cha","C",65,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11","Mensagem 2         ?","","","mv_chb","C",65,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12","Mensagem 3         ?","","","mv_chc","C",65,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","Mora/Multa         ?","","","mv_chd","N",12,2,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Outros Acréscimos  ?","","","mv_che","N",12,2,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15","Exercicio          ?","","","mv_chf","C",05,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i := 1 to Len(aRegs)
	if !dbSeek(cPerg + aRegs[i,2])
		RecLock("SX1",.t.)
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
