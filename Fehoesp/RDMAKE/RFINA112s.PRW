#include "rwmake.ch"   // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

User Function FINA112s()   // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP6 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,N_OPC,CPERG,C_BORDERO")
SetPrvt("_CARQ,_NTOTAL,_NTOTAL2,_NTOTAL3,_NTOTJUR,_ASTRU")
SetPrvt("C_ARQTMP,_DATAPROC,_CPERIODO,_CMES,_CLOTE,_NRECNO")
SetPrvt("_CPREFIXO,_LMOVIMENTA,_NSALDO,_CCONTA,_CCGC,_DVENC")
SetPrvt("_NPREF,_NPARC,_ALTCONF,_TCONTA,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RFINA112  ³ Autor ³ Andreia dos Santos    ³ Data ³ 10/07/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorno de Contribuicoes   (Banco Real)                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs.:     ³ E' atualizado os arquivo SE1, SEA,                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

/* Associativa
agencia=> "1874/0409"
conta  => "7710534/6066347"
*/

/* Confederativa
agencia=> "1874/0409"
conta  => "7713319/1066389"
*/

/* Contributiva
agencia=> "1874/0409"
conta  => "1001714"
*/

/* Confederativa / Termos
agencia=> "1874/0409"
conta  => "6713328"
*/

/* Contratos Stas Casas - Natureza = 0327
agencia=> "1874/0409"
conta  => "9721760/0067611"
*/

_oldArea  := alias()
_oldOrder := indexord()

_cTitulo   := "Retorno de Contribuicoes"

n_Opc := 0
cPerg    := "FINA12"

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                                       ³
³ mv_par06   // Arquivo de entrada                                           ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

Pergunte(cPerg,.T.)
C_BORDERO := ""
#IFNDEF WINDOWS
	DrawAdvWindow(_cTitulo,008,000,017,079)
	SetColor("B/BG,N/W")
	
	@ 011,010 Say "Este programa fara a recepcao Bancaria das cobrancas "
	@ 012,010 Say "Vindas do Banco Real"
	SetColor("B/BG,W/N")
	
	@ 014,010 Say "CONFIRME PARA INICIAR A IMPORTACAO DE DADOS"
	
	While .T.
		n_Opc := Menuh({"Confirma","Parametros","Abandona"},17,04,"b/w,w+/n,r/w","CPA","",2)
		
		If n_Opc == 3 .or. Lastkey()==27
			Return
		Endif
		
		If n_Opc == 2
			Pergunte(cPerg,.T.)
			Loop
		Endif
		
		Exit
	End
	RECEBER()
#ELSE
	@ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
	@ 008,010 TO 100,222
	@ 023,014 SAY "Este programa fara a recepcao Bancaria das cobrancas "
	@ 033,014 SAY "vindas do Banco Real"
	
	@ 063,014 SAY "CONFIRME PARA INICIAR A IMPORTACAO DE DADOS         "
	
	@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar()// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==>    @ 110,138 BMPBUTTON TYPE 1 ACTION Execute(Iniciar)
	@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
	@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
	
	ACTIVATE DIALOG oDlg1 CENTERED
#ENDIF

Return


*-----------------*
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function Iniciar
Static Function Iniciar()
*-----------------*
Close(oDlg1)
Processa( {|| Receber() })// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Processa( {|| Execute(Receber) })
Return

*------------------*
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function Receber
Static Function Receber()
*------------------*

_cArq  := "\arquivos\retorno\"+mv_par01

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Verificando se o arquivo a ser importado existe             ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

If !File( allTrim( _cArq ))
	Help(" ",1,"ARRVAZ")
	Return
endif
Gerar()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criando estrutura para arquivo temporario                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ              ;

Static Function Gerar()
_aStrurel := {}  //REGISTRO relatorio
AADD( _aStrurel, { "SINDICATO"  , "C" , 002 , 0 } )
AADD( _aStrurel, { "NATUREZA"   , "C" , 009 , 0 } )
AADD( _aStrurel, { "xDATA"       , "D" , 008 , 0 } )
AADD( _aStrurel, { "CNPJ"    	, "C" , 014 , 0 } )
AADD( _aStrurel, { "NOME"       , "C" , 040 , 0 } )
AADD( _aStrurel, { "VENCIMENTO" , "D" , 008 , 0 } )
AADD( _aStrurel, { "numban"     , "C" , 013 , 0 } )
AADD( _aStrurel, { "PREFIXO"    , "C" , 003 , 0 } )
AADD( _aStrurel, { "NUMTIT"     , "C" , 006 , 0 } )
AADD( _aStrurel, { "VALOR"      , "N" , 011 , 2 } )
AADD( _aStrurel, { "VLRRECEB"   , "N" , 011 , 2 } )
AADD( _aStrurel, { "VLRcred "   , "N" , 011 , 2 } )
AADD( _aStrurel, { "SITUACAO"   , "C" , 002 , 0 } )
AADD( _aStrurel, { "ARQUIVO"    , "C" , 012 , 0 } )
AADD( _aStrurel, { "HISTORICO"  , "C" , 030 , 0 } )
c_ArqREL := CriaTrab(_aStruREL,.t.)
dbUseArea(.t.,,c_ArqREL,"REL")
INDE ON SINDICATO+natureza+dtos(xdata) TO &C_ARQREL 
_nTotal:= 0		 // totalizador de registros
_nTotal2:= 0		 // totalizador de termos confed.
_nTotal3:= 0		 // totalizador avulsos confed.
_nTotJur:= 0		 // totalizador de juros recebidos (associativa)
_aStru := {}

AADD( _aStru, { "COD_REGIST"  , "C" , 001 , 0 } )
AADD( _aStru, { "CAMPO"       , "C" , 399 , 0 } )

c_ArqTmp := CriaTrab(_aStru,.t.)
dbUseArea(.t.,,c_ArqTmp,"TMP")
dbSelectArea("TMP")

Append From &(alltrim(_cArq)) SDF
dbGotop()
ProcRegua(RecCount(),22,05)
if TMP->COD_REGIST == "0"  //registro Header
	//	if substr( TMP->CAMPO,32,7) $ "7710534/5005542/"  // COBRANCA ASSOCIATIVA/ASSOCIATIVA CONFEDERATIVA
	if substr( TMP->CAMPO,32,7) $ "7710534/6066347/5005542/6070107/8070106/1070104/0070105/3070103/6072648/4072649/8072647/0072646/8072650/9000205/9000333/9000040/9000245/9000099/9000411/9000404/9000046/9000329/9000412" .or.  substr( TMP->CAMPO,31,7) $ "7710534/6066347/5005542/6070107/8070106/1070104/0070105/3070103/6072648/4072649/8072647/0072646/8072650/9000205/9000333/9000040/9000245/9000099/9000411/9000404/9000046/9000329/9000412" // COBRANCA ASSOCIATIVA/ASSOCIATIVA CONFEDERATIVA
		_dataproc := ctod(substr(TMP->CAMPO,94,2)+"/"+substr(TMP->CAMPO,96,2)+"/"+substr(TMP->CAMPO,98,2))
		_cPeriodo := substr(TMP->CAMPO,98,2) + substr(TMP->CAMPO,96,2)
		_cMes	:= substr(TMP->CAMPO,96,2) + "/" + substr(TMP->CAMPO,98,2)
		_cLote	:= "8000"
		dbskip()
		while !eof() .and. TMP->COD_REGIST == "1"
			IncProc(_cTitulo)
			if  substr(TMP->CAMPO,108,2) =="06" //LIQUIDACAO NORMAL
				//				if substr( TMP->CAMPO,46,4) $ "0000" //"8000"   && Boleto Avulso
				//					Baixa_Avulso()
				//					dbSelectArea("TMP")
				//					dbskip()
				//					loop
				//				Endif
				if !substr( TMP->CAMPO,46,4) $ "8000/7000"   && Boleto Avulso
					if subs(tmp->campo,62,3)="000"
						DBSELECTAREA("SE1")
						dbOrderNickName('18')  // dbSetOrder(18) // Alterado (UPDXFUN).
						dbseek( xFilial()+"80000"+substr(TMP->CAMPO,62,8))
						IF !FOUND()
							DBSELECTAREA("SZ9")
							DBSETORDER(1)
							DBSEEK(XFILIAL()+"80000"+substr(TMP->CAMPO,62,8))
							IF FOUND()
								dbSelectArea("SE1")  //GERANDO Baixa para Boleto avulso Associativa (se houver)
								dbSETORDER(1)  // dbSetOrder(18) // Alterado (UPDXFUN).
								dbseek(xfilial()+ SZ9->Z9_E1NUM)
							ENDIF
						ENDIF
					else
						
						dbSelectArea("SA1")
						dbOrderNickName('8')  // dbSetOrder(8) // Alterado (UPDXFUN).
						dbseek( xFilial() + STRzero ( VAL ( substr ( TMP->CAMPO,41, 4 ) ) , 6 ) )
						if eof()
							dbSetOrder(8) // Atencao (UPDXFUN).
							dbSelectArea("TMP")
							dbskip()
							loop
						endif
						
						dbSelectArea("SE1")  //GERANDO Contas a receber
						dbSetOrder(1) //// E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
						if dbseek( xFilial()+substr( TMP->CAMPO,62,2)+" "+substr ( TMP->CAMPO,64, 2 )+substr ( TMP->CAMPO,66, 4 )  +"E"+"DP")
							if SE1->E1_STATUS <> "B"
								Baixa_Promo()
							endif
							dbSelectArea("TMP")
							dbskip()
							loop
						EndIf
						
						dbSelectArea("SE1")  //GERANDO Contas a receber
						dbSetOrder(1) //// E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
						if dbseek( xFilial()+substr( TMP->CAMPO,150,2)+" "+substr ( TMP->CAMPO,148, 2 )+substr ( TMP->CAMPO,62, 4 )  +"E"+"DP")
							if SE1->E1_STATUS <> "B"
								Baixa_Promo()
							endif
							dbSelectArea("TMP")
							dbskip()
							loop
						EndIf
//						dbseek( xFilial()+substr( TMP->CAMPO,150,2)+" "+substr ( TMP->CAMPO,148, 2 )+substr ( TMP->CAMPO,62, 4 )  +" "+"DP")
//						if !found()
							dbseek( xFilial()+substr( TMP->CAMPO,62,2)+" "+substr ( TMP->CAMPO,64, 2 )+substr ( TMP->CAMPO,66, 4 )  +" "+"DP")
//						endif
						_nRecno:= recno()
						_cPrefixo:= " "
						if SE1->E1_STATUS == "B"
							dbseek( xFilial()+substr( TMP->CAMPO,62,2)+" "+substr ( TMP->CAMPO,64, 2 )+substr ( TMP->CAMPO,66, 4 )  +" "+"DP")
							if eof()
								_cPrefixo:= "D"
							else
								dbgoto( _nRecno )
							endif
						endif
						_lMovimenta := .T.
					endif
				ELSE
					DBSELECTAREA("SE1")
					dbOrderNickName('18')  // dbSetOrder(18) // Alterado (UPDXFUN).
					dbseek( xFilial()+SUBS(TMP->CAMPO,46,13))
					IF !FOUND()
						DBSELECTAREA("SZ9")
						DBSETORDER(1)
						DBSEEK(XFILIAL()+substr(TMP->CAMPO,46,13))
						IF FOUND()
							dbSelectArea("SE1")  //GERANDO Baixa para Boleto avulso Associativa (se houver)
							dbSETORDER(1)  // dbSetOrder(18) // Alterado (UPDXFUN).
							dbseek(xfilial()+ SZ9->Z9_E1NUM)
						ENDIF
					ENDIF
				ENDIF
				if eof() .AND. substr( TMP->CAMPO,46,4) <>"8000"
					RecLock("SE1",.T.)
					SE1->E1_FILIAL   := xFilial()
					SE1->E1_PREFIXO  := substr( TMP->CAMPO,46,2)+_cPrefixo
					SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM") //substr(TMP->CAMPO,49,6)
					SE1->E1_PARCELA  := ""
					SE1->E1_TIPO     := "DP"
					SE1->E1_NATUREZ  := "" //RTRIM( MV_PAR02 )
					SE1->E1_CLIENTE  := SA1->A1_COD
					SE1->E1_SINDICA  := SA1->A1_SINDICA
					SE1->E1_CODASSO  := SA1->A1_CODASSO
					SE1->E1_CGC	 := SA1->A1_CGC
					SE1->E1_CATEG1	 := SA1->A1_CATEG1
					SE1->E1_ERSIN	 := SA1->A1_ERSIN
					SE1->E1_LOJA     := SA1->A1_LOJA
					SE1->E1_NOMCLI	 := SA1->A1_NOME
					SE1->E1_EMISSAO  := ctod("01"+ "/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					SE1->E1_VENCTO   := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					SE1->E1_VENCREA  := DataValida( ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2)),.t.)
					SE1->E1_VALOR    := val( substr(TMP->CAMPO,152,13) )/100
					se1->e1_dtcred  := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					se1->e1_valcred  := val( substr(TMP->CAMPO,152,13) )/100
					SE1->E1_EMIS1    := ctod("01"+ "/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					_nSaldo := (val( substr(TMP->CAMPO,152,13) )/100)-(val( substr(TMP->CAMPO,253,13))/100)
					SE1->E1_SALDO    := if(_nSaldo <0,0,_nsaldo)
					SE1->E1_VLCRUZ   := val( substr(TMP->CAMPO,152,13) )/100
					SE1->E1_VALJUR   := 1
					SE1->E1_VENCORI  := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					SE1->E1_MOEDA    := 1
					SE1->E1_HIST     := "Ref.Contr.Assoc. de "+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2)
					//APOS BORDERO
					SE1->E1_PORTADO := "" //Rtrim( MV_PAR03 )
					SE1->E1_AGEDEP	 :="" //Rtrim( MV_PAR04 ) // 1874
					SE1->E1_CONTA   := "" //Rtrim( MV_PAR05 )//"7710534"
					SE1->E1_MOVIMEN :=  ctod("01"+ "/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					SE1->E1_SITUACA := "1"
					SE1->E1_OCORREN := "01"
					SE1->E1_ORIGEM  := "FINA040"
					SE1->E1_STATUS  := "B"
					SE1->E1_JUROS	:= val( substr(TMP->CAMPO,266,13))/100
					SE1->E1_VALLIQ	:= val( substr(TMP->CAMPO,253,13))/100
					SE1->E1_BAIXA   := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					SE1->E1_OK	:= CHR(69)+CHR (120)
					SE1->E1_ARQBCO  := MV_PAR01
					SE1->E1_CONFED	:= substr(TMP->CAMPO,46,13)
					//					se1->e1_dtcred  := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					//					se1->e1_valcred  := val( substr(TMP->CAMPO,152,13) )/100
					
					_nTotal:= _nTotal + SE1->E1_VALLIQ
					_nTotJur:= _nTotJur + SE1->E1_JUROS
					MsUnlock()
					dbselectarea("rel")
					reclock("rel",.t.)
					rel->SINDICATO := se1->e1_sindica
					rel->NATUREZA  := se1->e1_naturez
					rel->xDATA      := se1->e1_dtcred
					rel->CNPJ      := sa1->a1_cgc
					rel->NOME      := sa1->a1_nome
					rel->VENCIMENTO:= se1->e1_vencto
					rel->numban    := se1->e1_confed
					rel->PREFIXO   := se1->e1_prefixo
					rel->NUMTIT    := se1->e1_num
					rel->VALOR     := se1->e1_valor
					rel->VLRRECEB  := se1->e1_valliq
					rel->VLRcred   := se1->e1_valcred
					rel->SITUACAO  := sa1->a1_situac
					rel->ARQUIVO   := se1->e1_arqbco
					rel->HISTORICO := se1->e1_hist
					msunlock()					
					dbselectarea("se1")
				elseif SE1->E1_SALDO == 0
					_lMovimenta := .f.
				else
					DBSELECTAREA("SE1")
					Reclock( "SE1",.F.)
					SE1->E1_STATUS  := "B"
					_nSaldo := (val( substr(TMP->CAMPO,152,13) )/100)-(val( substr(TMP->CAMPO,253,13))/100)
					SE1->E1_SALDO    := if(_nSaldo <0,0,_nsaldo)
					IF SE1->E1_VALOR >= 0 .AND. SE1->E1_VALOR < 0.02
						SE1->E1_VALOR := val( substr(TMP->CAMPO,152,13) )/100
						SE1->E1_SALDO := 0
					ENDIF
					SE1->E1_JUROS    := val( substr(TMP->CAMPO,266,13))/100
					SE1->E1_VALLIQ   := val( substr(TMP->CAMPO,253,13))/100
					SE1->E1_BAIXA   := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					SE1->E1_OK       := CHR(69)+CHR (120)
					SE1->E1_ARQBCO  := MV_PAR01
					SE1->E1_CONFED	:= substr(TMP->CAMPO,46,13)
					se1->e1_dtcred  := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					se1->e1_valcred  := val( substr(TMP->CAMPO,152,13) )/100
					if subs(tmp->campo,62,3)="000"
						SE1->E1_CONFED :="80000"+substr(TMP->CAMPO,62,8)
					ELSE	
						SE1->E1_CONFED :="00000"+substr( TMP->CAMPO,62,2)+substr ( TMP->CAMPO,64, 2 )+substr ( TMP->CAMPO,66, 4 )
					ENDIF
					_nTotal:= _nTotal + SE1->E1_VALLIQ
					MsUnlock()
					dbselectarea("sa1")
					dbsetorder(1)
					dbseek(xfilial()+se1->e1_cliente+se1->E1_LOJA)
					dbselectarea("rel")
					reclock("rel",.t.)
					rel->SINDICATO := se1->e1_sindica
					rel->NATUREZA  := se1->e1_naturez
					rel->xDATA      := se1->e1_dtcred
					rel->CNPJ      := sa1->a1_cgc
					rel->NOME      := sa1->a1_nome
					rel->VENCIMENTO:= se1->e1_vencto
					rel->numban    := se1->e1_confed
					rel->PREFIXO   := se1->e1_prefixo
					rel->NUMTIT    := se1->e1_num
					rel->VALOR     := se1->e1_valor
					rel->VLRRECEB  := se1->e1_valliq
					rel->VLRcred   := se1->e1_valcred
					rel->SITUACAO  := sa1->a1_situac
					rel->ARQUIVO   := se1->e1_arqbco
					rel->HISTORICO := se1->e1_hist
					msunlock()					
					dbselectarea("se1")
				endif
				dbselectArea("SE5")
				if val( substr(TMP->CAMPO,266,9)) > 0 .and. _lMovimenta
					recLock("SE5",.T.)
					SE5->E5_FILIAL  := xFilial()
					SE5->E5_DATA    := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					SE5->E5_TIPO    := "DP"
					SE5->E5_VALOR   := val( substr(TMP->CAMPO,253,13))/100
					SE5->E5_NATUREZ := "" //RTRIM( MV_PAR02 )
					SE5->E5_BANCO   := "" //Rtrim( MV_PAR03 )
					SE5->E5_AGENCIA := "" //Rtrim( MV_PAR04 )//1874
					SE5->E5_CONTA   := "" //Rtrim( MV_PAR05 )//"7710534"
					SE5->E5_RECPAG  := "R"
					SE5->E5_BENEF   := SA1->A1_NREDUZ
					SE5->E5_HISTOR  := "Juros s/Receb.Titulo"
					SE5->E5_TIPODOC := "JR"
					SE5->E5_VLMOED2 := val( substr(TMP->CAMPO,253,13))/100
					SE5->E5_LA      := "N"
					SE5->E5_NUMERO  := "1"
					SE5->E5_CLIFOR  := SA1->A1_COD
					SE5->E5_LOJA    := SA1->A1_LOJA
					SE5->E5_DTDIGIT := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					SE5->E5_MOTBX   := "NOR"
					SE5->E5_SEQ     := "01"
					SE5->E5_PREFIXO :=  substr( TMP->CAMPO,46,2)+_cPrefixo
					SE5->E5_NUMERO  :=  substr(TMP->CAMPO,49,6)
					SE5->E5_DTDISPO := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					MsUnlock()
				endif
				if _lMovimenta
					recLock("SE5",.T.)
					SE5->E5_FILIAL  := xFilial()
					SE5->E5_DATA    := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					SE5->E5_TIPO    := "DP"
					SE5->E5_VALOR   := val( substr(TMP->CAMPO,253,13))/100
					SE5->E5_NATUREZ := "" //RTRIM( MV_PAR02 )
					SE5->E5_BANCO   := "" //Rtrim( MV_PAR03 )
					SE5->E5_AGENCIA := "" //Rtrim( MV_PAR04 )// 1874
					SE5->E5_CONTA   := "" //Rtrim( MV_PAR05 )//"7710534"
					SE5->E5_RECPAG  := "R"
					SE5->E5_BENEF   := SA1->A1_NREDUZ
					SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
					SE5->E5_TIPODOC := "VL"
					SE5->E5_VLMOED2 := val( substr(TMP->CAMPO,253,13))/100
					SE5->E5_LA      := "N"
					SE5->E5_NUMERO  := "1"
					SE5->E5_CLIFOR  := SA1->A1_COD
					SE5->E5_LOJA    := SA1->A1_LOJA
					SE5->E5_DTDIGIT := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					SE5->E5_MOTBX   := "NOR"
					SE5->E5_SEQ     := "01"
					SE5->E5_PREFIXO := substr( TMP->CAMPO,46,2)+_cPrefixo
					SE5->E5_NUMERO  := substr(TMP->CAMPO,49,6)
					SE5->E5_DTDISPO := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					MsUnlock()
				endif
			endif
			dbSelectArea("TMP")
			dbskip()
		enddo
		//	elseif substr( TMP->CAMPO,32,7) == "7713319" .or. substr( TMP->CAMPO,32,7) == "1001714" .or. substr( TMP->CAMPO,32,7) == "6713328" .or. substr( TMP->CAMPO,32,7) =="9721760" //Cobranca Confederativa/Assistencial
	elseif substr( TMP->CAMPO,32,7) $ "9721760/7713319/1066389/1001714/6713328/0067611" //Cobranca Confederativa/Contributiva/Contratos
		_dataproc := ctod(substr(TMP->CAMPO,94,2)+"/"+substr(TMP->CAMPO,96,2)+"/"+substr(TMP->CAMPO,98,2))
		_cPeriodo := substr(TMP->CAMPO,98,2) + substr(TMP->CAMPO,96,2)
		_cMes	:= substr(TMP->CAMPO,96,2) + "/" + substr(TMP->CAMPO,98,2)
		//		_cLote	:= iif(val(substr( TMP->CAMPO,32,7)) == 7713319 .or. val(substr( TMP->CAMPO,32,7)) == 6713328,"7000","9000")
		//		_cLote	:= iif(val(substr( TMP->CAMPO,32,7)) == 9721760,"7100",_cLote)
		_cConta := substr( TMP->CAMPO,32,7)
		_cLote	:= iif( _cConta $ "7713319/1066389/6713328", "7000","9000")
		_cLote	:= iif( _cConta $ "9721760/0067611", "7100","9000")
		dbskip()
		dbSelectArea("TMP")
		while !eof() .and. TMP->COD_REGIST == "1"
			IncProc(_cTitulo)
			_cConta := substr( TMP->CAMPO,23,7)
			if  substr(TMP->CAMPO,108,2) =="06" //LIQUIDACAO NORMAL
				_cCGC  := ""
				_dVENC := ctod("")
				_nPREF := ""
				_nPARC := ""
				dbSelectArea("SZ9")
				if dbseek( xFilial()+substr(TMP->CAMPO,46,13) ) // Num_tit
					_cCGC  := SZ9->Z9_CGC
					_dVenc := SZ9->Z9_VENCTO
					_nPREF := SUBS(SZ9->Z9_PARCELA,1,3)
					_nPARC := substr( SZ9->Z9_PARCELA,4,1)
				else
					_cCGC   := "99"   && Boleto Avulso / Termo
				endif
				if empty( _cCGC )
					dbSelectArea("TMP")
					dbskip()
					loop
				endif
				if _cCGC <> "99"
					dbSelectArea("SA1")
					dbSetOrder(3)
					dbseek( xFilial()+ _cCGC )
					if eof()
						dbSetOrder(1) // Atencao (UPDXFUN).
						dbSelectArea("TMP")
						dbskip()
						loop
					endif
				endif
				dbSelectArea("SE1")  //GERANDO Contas a receber
				dbOrderNickName('18')  // dbSetOrder(18) // Alterado (UPDXFUN).
				dbseek( xFilial()+substr(TMP->CAMPO,46,13) )
				_lMovimenta:=.f.
				if eof() .and. _cCGC <> "99"    && Gera titulo se nao existe (Recepcao normal)
					_lMovimenta := .T.
					
					RecLock("SE1",.T.)
					SE1->E1_FILIAL   := xFilial()
					SE1->E1_PREFIXO  := _nPREF
					SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
					SE1->E1_PARCELA  := _nPARC
					SE1->E1_TIPO     := "DP"
					//					SE1->E1_NATUREZ  := iif( val(_cConta) == 7713319 .or. val(_cConta) == 6713328 ,"002","009")
					SE1->E1_NATUREZ  := iif( _cConta $ "7713319/1066389/6713328" ,"002","009")
					//					if ( val(_cConta) == 9721760 )
					if ( _cConta $ "9721760/0067611" )
						SE1->E1_NATUREZ  := "0327"
					EndIf
					SE1->E1_CLIENTE  := SA1->A1_COD
					SE1->E1_SINDICA  := SA1->A1_SINDICA
					SE1->E1_CODASSO  := SA1->A1_CODASSO
					SE1->E1_CGC	 := SA1->A1_CGC
					SE1->E1_CATEG1	 := SA1->A1_CATEG1
					SE1->E1_ERSIN	 := SA1->A1_ERSIN
					SE1->E1_LOJA     := SA1->A1_LOJA
					SE1->E1_NOMCLI	 := SA1->A1_NOME
					SE1->E1_EMISSAO  := ctod("01"+ "/"+substr(dtos(_dVenc),5,2)+"/"+substr(dtos(_dVenc),3,2))
					SE1->E1_MOVIMEN  := ctod("01"+ "/"+substr(dtos(_dVenc),5,2)+"/"+substr(dtos(_dVenc),3,2))
					SE1->E1_EMIS1    := ctod("01"+ "/"+substr(dtos(_dVenc),5,2)+"/"+substr(dtos(_dVenc),3,2))
					SE1->E1_VENCTO   := _dVenc
					SE1->E1_VENCREA  := DataValida( _dVenc )
					SE1->E1_VENCORI  := _dVenc
					SE1->E1_HIST     := "Ref.Contr. de "+ substr(dtos( _dVenc ),5,2)+"/"+substr(dtos(_dVenc),3,2)
					SE1->E1_VALOR    := val( substr(TMP->CAMPO,253,13) )/100
					se1->e1_dtcred  := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					se1->e1_valcred  := val( substr(TMP->CAMPO,152,13) )/100
					SE1->E1_SALDO    := 0
					SE1->E1_VLCRUZ   := val( substr(TMP->CAMPO,253,13) )/100
					SE1->E1_VALJUR   := 0
					SE1->E1_MOEDA    := 1
					//APOS BORDERO
					SE1->E1_PORTADO := "356"
					SE1->E1_AGEDEP	:= "0409" //1874
					SE1->E1_CONTA   := _cConta
					SE1->E1_SITUACA := "1"
					SE1->E1_OCORREN := "01"
					SE1->E1_ORIGEM  := "RFINA112"
					SE1->E1_STATUS  := "B"
					SE1->E1_JUROS   := 0
					SE1->E1_VALLIQ  := val( substr(TMP->CAMPO,253,13))/100
					SE1->E1_BAIXA   := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					SE1->E1_OK      := CHR(69)+CHR (120)
					SE1->E1_CONFED	:= substr(TMP->CAMPO,46,13)
					//					se1->e1_dtcred  := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					//					se1->e1_valcred  := val( substr(TMP->CAMPO,152,13) )/100
					
					SE1->E1_ARQBCO  := MV_PAR01
					_nTotal:= _nTotal + SE1->E1_VALLIQ
					
					MSUNLOCK()
					CONFIRMSX8()
					dbselectarea("rel")
					reclock("rel",.t.)
					rel->SINDICATO := se1->e1_sindica
					rel->NATUREZA  := se1->e1_naturez
					rel->xDATA      := se1->e1_dtcred
					rel->CNPJ      := sa1->a1_cgc
					rel->NOME      := sa1->a1_nome
					rel->VENCIMENTO:= se1->e1_vencto
					rel->numban    := se1->e1_confed
					rel->PREFIXO   := se1->e1_prefixo
					rel->NUMTIT    := se1->e1_num
					rel->VALOR     := se1->e1_valor
					rel->VLRRECEB  := se1->e1_valliq 
					rel->VLRcred   := se1->e1_valcred
					rel->SITUACAO  := sa1->a1_situac
					rel->ARQUIVO   := se1->e1_arqbco
					rel->HISTORICO := se1->e1_hist
					msunlock()					
										dbselectarea("se1")
				else
					_altconf:=.f.
					Do While alltrim(SE1->E1_CONFED)==alltrim(substr(TMP->CAMPO,46,13)) .and. .not. eof()
						_tConta:=""	  && Verifica qual conta se refere a baixa
						if alltrim(substr(SE1->E1_PREFIXO,3,1))=="A" .or. substr(SE1->E1_PREFIXO,3,1)==" "
							//							_tConta:="7713319"
							_tConta:="1066389"
						endif
						if alltrim(substr(SE1->E1_PREFIXO,3,1))=="T"
							_tConta:="6713328"
						endif
						//						if (val(_cConta) == 9721760)   && Contratos
						if (_cConta $ "9721760/0067611")   && Contratos
							//							_tConta:="9721760"
							_tConta:="0067611"
							_altconf:=.t.
						EndIf
						if val(_cConta)==val(_tConta)
							_altconf:=.t.
							exit
						endif
						dbskip()
					EndDo
					if _altconf
						Reclock( "SE1",.F.)	&& Altera titulo se existe (Boleto Avulso/Termo)
						SE1->E1_STATUS  := "B"
						SE1->E1_JUROS   := 0
						&& Coloca valor no titulo Confederativa
						SE1->E1_SALDO   := SE1->E1_SALDO-val( substr(TMP->CAMPO,253,13) )/100
						if _cCGC=="99"
							SE1->E1_VALOR    := val( substr(TMP->CAMPO,253,13) )/100
							SE1->E1_SALDO    := 0
							SE1->E1_VLCRUZ   := val( substr(TMP->CAMPO,253,13) )/100
						endif
						IF SE1->E1_VALOR >= 0 .AND. SE1->E1_VALOR < 0.02
							SE1->E1_VALOR    := val( substr(TMP->CAMPO,253,13) )/100
							SE1->E1_SALDO    := 0
						ENDIF
						SE1->E1_VALLIQ  := val( substr(TMP->CAMPO,253,13))/100
						SE1->E1_BAIXA   := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
						SE1->E1_OK      := CHR(69)+CHR (120)
						SE1->E1_PORTADO := "356"
						SE1->E1_AGEDEP  := "0409" //1874
						SE1->E1_CONTA   := _tConta
						SE1->E1_SITUACA := "1"
						SE1->E1_OCORREN := "01"
						SE1->E1_ORIGEM  := "RFINA112"
						SE1->E1_CONFED	:= substr(TMP->CAMPO,46,13)
						SE1->E1_ARQBCO  := MV_PAR01
						se1->e1_dtcred  := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
						se1->e1_valcred  := val( substr(TMP->CAMPO,152,13) )/100
						
						if _tConta $ "7713319/1066389"
							_nTotal:= _nTotal + SE1->E1_VALLIQ     && Total de pagtos confed.
						EndIf
						if _tConta=="6713328"
							_nTotal2:= _nTotal2 + SE1->E1_VALLIQ    && Total de termos
						EndIf
						if _tConta $ "9721760/0067611"
							_nTotal3:= _nTotal3 + SE1->E1_VALLIQ    && Total de contratos Stas Casas
						EndIf
						MsUnlock()
						_lMovimenta:=.t.
					dbselectarea("sa1")
					dbsetorder(1)
					dbseek(xfilial()+se1->e1_cliente+se1->E1_LOJA)
					dbselectarea("rel")
					reclock("rel",.t.)
					rel->SINDICATO := se1->e1_sindica
					rel->NATUREZA  := se1->e1_naturez
					rel->xDATA      := se1->e1_dtcred
					rel->CNPJ      := sa1->a1_cgc
					rel->NOME      := sa1->a1_nome
					rel->VENCIMENTO:= se1->e1_vencto
					rel->numban    := se1->e1_confed
					rel->PREFIXO   := se1->e1_prefixo
					rel->NUMTIT    := se1->e1_num
					rel->VALOR     := se1->e1_valor
					rel->VLRRECEB  := se1->e1_valliq
					rel->VLRcred   := se1->e1_valcred
					rel->SITUACAO  := sa1->a1_situac
					rel->ARQUIVO   := se1->e1_arqbco
					rel->HISTORICO := se1->e1_hist
					msunlock()					

					else
						_lMovimenta:=.f.
					endif                                  
										dbselectarea("se1")
				endif
				dbselectArea("SE5")
				if _lMovimenta
					recLock("SE5",.T.)
					SE5->E5_FILIAL  := xFilial()
					SE5->E5_DATA    := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
					SE5->E5_TIPO    := "DP"
					SE5->E5_VALOR   := val( substr(TMP->CAMPO,253,13))/100
					//					SE5->E5_NATUREZ := iif( val(_cConta) == 7713319 .or. val(_cConta) == 6713328,"002","009")
					SE5->E5_NATUREZ := iif( _cConta $ "7713319/1066389/6713328" ,"002","009")
					//					if ( val(_cConta) == 9721760)
					if ( _cConta $ "9721760/0067611" )
						SE5->E5_NATUREZ  := "0327"
					EndIf
					SE5->E5_BANCO   := "356"
					SE5->E5_AGENCIA := "0409" //1874
					SE5->E5_CONTA   := _cConta
					SE5->E5_RECPAG  := "R"
					SE5->E5_BENEF   := SA1->A1_NREDUZ
					SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
					SE5->E5_TIPODOC := "VL"
					SE5->E5_VLMOED2 := val( substr(TMP->CAMPO,253,13))/100
					SE5->E5_LA      := "N"
					SE5->E5_CLIFOR  := SA1->A1_COD
					SE5->E5_LOJA    := SA1->A1_LOJA
					SE5->E5_DTDIGIT := dDATABASE
					SE5->E5_MOTBX   := "NOR"
					SE5->E5_SEQ     := "01"
					SE5->E5_PREFIXO := _nPREF
					SE5->E5_NUMERO  :=  SA1->A1_COD
					SE5->E5_PARCELA := _nPARC
					SE5->E5_DTDISPO := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
					MsUnlock()
				endif
			endif
			dbSelectArea("TMP")
			dbskip()
		enddo
	endif
	
	/* CONTABILIZAR PARA CTB
	
	dbselectArea("SI2")
	dbsetorder(3)
	dbseek( xFilial() + dtos(_dataproc) + _cLote )
	if _nTotal > 0 .and. eof()
	recLock("SI2",.T.)
	SI2->I2_FILIAL := "01"
	SI2->I2_NUM    := _cLote + "001"
	SI2->I2_LINHA  := "01"
	SI2->I2_DATA   := _dataproc
	SI2->I2_DC     := "X"
	SI2->I2_MOEDAS := "SNNNN"
	SI2->I2_VALOR  := _nTotal
	SI2->I2_DTVENC := _dataproc
	SI2->I2_ROTINA := "RFINA112"
	SI2->I2_PERIODO:= _cPeriodo
	SI2->I2_ORIGEM := "L.GER P/RFINA112"
	SI2->I2_FILORIG:= "01"
	if _cLote == "8000"
	SI2->I2_DEBITO := "1112020001"
	SI2->I2_CREDITO:= "1123010001"
	SI2->I2_HIST	:= "RECEB. DE CONT. ASSOCIATIVA - " + _cmes
	if _nTotJur > 0
	MsUnlock()
	recLock("SI2",.T.)
	SI2->I2_FILIAL := "01"                 && Juros recebidos
	SI2->I2_NUM    := _cLote + "001"
	SI2->I2_LINHA  := "02"
	SI2->I2_DATA   := _dataproc
	SI2->I2_DC     := "X"
	SI2->I2_MOEDAS := "SNNNN"
	SI2->I2_VALOR  := _nTotJur
	SI2->I2_DTVENC := _dataproc
	SI2->I2_ROTINA := "RFINA112"
	SI2->I2_PERIODO:= _cPeriodo
	SI2->I2_ORIGEM := "L.GER P/RFINA112"
	SI2->I2_FILORIG:= "01"
	SI2->I2_DEBITO := "1112020001"
	SI2->I2_CREDITO:= "3111040002"
	SI2->I2_HIST   := "RECEB. DE JUROS CONTR. ASSOC. - " + _cmes
	endif
	elseif _cLote == "7000"
	SI2->I2_DEBITO := "1112020006"
	SI2->I2_CREDITO:= "3111010001"
	SI2->I2_HIST	:= "RECEB. DE CONT. CONFEDERATIVA - " + _cmes
	endif
	MsUnlock()
	endif
	dbselectArea("SI2")
	dbsetorder(3)
	dbseek( xFilial() + dtos(_dataproc) + "7010" )
	if _nTotal2 > 0 .and. eof()
	recLock("SI2",.T.)
	SI2->I2_FILIAL := "01"
	SI2->I2_NUM    := "7010" + "001"
	SI2->I2_LINHA  := "01"
	SI2->I2_DATA   := _dataproc
	SI2->I2_DC     := "X"
	SI2->I2_MOEDAS := "SNNNN"
	SI2->I2_VALOR  := _nTotal2
	SI2->I2_DTVENC := _dataproc
	SI2->I2_ROTINA := "RFINA112"
	SI2->I2_PERIODO:= _cPeriodo
	SI2->I2_ORIGEM := "L.GER P/RFINA112"
	SI2->I2_FILORIG:= "01"
	
	SI2->I2_DEBITO := "1112020007"
	SI2->I2_CREDITO:= "3111010001"
	SI2->I2_HIST   := "RECEB. DE CONT. CONFED.Termos - " + _cmes
	
	MsUnlock()
	endif
	
	
	dbselectArea("SI2")
	dbsetorder(3)
	dbseek( xFilial() + dtos(_dataproc) + "7100" )
	
	if _nTotal3 > 0 .and. eof()
	
	recLock("SI2",.T.)
	SI2->I2_FILIAL := "01"
	SI2->I2_NUM    := "7100" + "001"
	SI2->I2_LINHA  := "01"
	SI2->I2_DATA   := _dataproc
	SI2->I2_DC     := "X"
	SI2->I2_MOEDAS := "SNNNN"                                                         /
	SI2->I2_VALOR  := _nTotal3
	SI2->I2_DTVENC := _dataproc
	SI2->I2_ROTINA := "RFINA112"
	SI2->I2_PERIODO:= _cPeriodo
	SI2->I2_ORIGEM := "L.GER P/RFINA112"
	SI2->I2_FILORIG:= "01"
	
	SI2->I2_DEBITO := "1112020019"
	SI2->I2_CREDITO:= "3111060012"
	SI2->I2_HIST   := "RECEB. DE Contratos Stas Casas  - " + _cmes
	
	MsUnlock()
	
	endif
	*/
	
endif

dbSelectArea("TMP")
dbCloseArea()

If File(c_ArqTmp+".DBF")
	Ferase(c_ArqTmp+".DBF")
EndIf                                     
IMPRELBX()
dbSelectArea("SA1")
dbSetOrder(1)

dbSelectArea("SE1")
dbSetOrder(1)

dbselectArea("SI2")
dbsetorder(1)

dbSelectArea(_oldArea)
dbSetOrder(_oldOrder) // Atencao (UPDXFUN).

// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> __return(nil)
Return(nil)        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04




// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function Baixa_Promo
Static Function Baixa_Promo()

&& Baixa Parcela Promocao

_lMovimenta := .T.

if SE1->E1_SALDO == 0
	_lMovimenta := .f.
else
	Reclock( "SE1",.F.)
	SE1->E1_STATUS  := "B"
	SE1->E1_JUROS    := val( substr(TMP->CAMPO,266,13))/100
	SE1->E1_VALLIQ   := val( substr(TMP->CAMPO,253,13))/100
	SE1->E1_BAIXA   := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
	_nSaldo := (val( substr(TMP->CAMPO,152,13) )/100)-(val( substr(TMP->CAMPO,253,13))/100)
	SE1->E1_SALDO    := if(_nSaldo <0,0,_nsaldo)
	SE1->E1_OK       := CHR(69)+CHR (120)
	_nTotal:= _nTotal + SE1->E1_VALLIQ
	MsUnlock()
endif

dbselectArea("SE5")

if val( substr(TMP->CAMPO,266,9)) > 0 .and. _lMovimenta
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial()
	SE5->E5_DATA    := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := val( substr(TMP->CAMPO,253,13))/100
	SE5->E5_NATUREZ := "001"
	SE5->E5_BANCO   := "356"
	SE5->E5_AGENCIA := "0409" //1874
	SE5->E5_CONTA   := "6066347" //"7710534"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Juros s/Receb.Titulo"
	SE5->E5_TIPODOC := "JR"
	SE5->E5_VLMOED2 := val( substr(TMP->CAMPO,253,13))/100
	SE5->E5_LA      := "N"
	SE5->E5_NUMERO  := "1"
	SE5->E5_CLIFOR  := SA1->A1_COD
	SE5->E5_LOJA    := SA1->A1_LOJA
	SE5->E5_DTDIGIT := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO :=  substr( TMP->CAMPO,46,2)+" "
	SE5->E5_NUMERO  :=  substr(TMP->CAMPO,49,6)
	SE5->E5_DTDISPO := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	MsUnlock()
endif
if _lMovimenta
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial()
	SE5->E5_DATA    := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := val( substr(TMP->CAMPO,253,13))/100
	SE5->E5_NATUREZ := "001"
	SE5->E5_BANCO   := "356"
	SE5->E5_AGENCIA := "0409" //1874
	SE5->E5_CONTA   := "6066347" //"7710534"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
	SE5->E5_TIPODOC := "VL"
	SE5->E5_VLMOED2 := val( substr(TMP->CAMPO,253,13))/100
	SE5->E5_LA      := "N"
	SE5->E5_NUMERO  := "1"
	SE5->E5_CLIFOR  := SA1->A1_COD
	SE5->E5_LOJA    := SA1->A1_LOJA
	SE5->E5_DTDIGIT := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := substr( TMP->CAMPO,46,2)+" "
	SE5->E5_NUMERO  := substr(TMP->CAMPO,49,6)
	SE5->E5_DTDISPO := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	MsUnlock()
endif

/* Desabilitado por Nava / Nilton - 20/09/07
// Baixa Parcelas Anteriores

dbselectArea("SE1")
dbSetOrder(19)

DbSeek(xfilial()+SA1->A1_CODASSO)

Do While SE1->E1_CODASSO==SA1->A1_CODASSO .and. .not. (eof())

if val(SE1->E1_NATUREZ)<>1
DbSkip()
Loop
EndIf

if SE1->E1_BAIXA<>CTOD(space(8))
DbSkip()
Loop
EndIf

if alltrim(SE1->E1_PREFIXO)=="01" .and. val(substr(SE1->E1_NUM,1,2))>7
DbSkip()
Loop
EndIf

if val(SE1->E1_PREFIXO)<95 .and. val(SE1->E1_PREFIXO)>1
DbSkip()
Loop
EndIf

Reclock( "SE1",.F.)
SE1->E1_STATUS  := "B"
SE1->E1_BAIXA   := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
SE1->E1_SALDO   := 0
SE1->E1_VALLIQ  := 0.00
SE1->E1_OK      := CHR(69)+CHR(120)
SE1->E1_HIST    := "Baixa por pagto Promocao 07/2001"
MsUnlock()

DbSkip()

EndDo
*/

return(nil)



// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function Baixa_Avulso
Static Function Baixa_Avulso()

dbSelectArea("SE1")  //GERANDO Baixa para Boleto avulso Associativa (se houver)
dbOrderNickName('18')  // dbSetOrder(18) // Alterado (UPDXFUN).
dbseek( xFilial()+substr(TMP->CAMPO,46,13) )
_lMovimenta:=.f.

Do While SE1->E1_CONFED==substr(TMP->CAMPO,46,13) .and. SE1->E1_NATUREZ<>"001" .and. .not. eof()
	DbSkip()
EndDo

if eof() .or. SE1->E1_CONFED<>substr(TMP->CAMPO,46,13)
	
	Tone(800,2)
	Tone(1500,2)
	
	#IFNDEF WINDOWS
		DrawAdvWindow("ERRO!",010,010,021,069)
		SetColor("B/BG,N/W")
		@ 12,14 SAY "Titulo Avulso nao encontrado: "
		@ 14,14 SAY substr(TMP->CAMPO,46,13)
		Inkey(0)
	#ELSE
		@ 96,42 TO 290,405 DIALOG oDlg1 TITLE "ERRO!"
		@ 8,10 TO 68,170
		@ 23,22 SAY "Titulo Avulso nao encontrado: "
		@ 33,22 SAY substr(TMP->CAMPO,46,13)
		@ 77,078 BMPBUTTON TYPE 1 ACTION Close(oDlg1)
		ACTIVATE DIALOG oDlg1 CENTERED
	#ENDIF
	
	&&   _nTotal:= _nTotal + val( substr(TMP->CAMPO,253,13))/100
	&&   _nTotJur:= _nTotJur + val( substr(TMP->CAMPO,266,13))/100
	
elseif SE1->E1_SALDO == 0	 && Baixa Avulso se nao estiver ja baixado
	_lMovimenta := .f.
else
	Reclock( "SE1",.F.)
	SE1->E1_STATUS  := "B"
	SE1->E1_JUROS    := val( substr(TMP->CAMPO,266,13))/100
	if se1->e1_valor == 0
		se1->e1_valor := val( substr(TMP->CAMPO,253,13))/100-val( substr(TMP->CAMPO,266,13))/100
	endif
	SE1->E1_VALLIQ   := val( substr(TMP->CAMPO,253,13))/100
	SE1->E1_BAIXA   := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
	_nSaldo := (val( substr(TMP->CAMPO,152,13) )/100)-(val( substr(TMP->CAMPO,253,13))/100)
	SE1->E1_SALDO    := if(_nSaldo <0,0,_nsaldo)
	SE1->E1_ARQBCO  := MV_PAR01
	SE1->E1_OK       := CHR(69)+CHR (120)
	_nTotal:= _nTotal + SE1->E1_VALLIQ
	MsUnlock()
endif

dbselectArea("SE5")

if val( substr(TMP->CAMPO,266,9)) > 0 .and. _lMovimenta
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial()
	SE5->E5_DATA    := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := val( substr(TMP->CAMPO,253,13))/100
	SE5->E5_NATUREZ := "001"
	SE5->E5_BANCO   := "356"
	SE5->E5_AGENCIA := "0409" //1874
	SE5->E5_CONTA   := "6066347" //"7710534"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Juros s/Receb.Titulo"
	SE5->E5_TIPODOC := "JR"
	SE5->E5_VLMOED2 := val( substr(TMP->CAMPO,253,13))/100
	SE5->E5_LA      := "N"
	SE5->E5_NUMERO  := "1"
	SE5->E5_CLIFOR  := SA1->A1_COD
	SE5->E5_LOJA    := SA1->A1_LOJA
	SE5->E5_DTDIGIT := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO :=  _Pref
	SE5->E5_NUMERO  :=  _Num
	SE5->E5_DTDISPO := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	MsUnlock()
endif

if _lMovimenta
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial()
	SE5->E5_DATA    := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := val( substr(TMP->CAMPO,253,13))/100
	SE5->E5_NATUREZ := "001"
	SE5->E5_BANCO   := "356"
	SE5->E5_AGENCIA := "0409" //1874
	SE5->E5_CONTA   := "6066347" //"7710534"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
	SE5->E5_TIPODOC := "VL"
	SE5->E5_VLMOED2 := val( substr(TMP->CAMPO,253,13))/100
	SE5->E5_LA      := "N"
	SE5->E5_NUMERO  := "1"
	SE5->E5_CLIFOR  := SA1->A1_COD
	SE5->E5_LOJA    := SA1->A1_LOJA
	SE5->E5_DTDIGIT := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := _Pref
	SE5->E5_NUMERO  := _Num
	SE5->E5_DTDISPO := ctod(substr(TMP->CAMPO,295,2)+"/"+substr(TMP->CAMPO,297,2)+"/"+substr(TMP->CAMPO,299,2))
	MsUnlock()
endif

return(nil)

Static Function IMPRELBX()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ RELBXS   ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 12.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao relatorio de BAIXAS                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
SetPrvt("_CALIAS,CBCONT,CBTXT,WNREL,CDESC1,CDESC2")
SetPrvt("CDESC3,CSTRING,TAMANHO,TIPO,LIMITE,TITULO")
SetPrvt("CABEC2,CABEC1,ARETURN,NOMEPROG,NLASTKEY,CPERG")
SetPrvt("M_PAG,LI,_AESTR,C_ARQIMP,CARQIND,CINDSA1")
SetPrvt("NLINHA,")
_cAlias := alias()
cbcont := 0
cbtxt := ""
wnrel := ""
cDesc1 := "Este programa irá imprimir a relacao de baixas"
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Relacao de Baixas"
cabec2 := ""
cabec1 := ""
aReturn := { "Zebrado", 1,"Administracao", 4, 2, 1, "",1 }
nomeprog := cPerg                                                                                                
nLastkey := 0
m_pag := 1
li := 80
wnrel :=  cPerg
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)
if nLastkey == 27
    return
endif
SetDefault(aReturn,cString)
if nLastkey == 27
   return
endif
    RptStatus({|| impREL() },titulo)
    return


**********
Static function ImpREL()
cDesc1 := "Este programa irá imprimir a relacao de baixas"
cDesc2 := ""
cDesc3 := ""
String := "SE1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Relação de Baixas"
cabec2 := ""
CABEC1 := "Sind. Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Baixa  Vlr. Recebido Situacao No.Bancário   Arquivo "
li := 80
dbselectarea("rel")
dbgotop()
SetRegua(RecCount())
VALTIT := VALPG := QTDPG := 0

	CABEC1 := "Sind. Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Cred.  Vlr.  Credito Sit. No.Bancário    Arquivo             Historico"
	//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99,999,999.99 zz       x
	//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19
	xDATA := rel->xdata
	CPODATA := "REL->xDATA"
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
//li+= 2
VALTIT1:= VALPG1  := 	QTDPG1  := 0
VALTIT2:= VALPG2  := 	QTDPG2 := 0
VALTIT3:= VALPG3  := 	QTDPG3  := 0
VALTIT4:= VALPG4  := 	QTDPG4  := 0
VALTIT5:= VALPG5  := 	QTDPG5  := 0
VALTIT6:= VALPG6  := 	QTDPG6  := 0

while !eof()
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	XNATUREZA := REL->NATuREZA
	NATVALTIT := NATVALPG := NATQTDPG := 0
	DBSELECTAREA("SED")
	DBSETORDER(1)
	DBSEEK(XFILIAL()+REL->NATUREZA)
	@ LI,000 PSAY "NATUREZA: "+alLTRIM(REL->NATUREZA)+" "+SED->ED_DESCRIC
	LI+= 2
	dbselectarea("rel")
	DO WHILE !EOF() .AND. REL->NATUREZA == XNATUREZA
		datVALTIT := datVALPG := DATQTDPG := 0
		INCREGUA()
		if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		endif
			CABEC1 := "Sind. Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Cred.  Vlr.  Credito Situacao No.Bancário"
			//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99,999,999.99 zz       x
			//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
			//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        5
			
			XDATA := rel->xdata
			CPODATA := "rel->xdata"
			@ LI,000 PSAY "DATA: "+DTOC(rel->xdata)
		
		LI+= 2
		dbselectarea("rel")
		DO WHILE !EOF() .AND. &CPODATA == XDATA
			if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
			endif
/*	dbselectarea("szc")
			dbsetorder(2)
			dbseek(xfilial("SZC")+TRB->A1_ESCCONT)
			dbSelectArea("TMP")
			RECLOCK("TMP",.T.)
			TMP->CODIGO    := TRB->A1_COD
			TMP->NOME      := TRB->A1_NOME
			TMP->ENDERECO  := trb->a1_end
			TMP->BAIRRO    := trb->a1_bairro
			tmp->CEP       := trb->a1_cep
			TMP->CIDADE    := TRB->A1_MUN
			TMP->UF        := TRB->A1_EST
			tmp->cnpj      := trb->A1_CGC
			TMP->DTCADAS   := STOD(TRB->A1_DTCADAS)
			TMP->DTASSOC   := STOD(TRB->A1_DTINASS)
			TMP->TELEFONE  := TRB->A1_TEL
			TMP->CODASSO   := TRB->A1_CODASSO
			TMP->SITUACAO  := TRB->A1_SITUAC
			TMP->ERSIN     := TRB->A1_ERSIN
			TMP->CATEGORIA := TRB->A1_CATEG1 
			TMP->NATUREZA  := alltrim(TRB->e1_naturez)
			TMP->TITULO    := TRB->E1_PREFIXO+"-"+TRB->E1_NUM+"-"+TRB->E1_PARCELA
			TMP->VALORTIT  := TRB->E1_VALOR+trb->e1_juros
			TMP->DATAVENCTO:= STOD(TRB->E1_VENCTO)
			IF mv_par12 == 1
				TMP->DATAPAGTO := STOD(TRB->E1_BAIXA)
			ELSE
				TMP->DATAPAGTO := STOD(TRB->E1_DTCRED)
			ENDIF
			IF ALLTRIM(TRB->E1_NATUREZ) == "003"
				TMP->VALORREC  := (TRB->E1_VALOR)*.6+TRB->E1_JUROS
			else
				TMP->VALORREC  := TRB->E1_VALLIQ
			endif
			TMP->HISTORICO := TRB->E1_HIST
			TMP->NUMBCO    := TRB->E1_CONFED
			TMP->BASE      := TRB->A1_BASE
			TMP->INATIVO   := TRB->A1_INAT
			TMP->DTABERT   := stod(TRB->A1_DTINIC)
			TMP->DTINASS   := STOD(TRB->A1_DTINASS)
			TMP->DTFIMASS  := STOD(TRB->A1_DTFIMAS)
			TMP->VALASSOC  := TRB->A1_VALASSO      
			TMP->FOLHA     := trb->A1_FOLHA
			TMP->CAPITAL   := trb->A1_CAPITAL
			TMP->CAPCENT   := trb->a1_capcent
			TMP->FOLHA_CENT:= trb->a1_folcent
			TMP->LEITOS    := trb->a1_leitos
			TMP->FUNCION   := trb->A1_NUMFUN
			TMP->ESCR_CONT := trb->A1_ESCCONT
			TMP->FILANT    := trb->A1_FILANT
			TMP->HISTORICO := trb->A1_HIST
			TMP->HISTORICO2:= trb->A1_HIST2
			TMP->HISTASS   := trb->A1_HISTASS
			TMP->EMISSAO   := STOD(trb->e1_emissao)
			TMP->VENCREA   := stod(trb->e1_vencrea)
			TMP->JUROS     := trb->e1_juros 
			TMP->VALBAIXA  := trb->e1_valliq
			TMP->BOLETO    := trb->e1_confed 
			TMP->ARQBCO    := trb->e1_arqbco
			TMP->VALCRED   := trb->e1_valcred
			TMP->DTCRED    := STOD(trb->e1_dtcred)
			TMP->NOMEESCR  := SZC->ZC_NOMESC
			TMP->ENDESCR   := SZC->ZC_END
			TMP->CEPESCR   := SZC->ZC_CEP
			TMP->BAIRESCR  := SZC->ZC_BAIRRO
			TMP->MUNESCR   := SZC->ZC_MUN
			TMP->ESTESCR   := SZC->ZC_EST
			TMP->FONEESCR  := SZC->ZC_FONE
			TMP->HIST_PAGTO:= TRB->E1_HIST
			TMP->SINDICATO := TRB->E1_SINDICA                           
			TMP->TPCADASTRO:= TRB->A1_TPCADAS
			msunlock()*/
			@ LI,000 PSAY rel->sindicato 
			@ LI,006 PSAY rel->NOME
			@ LI,057 PSAY rel->cnpj   PICTURE "@R 99.999.999/9999-99"
			@ LI,076 PSAY rel->natureza  
			@ LI,087 PSAY rel->PREFIXO+"-"+rel->numtit//-"+TRB->E1_PARCELA
			@ LI,101 PSAY rel->vencimento
			@ LI,110 PSAY rel->VLRreceb PICTURE "@E 99,999,999.99"
			@ LI,125 PSAY rel->xdata
			IF ALLTRIM(rel->NATUREZa) == "003"
				@ LI,135 PSAY rel->Vlrcred PICTURE "@E 99,999,999.99"
				DATVALPG  += rel->E1_Vlrcred
			  if rel->sindicato == "01"
			  	VALTIT1+=rel->VLRcred
			  	 VALPG1 += 	REL->VLRreceb
			  	  QTDPG1  ++ 
			   elseif rel->sindicato == "02"
			  	VALTIT2+=REL->VLRcred
			  	 VALPG2 += 	REL->VLRreceb
			  	  QTDPG2  ++ 
			   elseif rel->sindicato == "03"
			  	VALTIT3+=REL->VLRcred
			  	 VALPG3 += 	REL->VLRreceb
			  	 			  	 QTDPG3  ++ 
			   elseif rel->sindicato == "04"
			  	VALTIT4+=REL->VLRcred
			  	 VALPG4 += 	REL->VLRreceb
			  	 QTDPG4  ++ 
			   elseif rel->sindicato == "05"
			  	VALTIT5+=REL->VLrcred
			  	 VALPG5 += 	REL->VLRreceb
			  	 QTDPG5  ++ 
			   elseif rel->sindicato == "06"
			  	VALTIT6+=REL->VLRcred
			  	 VALPG6 += 	REL->VLRreceb
			  	 QTDPG6  ++ 
			   ENDIF
			else
				JRVALORREC:= REL->VLRrecEB
				IF ALLTRIM(REL->NATuREZA) $ "002/0301" .AND. REL->SINDICATO<>"01"
					JRVALORREC := REL->vlrCRED
				ENDIF
				@ LI,135 PSAY JRVALORREC PICTURE "@E 99,999,999.99"
				DATVALPG  += REL->VLRcred
 			  if rel->sindicato == "01"
			  	VALTIT1+=TRB->E1_VALOR+trb->e1_juros
			  	 VALPG1 += 	REL->VLRcred
			  	 QTDPG1  ++ 
			   elseif rel->sindicato == "02"
			  	VALTIT2+=REL->VLRcred
			  	 VALPG2 += 	REL->VLRcred
			  	 QTDPG2  ++ 
			   elseif rel->sindicato == "03"
			  	VALTIT3+=REL->VLRcred
			  	 VALPG3 += 	REL->VLRcred
			  	 QTDPG3  ++ 
			   elseif rel->sindicato == "04"
			  	VALTIT4+=REL->VLRcred
			  	 VALPG4 += 	REL->VLRcred
			  	 QTDPG4  ++ 
			   elseif rel->sindicato == "05"
			  	VALTIT5+=REL->VLRcred
			  	 VALPG5 += 	REL->VLRcred
			  	 QTDPG5  ++ 
			   elseif rel->sindicato == "06"
			  	VALTIT6+=REL->VLRcred
			  	 VALPG6 += 	REL->VLRcred
			  	 QTDPG6  ++ 
			   ENDIF

				ENDIF
			@ LI,149 PSAY rel->situacao
			@ li,154 psay rel->numban
			@ li,169 psay rel->arquivo// MUDAR O SITUACAO PARA SIT  E AUMENTAR E1_HIST
//			@ li,186 psay trb->e1_sindica
			@ li,189 psay rel->HISTorico
			LI++
			DATVALTIT += rel->vlrreceb
			DATQTDPG ++
			dbselectarea("rel")
			DBSKIP()
		ENDDO
		li++
		@ LI,000 PSAY "Total da Data: "+DTOC(xDATA)
		@ LI,060 PSAY "Qtde.Titulos:"
		@ li,074 psay datqtdpg picture "@e 999,999"
		@ LI,110 PSAY datvaltit PICTURE "@E 99,999,999.99"
		@ LI,135 PSAY datvalpg  PICTURE "@E 99,999,999.99"
		natVALTIT += dATVALTIT
		natVALPG  += dATVALPG
		NATQTDPG += DATQTDPG
		LI+=2
	ENDDO
	li++
	@ LI,000 PSAY "Total da Natureza: "
	@ LI,060 PSAY "Qtde.Titulos:"
	@ li,074 psay natqtdpg picture "@e 999,999"
	@ LI,110 PSAY natvaltit PICTURE "@E 99,999,999.99"
	@ LI,135 PSAY natvalpg  PICTURE "@E 99,999,999.99"
	VALTIT += NATVALTIT
	VALPG  += NATVALPG
	QTDPG  += NATQTDPG
	li+= 2
enddo
IF LI <> 80
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	IF QTDPG1 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 01:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg1 picture "@e 999,999"
	   @ LI,110 PSAY valtit1 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg1  PICTURE "@E 99,999,999.99"
		li++
	endif
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif

	IF QTDPG2 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 02:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg2 picture "@e 999,999"
	   @ LI,110 PSAY valtit2 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg2  PICTURE "@E 99,999,999.99"
		li++
	endif                             
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	
	IF QTDPG3 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 03:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg3 picture "@e 999,999"
	   @ LI,110 PSAY valtit3 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg3  PICTURE "@E 99,999,999.99"
	LI++
	endif
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif

	IF QTDPG4 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 04:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg4 picture "@e 999,999"
	   @ LI,110 PSAY valtit4 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg4  PICTURE "@E 99,999,999.99"
		LI++
	endif   
		if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
                        
	
	IF QTDPG5 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 05:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg5 picture "@e 999,999"
	   @ LI,110 PSAY valtit5 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg5  PICTURE "@E 99,999,999.99"
		LI++
	endif
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif

	IF QTDPG6 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 06:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg6 picture "@e 999,999"
	   @ LI,110 PSAY valtit6 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg6  PICTURE "@E 99,999,999.99"
		LI++
	endif
	li++
	@ LI,000 PSAY "Total Geral:"
	@ LI,060 PSAY "Qtde.Titulos:"
	@ li,074 psay qtdpg picture "@e 999,999"
	@ LI,110 PSAY valtit PICTURE "@E 99,999,999.99"
	@ LI,135 PSAY valpg  PICTURE "@E 99,999,999.99"
	li++
ENDIF    


if LI <> 80
	roda(cbcont,cbtxt,tamanho)
endif
DBSELECTAREA("rel")
DBCLOSEAREA("rel")
set device to screen
if aReturn[5] == 1
	set printer to
	dbcommit()
	ourspool(wnrel)
endif
MS_FLUSH()
//dbselectarea(_cAlias)
return


