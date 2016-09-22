#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/10/00
#IFNDEF WINDOWS
 #DEFINE  PSAY SAY
#ENDIF

User Function CMBOLET(WPAR1,WPAR2)        // incluido pelo assistente de conversao do AP5 IDE em 16/10/00

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Declaracao de variaveis utilizadas no programa atraves da funcao    ≥
//≥ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ≥
//≥ identificando as variaveis publicas do sistema utilizadas no codigo ≥
//≥ Incluido pelo assistente de conversao do AP5 IDE                    ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

SetPrvt("TITULO,CDESC,WNREL,AORD,ARETURN,CSTRING,_BlocoBar")
SetPrvt("CPERG,NTAMANHO,NLASTKEY,NLIN,LEND,AROTOP")
SetPrvt("LIMPRT,LIMITE,CBCONT,NQUANTITEM,CDESCRI,NLIMITE")
SetPrvt("NQUANT,NOMEPROG,NTIPO,CQTD,CBTXT,ESC")
SetPrvt("NULL,cPRINTER,HEIGHT,SMALL_BAR,WIDE_BAR,DPL")
SetPrvt("NB,WB,NS,WS,_TPBAR,CHAR25,cPictBanc")
SetPrvt("START,_FIM,CHARS,CHAR,_CFIXO1,_CFIXO2")
SetPrvt("_CFIXO3,_cFixo4,_MSGIMP,_RESP,MV_PAR15,XCOMPLEM")
SetPrvt("_REGVCTO,_VCTBUSCA,_TPOBUSCA,_CHVBUSCA,_VALBOL")
SetPrvt("_BARCOD,NSOMAGER,NI,CCALCDV")
SetPrvt("_CBLOCO,NSOMA1,NSOMA2,NSOMA3,_FIXVAR,_NRES")
SetPrvt("CSOMA1,CSOMA2,CSOMA3,NSOMANN,_VARFIX")
SetPrvt("_CODE,_CBAR,_NX,_NNRO,_CBARX,_NY")
SetPrvt("I,LETTER,_JRS,_DacBco,_NomBco,_NomBc2")
SetPrvt("_MESAGE,_SALIAS,AREGS,J,_cEspDoc,_cCartDoc")

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ CMBOLET  ∫ Autor ≥ Roberto Oliveira       ∫ Data ≥ 16/10/00∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕπ±±
±±∫DescriáÑo ≥ Emiss∆o de Boletos de Cordeiro Maqs.Ferr.Ltda              ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Observacao≥ Somente para Laser nao default Windows                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ

Parametros:
                    
