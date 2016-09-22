#include "rwmake.ch"
User Function RFINA124()
SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,N_OPC,CPERG,SAIDA")
SetPrvt("_ASTRU,C_ARQTMP,_ASTRU1,C_ARQTMP1,_ASTRU2,C_ARQTMP2")
SetPrvt("_ASTRU3,C_ARQTMP3,_ASTRU4,C_ARQTMP4,_ASTRU5,C_ARQTMP5")
SetPrvt("ANO1,PARC1,_DVENC,_DEMIS,_NREGISTROS,_NINCLUIDOS")
SetPrvt("_NSEQ,_NVALTOT,_NOSSONUM,_CTEXTO,_NNUMSEQ,ARQ")
SetPrvt("W,_VNUM,_M1,_M2,_M3,_M4")
SetPrvt("_M5,_M6,_M7,_M8,_M9,_M10")
SetPrvt("_M11,_M12,_M13,_S1,_R11,_DIGITO")
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RFINA24  ³ Autor ³ Luiz Mattos Duarte Jr.³ Data ³ 28/10/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envio/Preparacao de Contribuicoes Sindical                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_oldArea  := alias()
_oldOrder := indexord()
_cTitulo   := "Cobranca Sindical"
n_Opc := 0
cPerg    := "FINA24"
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                                       ³
³ mv_par01   // Mes para envio                                               ³
³ mv_par02   // ano para envio                                               ³
³ mv_par03   // Data de vencimento                                           ³
³ mv_par04   // Data de Emissao                                              ³
³ mv_par05   // Sequencia                                                    ³
³ mv_par06   // Nao usado                                                    ³
³ mv_par07   // arquivo de saida := "H:\BCOREAL\ASSOC"+strzero(MES,2)+".txt" ³
³ mv_par08   // codigo do Banco                                              ³
³ mv_par09   // codigo da agencia                                            ³
³ mv_par10   // codigo da conta                                              ³
³ mv_par11   // codigo da subconta                                           ³
³ mv_par12   // Mensagem Linha 01                                            ³
³ mv_par13   // Mensagem Linha 02                                            ³
³ mv_par14   // Mensagem Linha 03                                            ³
³ mv_par15   // Mensagem Linha 04                                            ³
³ mv_par16   // Mensagem Linha 05                                            ³
³ mv_par17   // Qual Ersin ?
³ mv_par18   // Data de Abertura Ate'
³ mv_par19   // Quais Contribuintes
³ mv_par20   // Sindicato de Hospitais
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Pergunte(cPerg,.T.)
@ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a geracao de Arquivo para cobranca da "
@ 033,014 SAY "Contribuicao Sindical"
@ 063,014 SAY "CONFIRME PARA INICIAR A GERACAO DE DADOS         "
@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar()
@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED
Return
*-----------------*
Static Function Iniciar()
Close(oDlg1)
Processa( {|| Gerar() })
Return
*------------------*
Static Function Gerar()
_aStru := {}    //REGISTRO HEADER
AADD( _aStru, { "COD_REGIST"  , "C" , 001 , 0 } )
AADD( _aStru, { "COD_REMESS"  , "C" , 001 , 0 } )
AADD( _aStru, { "REMESSA"     , "C" , 007 , 0 } )
AADD( _aStru, { "COD_SERVIC"  , "C" , 002 , 0 } )
AADD( _aStru, { "SERVICO"     , "C" , 015 , 0 } )
AADD( _aStru, { "COD_EMPRES"  , "C" , 020 , 0 } )
AADD( _aStru, { "EMPRESA"     , "C" , 030 , 0 } )
AADD( _aStru, { "COD_BANCO"   , "C" , 003 , 0 } )
AADD( _aStru, { "BANCO"       , "C" , 015 , 0 } )
AADD( _aStru, { "DATA_GRAV"   , "C" , 006 , 0 } )
AADD( _aStru, { "BRANCO"      , "C" , 008 , 0 } )
AADD( _aStru, { "IDENT_SIST"  , "C" , 002 , 0 } )
AADD( _aStru, { "SEQUENCIA"   , "C" , 007 , 0 } )
AADD( _aStru, { "BRANCO2"     , "C" , 277 , 0 } )
AADD( _aStru, { "NUM_SEQUEN"  , "C" , 006 , 0 } )
c_ArqTmp := CriaTrab(_aStru,.t.)
dbUseArea(.t.,,c_ArqTmp,"HEAD")
dbSelectArea("HEAD")
_aStru1 := {}  //REGISTRO TRAILLER
AADD( _aStru1, { "COD_REGIS"  , "C" , 001 , 0 } )
AADD( _aStru1, { "BRANCO"     , "C" , 393 , 0 } )
AADD( _aStru1, { "NUM_SEQUEN" , "C" , 006 , 0 } )
c_ArqTmp1 := CriaTrab(_aStru1,.t.)
dbUseArea(.t.,,c_ArqTmp1,"TRAI")
dbSelectArea("TRAI")
_aStru2 := {}  //REGISTRO DETALHE
AADD( _aStru2, { "COD_REGIS"  , "C" , 001 , 0 } )
AADD( _aStru2, { "AGE_DEBIT"  , "C" , 005 , 0 } )
AADD( _aStru2, { "DIG_AGEDB"  , "C" , 001 , 0 } )
AADD( _aStru2, { "RAZAO_CC"   , "C" , 005 , 0 } )
AADD( _aStru2, { "CONTA"      , "C" , 007 , 0 } )
AADD( _aStru2, { "DIG_CC"     , "C" , 001 , 0 } )
AADD( _aStru2, { "ID_EMPRESA" , "C" , 017 , 0 } )
AADD( _aStru2, { "CONTR_PART" , "C" , 025 , 0 } )
AADD( _aStru2, { "COD_BANCO"  , "C" , 003 , 0 } )
AADD( _aStru2, { "ZEROS"      , "C" , 005 , 0 } )
AADD( _aStru2, { "NOSSO_NUM"  , "C" , 012 , 0 } )
AADD( _aStru2, { "DESC_BONIF" , "C" , 010 , 0 } )
AADD( _aStru2, { "COND_EMISS" , "C" , 001 , 0 } )
AADD( _aStru2, { "DEB_AUTOM"  , "C" , 001 , 0 } )
AADD( _aStru2, { "ID_OPERAC"  , "C" , 010 , 0 } )
AADD( _aStru2, { "ID_RATEIO"  , "C" , 001 , 0 } )
AADD( _aStru2, { "END_DBAUT"  , "C" , 001 , 0 } )
AADD( _aStru2, { "BRANCO"     , "C" , 002 , 0 } )
AADD( _aStru2, { "ID_OCORR"   , "C" , 002 , 0 } )
AADD( _aStru2, { "NUM_DOCTO"  , "C" , 010 , 0 } )
AADD( _aStru2, { "DATA_VECTO" , "C" , 006 , 0 } )
AADD( _aStru2, { "VALOR"      , "C" , 013 , 0 } )
AADD( _aStru2, { "BCO_ENCARR" , "C" , 003 , 0 } )
AADD( _aStru2, { "AGE_DEPOSI" , "C" , 005 , 0 } )
AADD( _aStru2, { "ESPECIE"    , "C" , 002 , 0 } )
AADD( _aStru2, { "IDENTIFICA" , "C" , 001 , 0 } )
AADD( _aStru2, { "DATA_EMISS" , "C" , 006 , 0 } )
AADD( _aStru2, { "PRIM_INSTR" , "C" , 002 , 0 } )
AADD( _aStru2, { "SEGU_INSTR" , "C" , 002 , 0 } )
AADD( _aStru2, { "VLR_ATRASO" , "C" , 013 , 0 } )
AADD( _aStru2, { "DATA_DESC"  , "C" , 006 , 0 } )
AADD( _aStru2, { "VALOR_DESC" , "C" , 013 , 0 } )
AADD( _aStru2, { "VALOR_IOF"  , "C" , 013 , 0 } )
AADD( _aStru2, { "VALOR_ABAT" , "C" , 013 , 0 } )
AADD( _aStru2, { "TIPO_IDENT" , "C" , 002 , 0 } )
AADD( _aStru2, { "CGC_SACADO" , "C" , 014 , 0 } )
AADD( _aStru2, { "NOME_SACAD" , "C" , 040 , 0 } )
AADD( _aStru2, { "END_SACADO" , "C" , 040 , 0 } )
AADD( _aStru2, { "PRIM_MSG"   , "C" , 012 , 0 } )
AADD( _aStru2, { "CEP_SACADO" , "C" , 005 , 0 } )
AADD( _aStru2, { "CEPC_SACAD" , "C" , 003 , 0 } )
AADD( _aStru2, { "SEGUND_MSG" , "C" , 060 , 0 } )
AADD( _aStru2, { "NUM_SEQUEN" , "C" , 006 , 0 } )
c_ArqTmp2 := CriaTrab(_aStru2,.t.)
dbUseArea(.t.,,c_ArqTmp2,"DETA")
dbSelectArea("DETA")
_aStru3 := {}  //ARQUIVO FINAL
AADD( _aStru3, { "REGISTRO"  , "C" , 400 , 0 } )
c_ArqTmp3 := CriaTrab(_aStru3,.t.)
dbUseArea(.t.,,c_ArqTmp3,"REGI")
dbSelectArea("REGI")
_aStru4 := {}  //ARQUIVO PARA MALA DIRETA
AADD( _aStru4, { "CGC_SACADO" , "C" , 014 , 0 } )
AADD( _aStru4, { "NOME_SACAD" , "C" , 040 , 0 } )
AADD( _aStru4, { "END_SACADO" , "C" , 040 , 0 } )
AADD( _aStru4, { "BAI_SACADO" , "C" , 020 , 0 } )
AADD( _aStru4, { "CEP_SACADO" , "C" , 005 , 0 } )
AADD( _aStru4, { "CEPC_SACAD" , "C" , 003 , 0 } )
AADD( _aStru4, { "MUN_SACADO" , "C" , 015 , 0 } )
c_ArqTmp4 := CriaTrab(_aStru4,.t.)
dbUseArea(.t.,,c_ArqTmp4,"MALA")
dbSelectArea("MALA")
_aStru5 := {}  //ARQUIVO PARA BUREAU
AADD( _aStrU5, { "NUM_GUIA"  , "C" , 013 , 0 } )
AADD( _aStru5, { "NOME"      , "C" , 040 , 0 } )
AADD( _aStru5, { "CNPJ"      , "C" , 014 , 0 } )
AADD( _aStru5, { "END"       , "C" , 040 , 0 } )
AADD( _aStru5, { "COMPLEMENT", "C" , 020 , 0 } )
AADD( _aStru5, { "BAIRRO"    , "C" , 020 , 0 } )
AADD( _aStru5, { "CIDADE"    , "C" , 025 , 0 } )
AADD( _aStru5, { "UF"        , "C" , 002 , 0 } )
AADD( _aStru5, { "CEP"       , "C" , 009 , 0 } )
AADD( _aStru5, { "NOME_ENT"  , "C" , 040 , 0 } )
AADD( _aStru5, { "END_ENT"   , "C" , 040 , 0 } )
AADD( _aStru5, { "COMPL_ENT" , "C" , 020 , 0 } )
AADD( _aStru5, { "BAIRRO_ENT", "C" , 020 , 0 } )
AADD( _aStru5, { "CIDADE_ENT", "C" , 025 , 0 } )
AADD( _aStru5, { "UF_ENT"    , "C" , 002 , 0 } )
AADD( _aStru5, { "CEP_ENT"   , "C" , 009 , 0 } )
c_ArqTmp5 := CriaTrab(_aStru5,.t.)
dbUseArea(.t.,,c_ArqTmp5,"BIRO")
DBSELECTAREA("BIRO")
Ano1:=1
Parc1:="1"
_DVenc := strzero(day(mv_par03),2)+strzero(month(mv_par03),2)+strzero(val(substr(str(year(mv_par03),4),3,2)),2)
_Demis := strzero(day(mv_par04),2)+strzero(month(mv_par04),2)+strzero(val(substr(str(year(mv_par04),4),3,2)),2)
dbSelectArea("HEAD")  //GERANDO REGISTRO HEADER
RecLock("HEAD",.T.)
HEAD->COD_REGIST  := "0"
HEAD->COD_REMESS  := "1"
HEAD->REMESSA	  := "REMESSA"
HEAD->COD_SERVIC  := "01"
HEAD->SERVICO     := "COBRANCA"
HEAD->COD_EMPRES  := "00000000000000000000"         && Ver com Finaceiro
HEAD->EMPRESA     := "SIND.HOSP.CLIN.CAS.S.LAB.DE SP"		&& Ver com Finaceiro
HEAD->COD_BANCO   := "237"
HEAD->BANCO       := "BRADESCO"
HEAD->DATA_GRAV   := _Demis
HEAD->IDENT_SIST  := "MX"
HEAD->SEQUENCIA   := "0000001"   && Nao sera enviado ao Banco
HEAD->NUM_SEQUEN  := "000001"
DBCOMMIT()
MsUnLock()
dbSelectArea("SA1")
if mv_par06 == 2
	Dbsetorder(7)  && Ordena arq. por CNPJ escrit. contabil
	dbseek(xfilial()+"0",.t.)