Do Prefixo          MV_PAR01  C  3
Ate o Prefixo       MV_PAR02  C  3
Do Numero           MV_PAR03  C  6
Ate o Numero        MV_PAR04  C  6
Da Emissao          MV_PAR05  D  8
Ate a Emissao       MV_PAR06  D  8
Do Vencimento       MV_PAR07  D  8
Ate o Vencimento    MV_PAR08  D  8
Do Cliente          MV_PAR09  C  6
Da Loja             MV_PAR10  C  2
Ate o Cliente       MV_PAR11  C  6
Ate a Loja          MV_PAR12  C  2
Quanto a Impressao  mv_par13  N  1    1-1ra.Impress∆o 2-Reimpress∆o
// Cobranáa a Imprimir mv_par14  N  1    1-Assinaturas   2-Cobranáas   3-Ambos
// Vlr.Parcela 1       mv_par15  N  1    1-Parcela Unica 2-Parcela 1
/*/
DbSelectArea("SA6")       
DbSetOrder(1)

DbSelectArea("SA1")
DbSetOrder(1)


Titulo  := OemToAnsi("Boletos Banc†rios")
cDesc   := OemToAnsi("Este programa ira imprimir Boletos Banc†rios")

wnrel    := "CMBOLET"
aOrd     := {}
aReturn  := { "Zebrado", 1,"Administracao", 2, 2, 2, "",2 }
cString  := "SE1"
cPerg    := "CMBOL"
nTamanho := "G"
nLastKey := 0
nLin     := 0
lEnd	 := .F.
aRotOP	 := {}
lImpRt	 := .F.  // Flag para impressao do Roteiro de Operacao
limite	 := 80
ValidPerg()
Pergunte(cPerg,.f.)
nLastKey:=0
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc,"","",.F.,"",.F.,"",.F.)
nLastKey:=IIf(LastKey()==27,27,nLastKey)
If nLastKey == 27
   Return
Endif

SetDefault(aReturn,cString)

If Pcount() > 0
	MV_PAR01 := MV_PAR02 := WPAR2
	MV_PAR03 := MV_PAR04 := WPAR1
	MV_PAR05 := DDATABASE-740
	MV_PAR06 := DDATABASE+740
	MV_PAR07 := DDATABASE-740
	MV_PAR08 := DDATABASE+740
	MV_PAR09 := "      "
	MV_PAR10 := "  "
	MV_PAR11 := "ZZZZZZ"
	MV_PAR12 := "ZZ"
	MV_PAR13 := 0
Else
	MV_PAR13 := MV_PAR13 - 1
Endif

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Configura impressora com comandos PCL (Driver)          ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
//@00,000 PSAY aValImp(Limite)

RptStatus( {|| Imprime() }, Titulo )// Substituido pelo assistente de conversao do AP5 IDE em 16/10/00 ==> RptStatus( {|| Execute(Imprime) }, Titulo )
Return



// Substituido pelo assistente de conversao do AP5 IDE em 16/10/00 ==> Function Imprime
Static Function Imprime()

CbCont	   := ""
nQuantItem := 0
cDescri    := ""
nlimite    := 150 //80
nQuant	   := 1
nomeprog   := "OPSIS"
nTipo	   := 18
cQtd	   := ""

cbtxt	 := SPACE(10)
cbcont	 := 0

* Preparacao Inicio

esc := CHR(27)
null := ""
cPRINTER   := "L"
height    := 3.0 && 2.5  && 2

small_bar := 3.5 //4.2                               && number of points per bar  3
wide_bar := ROUND(small_bar * 2.25,0)          && 2.25 x small_bar
dpl := 50                                      && dots per line 300dpi/6lpi = 50dpl


nb := esc+"*c"+TRANSFORM(small_bar,'99')+"a"+Alltrim(STR(height*dpl))+"b0P"+esc+"*p+"+TRANSFORM(small_bar,'99')+"X"
// Barra estreita
wb := esc+"*c"+TRANSFORM(wide_bar,'99')+"a"+Alltrim(STR(height*dpl))+"b0P"+esc+"*p+"+TRANSFORM(wide_bar,'99')+"X"
// Barra larga
ns := esc+"*p+"+TRANSFORM(small_bar,'99')+"X"
// Espaco estreito
ws := esc+"*p+"+TRANSFORM(wide_bar,'99')+"X"
// Espaco largo

_TpBar := "25"
If _TpBar == "25"
   // Representacao binaria dos numeros 1-Barras/Espacos largas (os)
   // 0-Barras/Espacos estreitas (os)
   char25 := {}
   AADD(char25,"10001")       && "1"
   AADD(char25,"01001")       && "2"
   AADD(char25,"11000")       && "3"
   AADD(char25,"00101")       && "4"
   AADD(char25,"10100")       && "5"
   AADD(char25,"01100")       && "6"
   AADD(char25,"00011")       && "7"
   AADD(char25,"10010")       && "8"
   AADD(char25,"01010")       && "9"
   AADD(char25,"00110")       && "0"
EndIf
If _TpBar == "39"
   // O Codigo tipo 39 NAO pode ser usados para boleto - deixo aqui como
   // se faz para referencia futura.

   *** adjust cusor position to start at top of line and return to bottom of line
   start := esc+"*p-50Y"
   _Fim := esc+"*p+50Y"
   chars := "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ-. *$/+%"
   char := {}
   AADD(char,wb+ns+nb+ws+nb+ns+nb+ns+wb)       && "1"
   AADD(char,nb+ns+wb+ws+nb+ns+nb+ns+wb)       && "2"
   AADD(char,wb+ns+wb+ws+nb+ns+nb+ns+nb)       && "3"
   AADD(char,nb+ns+nb+ws+wb+ns+nb+ns+wb)       && "4"
   AADD(char,wb+ns+nb+ws+wb+ns+nb+ns+nb)       && "5"
   AADD(char,nb+ns+wb+ws+wb+ns+nb+ns+nb)       && "6"
   AADD(char,nb+ns+nb+ws+nb+ns+wb+ns+wb)       && "7"
   AADD(char,wb+ns+nb+ws+nb+ns+wb+ns+nb)       && "8"
   AADD(char,nb+ns+wb+ws+nb+ns+wb+ns+nb)       && "9"
   AADD(char,nb+ns+nb+ws+wb+ns+wb+ns+nb)       && "0"
   AADD(char,wb+ns+nb+ns+nb+ws+nb+ns+wb)       && "A"
   AADD(char,nb+ns+wb+ns+nb+ws+nb+ns+wb)       && "B"
   AADD(char,wb+ns+wb+ns+nb+ws+nb+ns+nb)       && "C"
   AADD(char,nb+ns+nb+ns+wb+ws+nb+ns+wb)       && "D"
   AADD(char,wb+ns+nb+ns+wb+ws+nb+ns+nb)       && "E"
   AADD(char,nb+ns+wb+ns+wb+ws+nb+ns+nb)       && "F"
   AADD(char,nb+ns+nb+ns+nb+ws+wb+ns+wb)       && "G"
   AADD(char,wb+ns+nb+ns+nb+ws+wb+ns+nb)       && "H"
   AADD(char,nb+ns+wb+ns+nb+ws+wb+ns+nb)       && "I"
   AADD(char,nb+ns+nb+ns+wb+ws+wb+ns+nb)       && "J"
   AADD(char,wb+ns+nb+ns+nb+ns+nb+ws+wb)       && "K"
   AADD(char,nb+ns+wb+ns+nb+ns+nb+ws+wb)       && "L"
   AADD(char,wb+ns+wb+ns+nb+ns+nb+ws+nb)       && "M"
   AADD(char,nb+ns+nb+ns+wb+ns+nb+ws+wb)       && "N"
   AADD(char,wb+ns+nb+ns+wb+ns+nb+ws+nb)       && "O"
   AADD(char,nb+ns+wb+ns+wb+ns+nb+ws+nb)       && "P"
   AADD(char,nb+ns+nb+ns+nb+ns+wb+ws+wb)       && "Q"
   AADD(char,wb+ns+nb+ns+nb+ns+wb+ws+nb)       && "R"
   AADD(char,nb+ns+wb+ns+nb+ns+wb+ws+nb)       && "S"
   AADD(char,nb+ns+nb+ns+wb+ns+wb+ws+nb)       && "T"
   AADD(char,wb+ws+nb+ns+nb+ns+nb+ns+wb)       && "U"
   AADD(char,nb+ws+wb+ns+nb+ns+nb+ns+wb)       && "V"
   AADD(char,wb+ws+wb+ns+nb+ns+nb+ns+nb)       && "W"
   AADD(char,nb+ws+nb+ns+wb+ns+nb+ns+wb)       && "X"
   AADD(char,wb+ws+nb+ns+wb+ns+nb+ns+nb)       && "Y"
   AADD(char,nb+ws+wb+ns+wb+ns+nb+ns+nb)       && "Z"
   AADD(char,nb+ws+nb+ns+nb+ns+wb+ns+wb)       && "-"
   AADD(char,wb+ws+nb+ns+nb+ns+wb+ns+nb)       && "."
   AADD(char,nb+ws+wb+ns+nb+ns+wb+ns+nb)       && " "
   AADD(char,nb+ws+nb+ns+wb+ns+wb+ns+nb)       && "*"
   AADD(char,nb+ws+nb+ws+nb+ws+nb+ns+nb)       && "$"
   AADD(char,nb+ws+nb+ws+nb+ns+nb+ws+nb)       && "/"
   AADD(char,nb+ws+nb+ns+nb+ws+nb+ws+nb)       && "+"
   AADD(char,nb+ns+nb+ws+nb+ws+nb+ws+nb)       && "%"
EndIf

_cFixo1   := "4329876543298765432987654329876543298765432"
_cFixo2   := "21212121212121212121212121212"
_cFixo3   := "3298765432"
_cFixo4   := "765432765432765432765432765432765432765432765432"

* Preparacao Fim

DbSelectArea("SE1")
DbSetOrder(1)
DbSeek(xFilial("SE1")+MV_PAR01+MV_PAR03,.T.)
_MsgImp := "Impressora nao Pronta"+chr(13)+"Continua Tentando ?"
_Resp := 1
SetRegua(LastRec())
//SetPRC(0,0)
Do While SE1->E1_FILIAL == xFilial("SE1") .And. SE1->E1_PREFIXO <= MV_PAR02 .And.;
         SE1->E1_NUM    <= MV_PAR04  .And. !Eof()

   IncRegua()                    // Termometro de Impressao
   If SE1->E1_EMISSAO < MV_PAR05 .Or. SE1->E1_EMISSAO > MV_PAR06 .Or.;
      SE1->E1_VENCTO  < MV_PAR07 .Or. SE1->E1_VENCTO  > MV_PAR08 .Or.;
      SE1->E1_CLIENTE < MV_PAR09 .Or. SE1->E1_CLIENTE > MV_PAR11 .Or.;
      SE1->E1_LOJA    < MV_PAR10 .Or. SE1->E1_LOJA    > MV_PAR12 .Or.; 
      Val(SE1->E1_IMPRESS) # MV_PAR13 .Or. SE1->E1_TIPODOC <> "BO" .Or. SE1->E1_PORTADOR == "777"
      DbSkip()
      Loop
   EndIf

   If Empty(SE1->E1_SALDO)
      If SE1->E1_IMPRESS == " "
         RecLock("SE1",.F.)
         SE1->E1_IMPRESS := "1"
         MsUnLock()
      EndIf
      DbSkip()
      Loop
   EndIf
   DbSelectArea("SA6")       
   If !Empty(SE1->E1_PORTADO)
      DbSeek(xFilial("SA6")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA,.F.)
   Else
      DbSeek(xFilial("SA6")+TRIM(SE1->E1_BCO),.F.)
   EndIf
   DbSelectArea("SEE")       
   Dbsetorder(1)
//   DbSeek(xFilial("SEE")+SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON,.F.)
   DbSeek(xFilial("SEE")+SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON,.F.)
    
   xCOMPLEM := Space(20) // Complemento do Endereco - by Rodrigo
   _DacBco := ""
   _NomBco := ""
   _NomBc2 := ""
   cPictBanc:=""
   _cEspDoc :=""
   _cCartDoc:=""
   _nossonum:=""
   _dc      :=""
   If SA6->A6_COD == "033"
      _DacBco  := "033-7"
      _NomBco  := "BANESPA"
      cPictBanc:= "@R 999 9999999 9"
      _cEspDoc := "DM-CI"
      _cCartDoc:= "COB"
      _nossonum:= SEE->EE_FAXATU
      _dc       := U_CmMod10(_Nossonum)         // Calculo do Digito de Verificacao
   ElseIf SA6->A6_COD == "275"
      _DacBco := "275-5"
      _NomBco := "BANCO REAL"
      cPictBanc:="@R 9999999"
      _cEspDoc := "NB"
      _cCartDoc:= "20"
      _nossonum:= SEE->EE_FAXATU
      _dc       := "" // NAO TEM DV
   ElseIf SA6->A6_COD == "399"
      _DacBco := "399-9"
      _NomBco := "HSBC"
      _NomBc2 := "BANK BRASIL"
      cPictBanc:="@R 99 999 999 99 9"
      _cEspDoc := "PD"
      _cCartDoc:= "CSB"
      _nossonum:= SEE->EE_FAXATU
      _dc       := U_DCHSBC(_Nossonum)         // Calculo do Digito de Verificacao
   ElseIf SA6->A6_COD == "479"
      _DacBco := "479-9"
      _NomBco := "BOSTON"
      _NomBc2 := "BANK BOSTON"
      cPictBanc:="@R 99999999-9"
      _cEspDoc := "DM"
      _cCartDoc:= "RAP"
      _nossonum:= Alltrim(SEE->EE_FAXATU)
      If (Val(SEE->EE_FAXFIM) - Val(SEE->EE_FAXATU)) <= 50 .And. (Val(SEE->EE_FAXFIM) - Val(SEE->EE_FAXATU)) > 0
         Alert ("Solicitar nova faixa de n˙meros banc·rios ao Banco Boston")
      ElseIf Val(SEE->EE_FAXFIM) - Val(SEE->EE_FAXATU) <= 0                          
         Alert ("N„o existe faixa de n˙meros banc·rios disponÌveis, favor solicitar ao Banco Boston")
         Return
      Endif
      _dc       := U_DCBOSTON(_Nossonum)         // Calculo do Digito de Verificacao
   ElseIf SA6->A6_COD == "001"
      _DacBco := "001-9"
      _NomBco := "BANCO BRASIL"
      _NomBc2 := "BANCO DO BRASIL"
      cPictBanc:="@R 99999999999-9"
      cPictBanc2:="@R 99999999999"      
      _cEspDoc := "DM"
      _cCartDoc:= "017"
      _nossonum:= SEE->EE_FAXATU
      _dc       := U_DCBRASIL(_Nossonum)         // Calculo do Digito de Verificacao

      Dbselectarea("SEE")
      RecLock("SEE",.F.)
      SEE->EE_FAXATU := Str(Val(_NossoNum)+1,11)
      MsUnLock()
   EndIf

   If SA6->A6_COD <> "001"   // N„o È o Brasil
      Dbselectarea("SEE")
      RecLock("SEE",.F.)
      SEE->EE_FAXATU := Str(Val(_NossoNum)+1,10)
      MsUnLock()
    Endif
    
	If !Empty(SE1->E1_NUMBCO)
		If MsgBox("Boleto ja impresso com Numero "+SE1->E1_NUMBCO+" Regrava ?","Escolha","YESNO")
		   Dbselectarea("SE1")
		   RecLock("SE1",.F.)
		   SE1->E1_NUMBCO := AllTRIM(_NossoNum) + _dc  
		   MsUnLock()
		Endif
	Else
	   Dbselectarea("SE1")
	   RecLock("SE1",.F.)
	   SE1->E1_NUMBCO := AllTRIM(_NossoNum) + _dc  
	   MsUnLock()
   Endif
   
   ** Montagem do Codigo de Barras
   _ValBol := SE1->E1_VALOR
   
   _BarCod := SA6->A6_COD                         && 03 Banco
   _BarCod := _BarCod + "9"                       && 01 Moeda (no banco)
   If SA6->A6_COD == "275" // Real
	   _BarCod := _BarCod + "0000"
	   _BarCod := _BarCod + StrZero((_ValBol*100),10) && 10 Valor
   Elseif SA6->A6_COD == "033" // Banespa
	   _BarCod := _BarCod + StrZero(SE1->E1_VENCTO-CTOD("07/10/1997"),4)
	   _BarCod := _BarCod + StrZero((_ValBol*100),10) && 10 Valor
   Elseif SA6->A6_COD == "479" // Boston
	   _BarCod := _BarCod + StrZero(SE1->E1_VENCTO-CTOD("07/10/1997"),4)
       _BarCod := _BarCod + StrZero((_ValBol*100),10) && 10 Valor	   
   Else 
	   _BarCod := _BarCod + StrZero(SE1->E1_VENCTO-CTOD("07/10/1997"),4)
	   _BarCod := _BarCod + StrZero((_ValBol*100),10) && 10 Valor
   Endif
   // Monta as 25 posiÁoes do campo livre com as informaÁoes pertinentes a cada banco
   If SA6->A6_COD == "033" // Banespa
      _BlocoBar := StrZero(Val(SA6->A6_AGENCIA),3)
      _BlocoBar := _BlocoBar + StrZero(Val(Left(AllTrim(SEE->EE_CODEMP ),8)),8)
      _BlocoBar := _BlocoBar + StrZero(Val(Subs(AllTrim(SE1->E1_NUMBCO ),4,7)),7)
      _BlocoBar := _BlocoBar + "00"
      _BlocoBar := _BlocoBar + SA6->A6_COD
      
	  nSoma1  := 0
	  _FixVar := Right(_cFixo2,Len(_BlocoBar))
	  For nI := 1 to Len(_BlocoBar)
	      _nRes := Val(Substr(_BlocoBar,nI,1))*Val(Substr(_FixVar,nI,1))
	      If _nRes > 9
	         _nRes := _nRes-9
	      Endif
	      nSoma1 := nSoma1 + _nRes
	  Next
	  _BlocoBar := _BlocoBar + Right(StrZero(10-(nSoma1%10),2),1)

      Do While .t.                              
          nSomaGer := 0
	      _FixVar := Right(_cFixo4,Len(_BlocoBar))
	      For nI := Len(_BlocoBar) to 1 Step -1
	          nSomaGer := nSomaGer + (Val(Substr(_BlocoBar,nI,1))*Val(Substr(_FixVar,nI,1)))
	      Next
	      
	      nSomaGer := (nSomaGer%11) // Resto da divis„o do total por 11
	      
	      If nSomaGer == 1 // Se o resto for 1
	         If Right(_BlocoBar,1) == "9"
	            _BlocoBar := Left(_BlocoBar,23) + "0"
	         Else
                _BlocoBar := Left(_BlocoBar,23) + Str(Val(Right(_BlocoBar,1))+1,1)
             EndIf            
             Loop
          EndIf
          If nSomaGer # 0 
             nSomaGer := 11-nSomaGer
	      Endif
	      Exit
      EndDo
	  _BlocoBar := _BlocoBar + StrZero(nSomaGer,1)
	  _BarCod := _BarCod + _BlocoBar
   ElseIf SA6->A6_COD == "275" // Real 
      // Calculo do Digitao - Somente para o Banco Real
      _BaseCal := StrZero(Val(Left(AllTrim(SE1->E1_NUMBCO ),7)),7)+;
                  StrZero(Val(Left(AllTrim(SA6->A6_AGENCIA),4)),4)+;       
                  StrZero(Val(Left(AllTrim(SA6->A6_NUMCON ),7)),7)         
      _ResMul := 0
      _cFixoNow   := Right(_cFixo2,Len(_BaseCal))
      For _nCont := Len(_BaseCal) to 1 Step -1
          _nMult := (Val(Substr(_BaseCal,_nCont,1))*Val(Substr(_cFixoNow,_nCont,1)))
          If _nMult > 9
             _nMult -= 9
          EndIf
          _ResMul += _nMult
      Next       
      _ResMul := (_ResMul%10)
      If _ResMul == 0
         _ResMul := "0"
      Else
         _ResMul := Str(10-_ResMul,1)
      EndIf
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim(SA6->A6_AGENCIA),4)),4)
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim(SA6->A6_NUMCON ),7)),7)
      _BarCod := _BarCod + _ResMul // VERIGICAR DIGITAO 
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim(SE1->E1_NUMBCO ),13)),13)
   ElseIf SA6->A6_COD == "399" // HSBC
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim(SE1->E1_NUMBCO ),11)),11)
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim(SA6->A6_AGENCIA),4)),4)
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim(SA6->A6_NUMCON ),7)),7)
      _BarCod := _BarCod + "00"
      _BarCod := _BarCod + "1"
   ElseIf SA6->A6_COD == "479" // Boston
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim("1725119"),9)),9)
      _BarCod := _BarCod + "000000"
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim(SE1->E1_NUMBCO ),9)),9)
      _BarCod := _BarCod + "8"
   ElseIf SA6->A6_COD == "001" .And. SA6->A6_NUMCON == "105007    "  // Brasil - Matriz
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim(SE1->E1_NUMBCO ),11)),11)
      _BarCod := _BarCod + "2414" // Agencia
      _BarCod := _BarCod + "00010500"  // Cedente - Conta
      _BarCod := _BarCod + "17"  // Carteira
   ElseIf SA6->A6_COD == "001" .And. SA6->A6_NUMCON == "105015    "  // Brasil - Filial
      _BarCod := _BarCod + StrZero(Val(Left(AllTrim(SE1->E1_NUMBCO ),11)),11)
      _BarCod := _BarCod + "2414" // Agencia
      _BarCod := _BarCod + "00010501"  // Cedente - Conta
      _BarCod := _BarCod + "17"  // Carteira
   EndIf


   * Calculo do DV Geral

   nSomaGer := 0
   For nI := 1 to 43
       nSomaGer := nSomaGer + ;
       (Val(Substr(_BarCod,nI,1))*Val(Substr(_cFixo1,nI,1)))
   Next
   If SA6->A6_COD <> "479" // N„o È o Boston
      If (11-(nSomaGer%11)) > 9
         cCalcDv := "1"
      Else
         cCalcDv := Str(11-(nSomaGer%11),1)
      Endif
   Else
      If (11-(nSomaGer%11)) > 9 .Or. (11-(nSomaGer%11)) == 0 .Or. (11-(nSomaGer%11)) == 1
         cCalcDv := "1"
      Else
         cCalcDv := Str(11-(nSomaGer%11),1)
      Endif   
   Endif
   
   _BarCod := Left(_BarCod ,4) + cCalcDv + Right(_BarCod,39)
   

   * Monta sequencia de codigos para o topo do boleto
 
   _cBloco := Left(_BarCod,4) + Substr(_BarCod,20,5) +;
              Substr(_BarCod,25,10) + Substr(_BarCod,35,10)

   nSoma1 := 0
   nSoma2 := 0
   nSoma3 := 0
 
   * Calcula o DV do primeiro Bloco
   _FixVar := Right(_cFixo2,9)
   For nI := 1 to 9
*       _nRes := Val(Substr(_cBloco,nI,1))*Val(Substr(_FixVar,nI,1))
       _nRes := Val(Substr(_cBloco,nI,1))*Val(Substr(_cFixo2,nI,1))
       If _nRes > 9
          _nRes := 1 + (_nRes-10)
       Endif
       nSoma1 := nSoma1 + _nRes
   Next
 
   * Calcula o DV do segundo bloco
   _FixVar := Right(_cFixo2,10)
   For nI := 10 to 19
*       _nRes := Val(Substr(_cBloco,nI,1))*Val(Substr(_FixVar,nI,1))
       _nRes := Val(Substr(_cBloco,nI,1))*Val(Substr(_cFixo2,nI,1))
       If _nRes > 9
          _nRes := 1 + (_nRes-10)
       Endif
       nSoma2 := nSoma2 + _nRes 
   Next
 
   * Calcula o DV do terceiro Bloco
   _FixVar := Right(_cFixo2,10)
   For nI := 20 to 29
*       _nRes := Val(Substr(_cBloco,nI,1))*Val(Substr(_FixVar,nI,1))
       _nRes := Val(Substr(_cBloco,nI,1))*Val(Substr(_cFixo2,nI,1))
       If _nRes > 9
          _nRes := 1 + (_nRes-10)
       Endif
       nSoma3 := nSoma3 + _nRes
   Next
   cSoma1 := Right(StrZero(10-(nSoma1%10),2),1)
   cSoma2 := Right(StrZero(10-(nSoma2%10),2),1)
   cSoma3 := Right(StrZero(10-(nSoma3%10),2),1) 
   * Uso as funcoes StrZero e Right para pegar o nro correto quando o resto
   * de nSoma/10 for 0
 
   * Monta sequencia de codigos para o topo do boleto com os dvs e o valor
 
   If SA6->A6_COD <> "275" // Nao È o Real

	   _cBloco := Left(_BarCod,4) + Substr(_BarCod,20,5) + cSoma1 +;
	              Substr(_BarCod,25,10) + cSoma2+ Substr(_BarCod,35,10)+ cSoma3 +;
	              cCalcDv + Substr(_BarCod,6,4) + StrZero((_ValBol*100),10)
	Else 
	   _cBloco := Left(_BarCod,4) + Substr(_BarCod,20,5) + cSoma1 +;
	              Substr(_BarCod,25,10) + cSoma2+ Substr(_BarCod,35,10)+ cSoma3 +;
	              cCalcDv + Alltrim(Str((_ValBol*100),10))
	
	Endif

   // Monta String do codigo de barras propriamente dito
   _code := ""

   If _TpBar == "25"
      // Intercala a referencia binaria dos numeros aos pares, pois nesse tipo
      // os numeros das posicoes impares serao escritos em barras largas e barras
      // estreitas e os numeros das posicoes pares serao escritos com espacos largos
      // e espacos estreitos.
      _cBar := _BarCod
      For _nX := 1 to 43 Step 2 && 44 porque o meu cod.possue 44 numeros
         _nNro := VAl(Substr(_cBar,_nx,1))
         If _nNro == 0
            _nNro := 10
         EndIf
         _cBarx := char25[_nNro]
         _nNro := VAl(Substr(_cBar,_nx+1,1))
         If _nNro == 0
            _nNro := 10
         EndIf
         _cBarx := _cBarx + char25[_nNro]

         For _nY := 1 to 5
             If Substr(_cBarx,_nY,1) == "0"
                // Uso Barra estreita
                _code := _code + nb
             Else
                // Uso Barra larga
                _code := _code + wb
             EndIf
             If Substr(_cBarx,_nY+5,1) == "0"
                // Uso Espaco estreito
                _code := _code + ns
             Else
                // Uso Espaco Largo
                _code := _code + ws
             EndIf
         Next
      Next
      _code := nb+ns+nb+ns+_code+wb+ns+nb
      // Guarda de inicio == Barra Estr+Esp.Estr+Barra Estr+Esp.Estr
      // Guarda de Fim    == Barra Larga +Esp.Estr+Barra Estr
      // Estes devem ser colocados antes e depois do codigo montado
   ElseIf _TpBar == "39"
      _code := ""
      _BarCod := "*"+_BarCod+"*"
      FOR I := 1 TO LEN(m->_BarCod)
          letter := SUBSTR(m->_BarCod,I,1)
          _code := _code + IF(AT(letter,chars)=0,letter,char[at(letter,chars)]) + ns
      NEXT
     *   _code := start + _code + _Fim

   EndIf

   DbSelectArea("SA1")
   DbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA,.F.)
   /*
   Do While !IsPrinter() .and. _Resp == 1
      _Resp := MsgBox(_MsgImp,"Escolha","YESNO")
   EndDo
   If _Resp == 2
      Exit
   Endif
   */   
   Set Century On
   @ 00,000 PSAY "E"

//   @ 00,000 PSAY "(12U(s1p30v1s3b4168T" +  _NomBco && Muito Grande

   @ 00,003 PSAY "(12U(s1p20v1s3b4168T" + _NomBco
//   If !Empty(_NomBc2)
//      @ 00,000 PSAY "(12U(s1p5v1s3b4168T" +  "                        " + _NomBc2
//   EndIf

   @ 00,005 PSAY "(12U(s1p18v1s3b4168T" +  "                         |  "+_DacBco+"   |"
   @ 00,000 PSAY "(12U(s1p10v1s3b4168T" +  "                                                                                                                                       RECIBO DO SACADO"
   @ 01,000 PSAY "(s0p20h6v0s0b3T"+Chr(38)+"l12D"
   @ 01,000 PSAY ""
   @ 01,004 PSAY "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø "
   @ 02,003 PSAY "≥ Cedente:            "+SM0->M0_NOMECOM 
   @ 02,068 PSAY "≥  Sacado "
   @ 02,082 PSAY SUBSTR(SA1->A1_NOME,1,67)
   @ 02,148 PSAY " ≥"
   If SA6->A6_COD == "033"
      @ 03,003 PSAY "≥ Ag./Conta Corrente: "+Transform(Right(AllTrim(SA6->A6_AGENCIA),3)+AllTrim(SEE->EE_CODEMP),"@R 999-99 99999 9")
   ElseIf SA6->A6_COD == "479"
      @ 03,003 PSAY "≥ Ag./Conta Corrente: 0690732/1725119"
   ElseIf SA6->A6_COD == "001" .And. SA6->A6_NUMCON == "105007    "
      @ 03,003 PSAY "≥ Ag./Conta Corrente: 2414-7/10500-7"
   ElseIf SA6->A6_COD == "001" .And. SA6->A6_NUMCON == "105015    "
      @ 03,003 PSAY "≥ Ag./Conta Corrente: 2414-7/10501-5"
   Else
      @ 03,003 PSAY "≥ Ag./Conta Corrente: "+Alltrim(SA6->A6_AGENCIA) + "/"+AllTrim(SA6->A6_NUMCON)
   EndIf
   @ 03,068 PSAY "≥                                                                                ≥"
   @ 04,003 PSAY "≥ Data do Documento:"
   @ 04,025 PSAY SE1->E1_EMISSAO
   If !Empty(SA1->A1_ENDCOB)
      wTAM := SPACE(81)
      wTAM := "≥  Endereáo : " + Alltrim(SA1->A1_ENDCOB)  + " " + Alltrim(SA1->A1_NUMENDC)
      TAM  := 0
      TAM  := 81 - LEN(wTAM)
      @ 04,068 PSAY "≥  Endereáo : " + Alltrim(SA1->A1_ENDCOB)  + " " + Alltrim(SA1->A1_NUMENDC) + SPACE(TAM)
   Else
      wTAM := SPACE(81)
      wTAM := "≥  Endereáo : " + Alltrim(SA1->A1_END) + " " + Alltrim(SA1->A1_NUMEND)
      TAM  := 0
      TAM  := 81 - LEN(wTAM)
      @ 04,068 PSAY "≥  Endereáo : " + Alltrim(SA1->A1_END) + " " + Alltrim(SA1->A1_NUMEND)  + SPACE(TAM)
   EndIf
   @ 04,148 PSAY " ≥"
   If SA6->A6_COD == "001"  .And. _dc == "X"   // Brasil
      @ 05,003 PSAY "≥ Nosso Numero:       "+Transform(SE1->E1_NUMBCO,cPictBanc2)
      @ 05,036 PSAY "-X"
   Else
      @ 05,003 PSAY "≥ Nosso Numero:       "+Transform(SE1->E1_NUMBCO,cPictBanc)   
   Endif
   If !Empty(SA1->A1_ENDCOB)
      wTAM := SPACE(81)
      wTAM := "≥             " + SA1->A1_BAIRROC
      TAM  := 0
      TAM  := 81 - LEN(wTAM)
      @ 05,068 PSAY "≥             " + SA1->A1_BAIRROC  + SPACE(TAM)
   Else
      wTAM := SPACE(81)
      wTAM := "≥             " + SA1->A1_BAIRRO
      TAM  := 0
      TAM  := 81 - LEN(wTAM)
      @ 05,068 PSAY "≥             " + SA1->A1_BAIRRO   + SPACE(TAM)
   EndIf                           
   @ 05,148 PSAY " ≥"
   @ 06,003 PSAY "≥ N.do Documento:     "+SE1->E1_NUM+If(!Empty(SE1->E1_PARCELA),"-"+SE1->E1_PARCELA,"")
   If !Empty(SA1->A1_ENDCOB)
      wTAM := SPACE(81)
      wTAM := "≥  CEP :      "+ Transform(SA1->A1_CEPC,"@R 99999-999")
      TAM  := 0
      TAM  := 81 - LEN(wTAM)
      @ 06,068 PSAY "≥  CEP :      "+ Transform(SA1->A1_CEPC,"@R 99999-999") + SPACE(TAM)
   Else
      wTAM := SPACE(81)
      wTAM := "≥  CEP :      "+ Transform(SA1->A1_CEP,"@R 99999-999")
      TAM  := 0
      TAM  := 81 - LEN(wTAM)
      @ 06,068 PSAY "≥  CEP :      "+ Transform(SA1->A1_CEP,"@R 99999-999") + SPACE(TAM)
   EndIf
   @ 06,148 PSAY " ≥"
      wTAM := SPACE(65)
      wTAM := "≥ EspÇcie Doc.:       "+ _cEspDoc
      TAM  := 0
      TAM  := 65 - LEN(wTAM)
   @ 07,003 PSAY "≥ EspÇcie Doc.:       "+ _cEspDoc + SPACE(TAM)
   @ 07,068 PSAY "≥                                                                                ≥"
      wTAM := SPACE(65)
      wTAM := "≥ Carteira :          "+ _cCartDoc
      TAM  := 0
      TAM  := 65 - LEN(wTAM)
   @ 08,003 PSAY "≥ Carteira :          "+ _cCartDoc + SPACE(TAM)
   If !Empty(SA1->A1_ENDCOB)
      wTAM := SPACE(81)
      wTAM := "≥  Cidade :   "+AllTrim(SA1->A1_MUNC)+ " - "+SA1->A1_ESTC
      TAM  := 0
      TAM  := 81 - LEN(wTAM)
      @ 08,068 PSAY "≥  Cidade :   "+AllTrim(SA1->A1_MUNC)+ " - "+SA1->A1_ESTC + SPACE(TAM)
   Else
      wTAM := SPACE(81)
      wTAM := "≥  Cidade :   "+AllTrim(SA1->A1_MUN)+ " - "+SA1->A1_EST
      TAM  := 0
      TAM  := 81 - LEN(wTAM)
      @ 08,068 PSAY "≥  Cidade :   "+AllTrim(SA1->A1_MUN)+ " - "+SA1->A1_EST + SPACE(TAM)
   EndIf
   @ 08,148 PSAY " ≥"
   @ 09,003 PSAY "≥ Aceite :            N                                          ≥                                                                                ≥"
   @ 10,003 PSAY "≥ EspÇcie :           R$                                         ≥                                                                                ≥"
   @ 11,003 PSAY "√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥ "
   _Jrs := Round((_ValBol*(MV_PAR17/30)) / 100,2)
   If SA6->A6_COD == "033"
         wTAM := SPACE(65)
         wTAM := "≥ Vencido, cobrar juros de R$ "+Transform(_Jrs,"@E 9,999.99") + " ao dia"
         TAM  := 0
         TAM  := 65 - LEN(wTAM)
       @ 12,003 PSAY "≥ Vencido, cobrar juros de R$ "+Transform(_Jrs,"@E 9,999.99") + " ao dia" + SPACE(TAM)
       @ 12,068 PSAY "≥                                                                                ≥"
         wTAM := SPACE(65)
         wTAM := "≥ " + MV_PAR16
         TAM  := 0
         TAM  := 65 - LEN(wTAM)
       @ 13,003 PSAY "≥ " + MV_PAR16 + SPACE(TAM)
       @ 13,068 PSAY "≥                                                                                ≥"
         wTAM := SPACE(65)
         wTAM := "≥ Pagar preferencialmente no Banespa"
         TAM  := 0
         TAM  := 65 - LEN(wTAM)
       @ 14,003 PSAY "≥ Pagar preferencialmente no Banespa" + SPACE(TAM)
       @ 14,068 PSAY "≥                                                                                ≥"
   Else   
         wTAM := SPACE(65)
         wTAM := "≥ " + MV_PAR14
         TAM  := 0
         TAM  := 65 - LEN(wTAM)
	   @ 12,003 PSAY "≥ " + MV_PAR14 + SPACE(TAM)
       @ 12,068 PSAY "≥                                                                                ≥"	   
         wTAM := SPACE(65)
         wTAM := "≥ " + MV_PAR15
         TAM  := 0
         TAM  := 65 - LEN(wTAM)
	   @ 13,003 PSAY "≥ " + MV_PAR15 + SPACE(TAM)
       @ 13,068 PSAY "≥                                                                                ≥"	   
         wTAM := SPACE(65)
         wTAM := "≥ " + MV_PAR16
         TAM  := 0
         TAM  := 65 - LEN(wTAM)
	   @ 14,003 PSAY "≥ " + MV_PAR16 + SPACE(TAM)
       @ 14,068 PSAY "≥                                                                                ≥"	   
   Endif   
   @ 15,003 PSAY "≥                                                                ≥                                                                                ≥"
   @ 16,003 PSAY "≥                                                                ≥                                                                                ≥"
   @ 17,003 PSAY "√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥ "
   @ 18,003 PSAY "≥ Vencimento :"
   @ 18,018 PSAY SE1->E1_VENCTO
   @ 18,034 PSAY "Valor do Documento :"
   @ 18,055 PSAY _ValBol PICTURE "@E 999,999.99"
   @ 18,068 PSAY "≥   AUTENTICAÄ«O MEC∂NICA                                                        ≥"
   @ 19,003 PSAY "≥                                                                ≥                                                                                ≥"
   @ 20,003 PSAY "≥                                                                ≥                                                                                ≥"
   @ 21,003 PSAY "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
   @ 23,003 PSAY " .....................................................................................................................Recortar Aqui..............."
   @ 27,003 PSAY "(12U(s1p20v1s3b4168T" +  " "+_NomBco
   @ 27,005 PSAY "(12U(s1p18v1s3b4168T" +  "                         |  "+_DacBco+"   |"
   @ 27,000 PSAY "(12U(s1p10v1s3b4113T"
   @ 27,108 PSAY _cBloco Picture "@R 99999.99999 99999.999999 99999.999999 9 99999999999999"
   @ 27,000 PSAY "(s0p20h6v0s0b3T"+Chr(38)+"l12D"
   @ 28,005 PSAY "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   @ 29,005 PSAY "Local de Pagamento                                                                                             ≥ Vencimento                    "
   If SA6->A6_COD == "399"
      @ 30,005 PSAY "                   Pagar preferencialmente em agància HSBC Bank Brasil                                         ≥"
   Else
      @ 30,005 PSAY "                   Pagavel em qualquer banco atÇ o vencimento                                                  ≥"
   Endif
   @ 30,130 PSAY SE1->E1_VENCTO
   @ 31,005 PSAY "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   @ 32,005 PSAY "Cedente                                                                                                        ≥ Agància/C¢digo Cedente        "
   @ 33,009 PSAY SM0->M0_NOMECOM + "           " + Transform(SM0->M0_CGC,"@R 99.999.999/9999-99")
   If SA6->A6_COD == "033"
      @ 33,116 PSAY "≥     "+Transform(Right(AllTrim(SA6->A6_AGENCIA),3)+AllTrim(SEE->EE_CODEMP),"@R 999-99 99999 0")
   ElseIf SA6->A6_COD == "479"
      @ 33,116 PSAY "≥ 0690732/1725119"
   ElseIf SA6->A6_COD == "001" .And. SA6->A6_NUMCON == "105007    "
      @ 33,116 PSAY "≥     2414-7/10500-7"
   ElseIf SA6->A6_COD == "001" .And. SA6->A6_NUMCON == "105015    "
      @ 33,116 PSAY "≥     2414-7/10501-5"
   Else
      @ 33,116 PSAY "≥     "+AllTrim(SA6->A6_AGENCIA) + "/" + AllTrim(SEE->EE_CODEMP)
   EndIf
   @ 34,005 PSAY "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   @ 35,005 PSAY "Data do Documento  ≥N¯ do Documento            ≥EspÇcie Doc≥Aceite      ≥Data de Processamento                 ≥ Nosso N£mero                  "
   @ 36,009 PSAY SE1->E1_EMISSAO
   @ 36,024 PSAY "≥ "+SE1->E1_NUM+If(!Empty(SE1->E1_PARCELA),"-"+SE1->E1_PARCELA,"")
   @ 36,052 PSAY "≥   "+_cEspDoc
   @ 36,064 PSAY "≥   N        ≥"
   @ 36,083 PSAY SE1->E1_EMISSAO
   If SA6->A6_COD == "001"  .And. _dc == "X"   // Brasil                      
      @ 36,116 PSAY "≥         " + Transform(AllTrim(SE1->E1_NUMBCO),cPictBanc2)
      @ 36,137 PSAY "-X"
   Else
      @ 36,116 PSAY "≥         " + Transform(AllTrim(SE1->E1_NUMBCO),cPictBanc)
   Endif   
   @ 37,005 PSAY "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   @ 38,005 PSAY "Uso do Banco       ≥Carteira ≥EspÇcie          ≥Quantidade              ≥Valor                                 ≥ (" + CHR(61) + ") Valor do Documento      "
   If SA6->A6_COD == "033"
      @ 39,005 PSAY " GAL. CARNEIRO"
   EndIf
   @ 39,024 PSAY "≥  "+_cCartDoc
   @ 39,034 PSAY "≥  R$             ≥                        ≥                                      ≥"
   @ 39,125 PSAY _ValBol PICTURE "@E 9,999,999.99"
   @ 40,005 PSAY "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   If SA6->A6_COD == "033"
      @ 41,005 PSAY "Instruá‰es:                                                                                                    ≥ (" + CHR(61) + ") Desconto                  "
   Else
      @ 41,005 PSAY "Texto de responsabilidade do cedente :                                                                         ≥ (" + CHR(61) + ") Desconto                  "
   EndIf
   @ 42,116 PSAY "≥         " 
   @ 42,126 PSAY _ValBol-SE1->E1_SALDO PICTURE "@E 9,999,999.99"
   @ 43,116 PSAY "√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   _Jrs := Round((_ValBol*(MV_PAR17/30)) / 100,2)
   If SA6->A6_COD == "033"
      @ 44,005 PSAY "Vencido, cobrar juros de R$ "+Transform(_Jrs,"@E 9,999.99") + " ao dia"
      @ 44,116 PSAY "≥ (" + CHR(61) + ") Outras Deduá‰es/Abatimento"
      @ 45,005 PSAY "Titulo sujeito a protesto apos 3 dias do vencimento"
      @ 45,116 PSAY "≥                               "
      @ 46,005 PSAY "Pagar preferencialmente no Banespa"
   Else
      @ 44,005 PSAY AllTrim(MV_PAR14)+ " " + AllTrim(MV_PAR15)
      @ 44,116 PSAY "≥ (" + CHR(61) + ") Outras Deduá‰es/Abatimento"
      @ 45,005 PSAY AllTrim(MV_PAR16)
      @ 45,116 PSAY "≥                               "
      @ 46,005 PSAY "Vencido, cobrar juros de R$ "+Transform(_Jrs,"@E 9,999.99") + " ao dia"
   EndIf
   @ 46,116 PSAY "√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   If SA6->A6_COD == "479"
      @ 47,005 PSAY "APOS O VENCIMENTO PAGAR SOMENTE NO BANK BOSTON OU BILBAO VISCAYA"
   Endif
   @ 47,116 PSAY "≥ (+) Mora/Multa/Juros          "
   @ 48,116 PSAY "≥                               "
   @ 49,116 PSAY "√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   @ 50,116 PSAY "≥ (+) Outros AcrÇscimos         "
   @ 51,116 PSAY "≥                               "
   @ 52,116 PSAY "√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   @ 53,116 PSAY "≥ (" + CHR(61) + ") Valor Cobrado             "
   @ 54,116 PSAY "≥                               "
   @ 55,005 PSAY "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   @ 56,005 PSAY "Sacado:   " + SA1->A1_NOME
   @ 56,082 PSAY "CPF/CNPJ: " + Transform(Trim(SA1->A1_CGC),If(" "$SA1->A1_CGC,"@R 999.999.999-99","@R 99.999.999/9999-99"))

   xCOMPLEM := ALLTRIM(xCOMPLEM)
   If !Empty(xCOMPLEM)
      xCOMPLEM := xCOMPLEM+" - "
   EndIf

   If !Empty(SA1->A1_ENDCOB)
      @ 57,015 PSAY Trim(SA1->A1_ENDCOB) + " " + SA1->A1_NUMENDC + " - " + xCOMPLEM+AllTrim(SA1->A1_BAIRROC)+" - "+AllTrim(SA1->A1_MUNC)+" - "+AllTrim(SA1->A1_ESTC)+" - "+ Transform(SA1->A1_CEPC,"@R 99999-999")
   Else
      @ 57,015 PSAY Trim(SA1->A1_END) + " " + SA1->A1_NUMEND + xCOMPLEM + " - " + AllTrim(SA1->A1_BAIRRO)+" - "+AllTrim(SA1->A1_MUN)+" - "+AllTrim(SA1->A1_EST)+" - "+ Transform(SA1->A1_CEP,"@R 99999-999")
   EndIf

   @ 59,005 PSAY "Sacador/Avalista"
   @ 60,005 PSAY "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
   @ PROW(),05 PSAY _code
   @ 61,5 PSAY "(12U(s1p9v1s3b4168T" 