else
	Dbsetorder(1) // Atencao (UPDXFUN).
	dbGotop()
EndIf
ProcRegua(RecCount(),22,05)
_nRegistros := 0
_nIncluidos := 0
_cTitulo := "Gerando Arquivo Bancario - Sindical"
_nseq := "000002"
_nValTot := 0
Do While !Eof()
	IncProc("Cliente: "+ALLTRIM(SA1->A1_NREDUZ))
	IF SA1->A1_CAPCENT=="S"
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF
	IF MV_PAR19 == 1
		IF EMPTY(SA1->A1_CODASSO) .or. sa1->a1_situac=="IS"
			DBSELECTAREA("SA1")
			DBSKIP()
			LOOP
		ENDIF
	ELSEIF MV_PAR19 == 2
		IF sa1->a1_situac$"SS/AS"
			DBSELECTAREA("SA1")
			DBSKIP()
			LOOP
		ENDIF
	ENDIF
	IF LEN(ALLTRIM(SA1->A1_CEP))<> 8
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF
	if !empty(mv_par17)
		if sa1->a1_ersin <> mv_par17
			dbselectarea("sa1")
			dbskip()
			loop
		endif
	endif
	if !EMPTY(SA1->A1_DTINIC) .AND. SA1->A1_DTINIC>MV_PAR18
		dbselectarea("sa1")
		dbskip()
		loop
	endif
	if sa1->a1_capcent == "S" .and. subs(sa1->a1_cgc,9,4)<>"0001"
		dbselectarea("sa1")
		dbskip()
		loop
	endif
	If !EMPTY(SA1->A1_INAT)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	If ! EMPTY( MV_PAR20) .AND. SA1->A1_SINDICA <> MV_PAR20
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	If SA1->A1_FILANT == "X"      && Envio para Todos (Geral)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	IF VAL(SA1->A1_CATEG1) >= 12000
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	DbSelectArea("SZC")
	DbSetorder(2)
	if ! ( dbseek( xFilial() + SA1->A1_ESCCONT ) )
		DBSELECTAREA("SA1")
		reclock("SA1",.F.)
		SA1->A1_ESCCONT := ""
		MSUNLOCK()
	ENDIF
	if mv_par06==1 .and. !empty(sa1->a1_esccont)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	if mv_par06==2 .and. empty(sa1->a1_esccont)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	dbSelectArea("SE1")
	dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//	if dbseek( xFilial()+strzero(mv_par02,2)+"S"+SA1->A1_COD+" DP")
	if DBSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par02,2)+"S" ) .AND. ;
	   SE1->E1_NATUREZ = '003'
		dbSelectArea("SA1")
		dbskip()
		loop
	endif
	dbSelectArea("SE1")
	Dbsetorder(1)
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	RecLock("DETA",.T.)
	DETA->COD_REGIS := "1"
	DETA->AGE_DEBIT := "00000"
	DETA->DIG_AGEDB := ""
	DETA->RAZAO_CC  := "00000"
	DETA->CONTA     := "0000000"
	DETA->DIG_CC    := ""
	DETA->ID_EMPRESA:= "00060019801696416"
	DETA->CONTR_PART:= ""
	DETA->COD_BANCO := "237"
	DETA->ZEROS     := "00000"
	_NossoNum := strzero(val(mv_par05),5) + strzero(val(_nseq),8)
	DETA->NOSSO_NUM := SUBS(_NOSSONUM,2,12)
	DETA->DESC_BONIF:= "0000000000"
	DETA->COND_EMISS:= "2"
	DETA->DEB_AUTOM := "N"
	DETA->ID_OPERAC := ""
	DETA->ID_RATEIO := ""
	DETA->END_DBAUT := "2"
	DETA->ID_OCORR  := "01"
	DETA->NUM_DOCTO := strzero(mv_par02,2)+"S"+SA1->A1_COD+" "
	DETA->DATA_VECTO := _DVenc
	DETA->VALOR      := "0000000000000"
	DETA->BCO_ENCARR := "237"
	DETA->AGE_DEPOSI := "01988"
	DETA->ESPECIE    := "12"
	DETA->IDENTIFICA := "N"
	DETA->DATA_EMISS := _Demis
	DETA->PRIM_INSTR := "00"
	DETA->SEGU_INSTR := "00"
	DETA->VLR_ATRASO := "0000000000000"
	DETA->DATA_DESC  := "000000"
	DETA->VALOR_DESC := "0000000000000"
	DETA->VALOR_IOF  := "0000000000000"
	DETA->VALOR_ABAT := "0000000000000"
	DETA->TIPO_IDENT := "02"
	DETA->CGC_SACADO := SA1->A1_CGC
	Ver_Ascii()
	DETA->PRIM_MSG   := mv_par12
	DETA->SEGUND_MSG := mv_par13 + mv_par14
	dbSelectArea("SZ9")
	Reclock("SZ9",.T.)
	SZ9->Z9_FILIAL := xFilial("SZ9")
	SZ9->Z9_TITULO := _NossoNum		&& Numero retorno
	SZ9->Z9_CGC    := SA1->A1_CGC
	SZ9->Z9_VENCTO := mv_par03
	SZ9->Z9_PARCELA:= strzero(mv_par02,2)   && PP AA
	msUnlock()
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	DETA->NUM_SEQUEN := _nseq     //Sequencia
	msUnlock()
	DbSelectArea("SZC")
	DbSetorder(2)
	if ! ( dbseek( xFilial() + SA1->A1_ESCCONT ) )
		DBSELECTAREA("SA1")
		reclock("SA1",.F.)
		SA1->A1_ESCCONT := ""
		MSUNLOCK()
	ENDIF
	DBSELECTAREA("BIRO")
	RECLOCK("BIRO",.T.)
	BIRO->NUM_GUIA  := _NOSSONUM
	BIRO->NOME      := SA1->A1_NOME
	BIRO->CNPJ      := SA1->A1_CGC
	BIRO->END       :=sa1->a1_end
	BIRO->COMPLEMENT:=""
	BIRO->BAIRRO    :=sa1->a1_bairro
	BIRO->CIDADE    :=sa1->a1_mun
	BIRO->UF        := sa1->A1_est
	BIRO->CEP       := subs(sa1->A1_cep,1,5)+subs(sa1->a1_cep,6,3)
	IF !EMPTY(SA1->A1_ESCCONT)
		BIRO->NOME_ENT  := SZC->ZC_NOMESC
		BIRO->END_ENT   := SZC->ZC_end
		BIRO->BAIRRO_ENT:= sZC->ZC_bairro
		BIRO->CIDADE_ENT:= sZC->ZC_mun
		BIRO->UF_ENT    := sZC->ZC_est
		BIRO->CEP_ENT   := subs(sZC->ZC_cep,1,5)+subs(sZC->ZC_cep,6,3)
	ELSE
		BIRO->NOME_ENT  := SA1->A1_NOME
		BIRO->END_ENT   := SA1->A1_end
		BIRO->BAIRRO_ENT:= sA1->A1_bairro
		BIRO->CIDADE_ENT:= sA1->A1_mun
		BIRO->UF_ENT    := sA1->A1_est
		BIRO->CEP_ENT   := subs(sA1->A1_cep,1,5)+subs(sA1->A1_cep,6,3)
	ENDIF
	msunlock()
	_nNumSeq := val( _nseq )
	_nNumSeq := _nNumSeq + 1
	_nseq := strzero( _nNumSeq,6 )
	_nRegistros := _nRegistros + 1
	dbSelectArea("SA1")
	dbskip()
End
dbSelectArea("TRAI")  //GERANDO REGISTRO TRAILLER
RecLock("TRAI",.T.)
TRAI->COD_REGIS := "9"
TRAI->NUM_SEQUEN := _nseq
dbcommit()
MsUnlock()
/*
dbSelectArea("HEAD")
COPY TO HEAD.txt SDF
dbSelectArea("DETA")
COPY TO DETA.TXT SDF
dbSelectArea("TRAI")
COPY TO TRAI.TXT SDF
dbSelectArea("REGI")
Append From HEAD.TXT SDF
Append From DETA.TXT SDF
Append From TRAI.TXT SDF
*/
TOTCAD()
dbselectarea("biro")
ARQ := "\arquivos\sindical\"+MV_PAR07
COPY TO &ARQ
dbclosearea("biro")
dbSelectArea("MALA")
dbCloseArea()
If File(c_ArqTmp4+".DBF")
	Ferase(c_ArqTmp4+".DBF")
EndIf
@ 96,42 TO 290,405 DIALOG oDlg1 TITLE "Termino da Geracao"
@ 8,10 TO 68,170
@ 23,22 SAY "Registros Gerados"
@ 23,95 GET _nRegistros PICTURE "@E 999,999" WHEN .F.
@ 77,078 BMPBUTTON TYPE 1 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED

dbSelectArea("HEAD")
dbCloseArea()
If File(c_ArqTmp+".DBF")
	Ferase(c_ArqTmp+".DBF")
EndIf
dbSelectArea("TRAI")
dbCloseArea()
If File(c_ArqTmp1+".DBF")
	Ferase(c_ArqTmp1+".DBF")
EndIf
dbSelectArea("DETA")
dbCloseArea()
If File(c_ArqTmp2+".DBF")
	Ferase(c_ArqTmp2+".DBF")
EndIf
If File("HEAD.TXT")
	Ferase("HEAD.TXT")
EndIf
If File("DETA.TXT")
	Ferase("DETA.TXT")
EndIf
If File("TRAI.TXT")
	Ferase("TRAI.TXT")
EndIf
dbSelectArea("REGI")
dbCloseArea()
If File(c_ArqTmp3+".DBF")
	Ferase(c_ArqTmp3+".DBF")
EndIf
dbSelectArea("SA1")
dbSetOrder(1)
dbSelectArea(_oldArea)
dbSetOrder(_oldOrder) // Atencao (UPDXFUN).
return


************************
static Function TOTCAD()
SetPrvt("_CALIAS,CBCONT,CBTXT,WNREL,CDESC1,CDESC2")
SetPrvt("CDESC3,CSTRING,TAMANHO,TIPO,LIMITE,TITULO")
SetPrvt("CABEC2,CABEC1,ARETURN,NOMEPROG,NLASTKEY,CPERG")
SetPrvt("M_PAG,LI,_AESTR,C_ARQIMP,CARQIND,CINDSA1")
SetPrvt("NLINHA,")
_cAlias := alias()
cbcont := 0
cbtxt := ""
wnrel := ""
cDesc1 := "Este programa irá gerar o resumo da geração da contribuição sindical."
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "P"
tipo := 15
limite := 220
Titulo := "Geração da contribuição Sindical"
cabec2 := ""
cabec1 := ""
aReturn := { "Zebrado", 1,"Administracao", 4, 2, 1, "",1 }
nomeprog := "RFINA24"
nLastkey := 0
cPerg := "FINA24"
m_pag := 1
li := 80
wnrel := "RFINA24"
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
LI := 80
if Li >= 60
    cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
    nLinha := prow() + 1
endif
@ li,000 PSAY "Registros gerados: "
@ li,030 psay 	_nRegistros picture "@e 999,999,999"
set device to screen
if aReturn[5] == 1
   set printer to
   dbcommit()
   ourspool(wnrel)
endif
MS_FLUSH()
return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Ver_Ascii³ Autor ³   Andreia Santos      ³ Data ³ 18/03/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica caracteres com acentuacao e faz a troca por       ³±±
±±³          ³ caracteres nao acentuados                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CNAB - A RECEBER                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static FUNCTION Ver_Ascii()
_cTexto := SA1->A1_NOME
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->NOME_SACADO := _cTexto
_cTexto := SA1->A1_END
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->END_SACADO := _cTexto
_cTexto := SUBSTR(SA1->A1_CEP,1,5)
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->CEP_SACADO := _cTexto

_cTexto := SUBSTR(SA1->A1_CEP,6,3)
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->CEPC_SACADO := _cTexto
return