//   @ 61,188 PSAY "Ficha de Compensaá∆o"
//   @ PROW()+1,0 PSAY "(12U(s1p5v1s3b4168T"
//   @ PROW()+1,325 PSAY "Autenticaá∆o no Verso"
   @ 61,145 PSAY "Ficha de Compensaá∆o"
   @ PROW(),0 PSAY "(12U(s1p5v1s3b4168T"
   @ PROW(),335 PSAY "AUTENTICAÄ«O MEC∂NICA"

   DbSelectArea("SE1")
   If SE1->E1_IMPRESS == " "
      RecLock("SE1",.F.)
      SE1->E1_IMPRESS := "1"
      MsUnLock()
   EndIf
   DbSelectArea("SE1")
   DbSkip()
EndDo
@ 65,000 PSAY "E"
Set Century Off

SetPgEject(.F.)
If aReturn[5] == 1
   Set Printer TO
   dbCommitall()
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÑo    ≥ValidPerg ≥                                 Data ≥ 29/12/99 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥Cria SX1                                                    ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/  

// Substituido pelo assistente de conversao do AP5 IDE em 16/10/00 ==> Function ValidPerg
Static Function ValidPerg()

_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)
aRegs:={}

         // Grupo/Ordem/Pergunta        /Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3
aAdd(aRegs,{cPerg,"01","Do Prefixo             ","mv_ch1","C",03,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Ate o Prefixo          ","mv_ch2","C",03,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Do Numero              ","mv_ch3","C",06,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Ate o Numero           ","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Da Emissao             ","mv_ch5","D",08,0,0,"G","","mv_par05","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Ate a Emissao          ","mv_ch6","D",08,0,0,"G","","mv_par06","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Do Vencimento          ","mv_ch7","D",08,0,0,"G","","mv_par07","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","Ate o Vencimento       ","mv_ch8","D",08,0,0,"G","","mv_par08","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"09","Do Cliente             ","mv_ch9","C",06,0,0,"G","","mv_par09","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"10","Da Loja                ","mv_cha","C",02,0,0,"G","","mv_par10","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11","Ate o Cliente          ","mv_chb","C",06,0,0,"G","","mv_par11","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12","Ate a Loja             ","mv_chc","C",02,0,0,"G","","mv_par12","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","Quanto a Impressao     ","mv_chd","N",01,0,0,"C","","mv_par13","1ra.Impress∆o    ","","","Reimpress∆o","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Mensagem 1             ","mv_che","C",30,0,0,"G","","mv_par14","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15","Mensagem 2             ","mv_chf","C",30,0,0,"G","","mv_par15","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16","Mensagem 3             ","mv_chg","C",30,0,0,"G","","mv_par16","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"17","% Juros ao mes         ","mv_chh","N",05,2,0,"G","","mv_par17","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
       RecLock("SX1",.T.)
       For j:=1 to FCount()
       FieldPut(j,aRegs[i,j])
       Next
       MsUnlock()
    Endif
Next

dbSelectArea(_sAlias)

Return


////////////////////////////
User Function DCHSBC(_cNum)
////////////////////////////
//
cFatores := "5432765432"          // Fatores para Multiplicacao
cNumBanc := _cNum                 // Numero Bancario com 10 Posicoes
//
nValor   := 0                     // Valor da Multiplicacao
nSoma    := 0                     // Valor da Soma dos Resultados
//
For i := 1 To 10
    //
    nValor := Val(Substr(cNumBanc, i, 1)) * Val(Substr(cFatores, i, 1))
    //
    nSoma  := nSoma + nValor
    //
Next
//
wxxx := Mod(nSoma,11) // Resto
cDigNsNum := 11 - wxxx
//
If wxxx == 0 .Or. wxxx == 1    
	cDigNsNum := 0	
Endif
//
cDigNsNum := Strzero(cDigNsNum, 1)      // Digito de Verificacao
//
Return (cDigNsNum)

////////////////////////////
User Function DCBOSTON(_cNum)
////////////////////////////
//
cFatores := "98765432"            // Fatores para Multiplicacao
cNumBanc := _cNum                 // Numero Bancario com 8 Posicoes
//
nValor   := 0                     // Valor da Multiplicacao
nSoma    := 0                     // Valor da Soma dos Resultados
//
For i := 1 To 8
    //
    nValor := Val(Substr(cNumBanc, i, 1)) * Val(Substr(cFatores, i, 1))
    //
    nSoma  := nSoma + nValor
    //
Next
//
nSoma := nSoma * 10
wxxx  := Mod(nSoma,11) // Resto
cDigNsNum := wxxx
//
If wxxx == 10   
	cDigNsNum := 0	
Endif
//
cDigNsNum := Strzero(cDigNsNum, 1)      // Digito de Verificacao
//
Return (cDigNsNum)

////////////////////////////
User Function DCBRASIL(_cNum)
////////////////////////////
//
cFatores := "78923456789"         // Fatores para Multiplicacao
cNumBanc := _cNum                 // Numero Bancario com 8 Posicoes
//
nValor   := 0                     // Valor da Multiplicacao
nSoma    := 0                     // Valor da Soma dos Resultados
//
For i := 1 To 11
    //
    nValor := Val(Substr(cNumBanc, i, 1)) * Val(Substr(cFatores, i, 1))
    //
    nSoma  := nSoma + nValor
    //
Next
//
wxxx  := Mod(nSoma,11) // Resto
cDigNsNum := wxxx
//
If wxxx == 10   
	cDigNsNum := "X" 
	Return (cDigNsNum)
Endif
//
cDigNsNum := Strzero(cDigNsNum, 1)      // Digito de Verificacao
//
Return (cDigNsNum)
