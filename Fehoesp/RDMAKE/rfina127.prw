#include "rwmake.ch"
User Function RFINA127()
SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,N_OPC,CPERG,_ASTRU")
SetPrvt("C_ARQTMP,_ASTRU1,C_ARQTMP1,_ASTRU2,C_ARQTMP2,_ASTRU3")
SetPrvt("C_ARQTMP3,_ASTRU4,C_ARQTMP4,ANO1,PARC1,_DVENC")
SetPrvt("_DEMIS,_NREGISTROS,_NINCLUIDOS,_NSEQ,_NVALTOT,_NOSSONUM")
SetPrvt("_CTEXTO,_NNUMSEQ,W,_VNUM,_M1,_M2")
SetPrvt("_M3,_M4,_M5,_M6,_M7,_M8")
SetPrvt("_M9,_M10,_M11,_M12,_M13,_S1")
SetPrvt("_R11,_DIGITO,")
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � RFINA27  � Autor � Luiz Eduardo D. Roz   � Data � 28/03/01 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Envio/Preparacao de Contribuicoes Confederativa bradesco   ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico SINDHOSP                                        ���
���          � H:\BCOREAL\CBMM99.txt (arquivo para envio)                 ���
���          � K:\SIGA\MALA\CBMM99.dbf (arquivo para mala direta)         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
_oldArea  := alias()
_oldOrder := indexord()
_cTitulo  := "Cobranca Confederativa"
n_Opc     := 0
cPerg     := "FINA27"
_nRegistros  := 0
_nIncluidos  := 0
C_BORDERO    := ""
/*
����������������������������������������������������������������������������Ŀ
� Variaveis utilizadas para parametros                                       �
� mv_par01   // ano para envio   N2                                          �
� mv_par02   // Parcela          C1                                          �
� mv_par03   // Data de vencimento                                           �
� ;;mv_par04   // Data de Emissao                                              �
� ;;mv_par05   // Sequencia                                                    �
� MV_PAR04   // arquivo de saida 					     �
� MV_PAR05   // Codigo do Banco                                              �
� MV_PAR06   // codigo da agencia                                            �
� MV_PAR07   // Codigo da conta                                              �
� MV_PAR08   // codigo da subconta                                           �
� MV_PAR09   // destinatario - Entidades, Escritorios , Reenvio 	         �
�            // destinatario - Reenvio Entidades, Reenvio Escritorios 	     �
� MV_PAR10   // 1A. msg	     c12				                    	     �
� MV_PAR11   // 2A. msg	- PARTE 1   c30				 	                     �
� MV_PAR12   // 2A. msg	- PARTE 2   c30				 	                     �
� MV_PAR13   // Base Territorial para envio			 	                       �
� MV_PAR14   // Prefixo/Ano da parcela a considerar baixa	             �
� MV_PAR15   // Parcela a considerar baixa			 	     �
� MV_PAR16   // Arq. para Mala Direta			 	             �
� MV_PAR17   // Prefixo/Ano da 2a. parcela a considerar baixa	             �
� MV_PAR18   // 2a. Parcela a considerar baixa			 	     �
� mv_par19   // Data de Cadastro                                �
� MV_PAR20   // Codigo Sindicato                                             �
������������������������������������������������������������������������������
*/
Pergunte(cPerg,.T.)

@ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a geracao de Arquivo para cobranca da "
@ 033,014 SAY "Contribuicao Confederativa"
@ 063,014 SAY "CONFIRME PARA INICIAR A GERACAO DE DADOS         "
@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar()
@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED
Return
*************************
Static Function Iniciar()
Close(oDlg1)
Processa( {|| Gerar() })
Return
*************************
Static Function Gerar()

cConta := SUBST( Rtrim( MV_PAR07 ), 1, Len( Rtrim ( MV_PAR07 ) ) - 2 ) + RIGHT( Rtrim( MV_PAR07 ), 1 )

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
AADD( _aStru4, { "EST_SACADO" , "C" , 002 , 0 } )
AADD( _aStru4, { "NOME_ENT"   , "C" , 040 , 0 } )
AADD( _aStru4, { "END_ENT"    , "C" , 040 , 0 } )
AADD( _aStru4, { "BAI_ENT"    , "C" , 020 , 0 } )
AADD( _aStru4, { "CEP_ENT"    , "C" , 005 , 0 } )
AADD( _aStru4, { "CEPC_ENT"   , "C" , 003 , 0 } )
AADD( _aStru4, { "MUN_ENT"    , "C" , 015 , 0 } )
AADD( _aStru4, { "EST_ENT"    , "C" , 002 , 0 } )
c_ArqTmp4 := CriaTrab(_aStru4,.t.)
dbUseArea(.t.,,c_ArqTmp4,"MALA")
dbSelectArea("MALA")
Ano1:=1
Parc1:="1"
_DVenc := strzero(day(mv_par03),2)+strzero(month(mv_par03),2)+strzero(val(substr(str(year(mv_par03),4),3,2)),2)
_Demis := strzero(day(dDataBase),2)+strzero(month(dDataBase),2)+strzero(val(substr(str(year(dDataBase),4),3,2)),2)
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
if (MV_PAR09 == 2 .or. MV_PAR09 == 4 )
	DBSETORDER(1)
	dbgotop()
	ProcRegua(RecCount(),22,05)
	DO WHILE !EOF()
		IncProc()
		DbSelectArea("SZC")
		DbSetorder(2)
		if ! ( dbseek( xFilial() + SA1->A1_ESCCONT ) )
			DBSELECTAREA("SA1")
			reclock("SA1",.F.)
			SA1->A1_ESCCONT := ""
			MSUNLOCK()
		ENDIF
		DBSELECTAREA("SA1")
		DBSKIP()
	ENDDO
	DbOrderNickame('7')  && Ordena arq. por CNPJ escrit. contabil // Atencao (UPDXFUN).
	dbseek(xfilial()+"0",.t.)
else
	Dbsetorder(1) // Atencao (UPDXFUN).
	dbGotop()
EndIf
ProcRegua(RecCount(),22,05)
_nRegistros := 0
_nIncluidos := 0
_cTitulo := "Gerando Arquivo Bancario - Confederativa"
_nseq := "000002"
_nValTot := 0
Do While !Eof()
	IncProc("Cliente: "+sa1->a1_cod+"-"+sa1->a1_nreduz)
	IF LEN(ALLTRIM(SA1->A1_CEP))<> 8
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF
	if !empty(MV_PAR13)
		If val(SA1->A1_BASE) <> val(MV_PAR13)
			dbSelectArea("SA1")
			dbskip()
			loop
		EndIf
	endif        
	if !empty(mv_par21)
		IF !SA1->A1_TPCADAS$MV_PAR21
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
		ENDIF
	ENDIF			

	if !empty(MV_PAR19) .and. sa1->a1_dtcadas > MV_PAR19
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	endif	
	If ! EMPTY( MV_PAR20) .AND. SA1->A1_SINDICA <> MV_PAR20
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	If !EMPTY(SA1->A1_INAT)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	If SA1->A1_FILANT == "X"      && Envio para Todos (Geral)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	If SA1->A1_FOLCENT == "S"      && Envio para Todos (Geral)

		/*BEGINDOC
		//���������������������������������������������������������������������P�
		//�Exclusao de emissao para as empresas que possuam folha centralizada.�
		//�Campo A1_FOLCENT ="S"                                               �
		//���������������������������������������������������������������������P�
		ENDDOC*/

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
	DBSELECTAREA("SA1")
	If (MV_PAR09 == 1 .or. MV_PAR09 == 3 ) .and. len(alltrim(SA1->A1_ESCCONT))>0 	&& Envio para Todos (Geral)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	if (MV_PAR09 == 2 .or. MV_PAR09 == 4 )
		if len(alltrim(SA1->A1_ESCCONT))==0
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	EndIf
	&& Verifica se existe titulo para parcela a ser enviada  (Normal/Escrit/Avulso)
	IF MV_PAR02 == "1"
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
/*
		if dbseek( xFilial()+strzero(mv_par01,2)+" "+SA1->A1_COD+mv_par02+"DP") .or.;
			dbseek( xFilial()+strzero(mv_par01,2)+"E"+SA1->A1_COD+mv_par02+"DP") .or.;
			dbseek( xFilial()+strzero(mv_par01,2)+"A"+SA1->A1_COD+mv_par02+"DP")
*/
		if MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" "+mv_par02+"DP") .or.;
			MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E"+mv_par02+"DP") .or.;
			MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A"+mv_par02+"DP")
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	ELSEIF MV_PAR02== "2"
		IF MV_PAR09 == 1 .OR.MV_PAR09 == 2
			dbSelectArea("SE1")
			dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
	/*
			if dbseek( xFilial()+strzero(mv_par01,2)+" "+SA1->A1_COD+mv_par02+"DP") .or.;
				dbseek( xFilial()+strzero(mv_par01,2)+"E"+SA1->A1_COD+mv_par02+"DP") .or.;
				dbseek( xFilial()+strzero(mv_par01,2)+"A"+SA1->A1_COD+mv_par02+"DP")
	*/
			if MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" "+mv_par02+"DP") .or.;
				MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E"+mv_par02+"DP") .or.;
				MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A"+mv_par02+"DP")
					dbSelectArea("SA1")
				dbskip()
				loop
			endif
		ENDIF
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+" "+SA1->A1_COD+" "+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" 1DP")
		IF FOUND()
			IF ALLTRIM(SE1->E1_NATUREZ)== "0301"
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+"E"+SA1->A1_COD+"1"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E1DP")
		IF FOUND()
			IF ALLTRIM(SE1->E1_NATUREZ)== "0301"
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+"A"+SA1->A1_COD+"1"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A1DP")
		IF FOUND()
			IF ALLTRIM(SE1->E1_NATUREZ)== "0301"
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+" "+SA1->A1_COD+"2"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" 2DP")
		IF FOUND()
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+"E"+SA1->A1_COD+"2"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E2DP")
		IF FOUND()
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+"A"+SA1->A1_COD+"2"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A2DP")
		IF FOUND()
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	endif
	&& Verifica se � isento da Confederativa e Geral Baixa da Parcela caso positivo
	dbSelectArea("SE1")
	dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
	//	if (SA1->A1_CATLEIT $"66/67/68/70/71/72" .AND. ALLTRIM(SA1->A1_SITUAC)=="AS")
	IF  SA1->A1_NATUREZ = "1000" .AND. ALLTRIM(SA1->A1_SITUAC)=="AS"
//		if !(dbseek( xFilial()+strzero(mv_par01,2)+" "+SA1->A1_COD+mv_par02+"DP")) .and.;
//			!(dbseek( xFilial()+strzero(mv_par01,2)+"E"+SA1->A1_COD+mv_par02+"DP")) .and.;
//			!(dbseek( xFilial()+strzero(mv_par01,2)+"A"+SA1->A1_COD+mv_par02+"DP"))
		if ! MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" "+mv_par02+"DP") .and.;
			! MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E"+mv_par02+"DP") .and.;
			! MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A"+mv_par02+"DP")
			RecLock("SE1",.T.)

			SE1->E1_FILIAL   := xFilial()
			SE1->E1_PREFIXO  := strzero(MV_PAR01,2)
			SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
			SE1->E1_PARCELA  := mv_par02
			SE1->E1_TIPO     := "DP"
			SE1->E1_NATUREZ  := "002"
			SE1->E1_CLIENTE  := SA1->A1_COD
			SE1->E1_CODASSO  := SA1->A1_CODASSO
			SE1->E1_CGC	   := SA1->A1_CGC
			SE1->E1_CATEG1   := SA1->A1_CATEG1
			SE1->E1_ERSIN	   := SA1->A1_ERSIN
			SE1->E1_BASE	   := SA1->A1_BASE
			SE1->E1_LOJA     := SA1->A1_LOJA
			SE1->E1_NOMCLI   := SA1->A1_NOME
			SE1->E1_EMISSAO  := date()
			SE1->E1_MOVIMEN  := date()
			SE1->E1_EMIS1    := date()
			SE1->E1_VENCTO   := mv_par03
			SE1->E1_VENCREA  := DataValida( mv_par03 )
			SE1->E1_VENCORI  := mv_par03
			SE1->E1_HIST     := "Isento Contr. "+ substr( dtos( mv_par03 ),5,2)+"/"+substr(dtos(mv_par03),3,2)
			SE1->E1_VALOR    := 0
			SE1->E1_SALDO    := 0
			SE1->E1_VLCRUZ   := 0
			SE1->E1_VALJUR   := 0
			SE1->E1_MOEDA    := 1
			SE1->E1_PORTADO  := "237"
			SE1->E1_AGEDEP   := ALLTRIM(MV_PAR06) //"0198"
			SE1->E1_CONTA    := cConta
			SE1->E1_SITUACA  := "1"
			SE1->E1_OCORREN  := "01"
			SE1->E1_ORIGEM  := "RFINA27"
			SE1->E1_STATUS  := "B"
			SE1->E1_JUROS   := 0
			SE1->E1_VALLIQ  := 0
			SE1->E1_BAIXA   := mv_par03
			SE1->E1_OK      := CHR(69)+CHR (120)
			SE1->E1_CONFED  := "Isento"

			MSUNLOCK()
			CONFIRMSX8()
			
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	endif
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	RecLock("DETA",.T.)
	DETA->COD_REGIS := "1"
	DETA->AGE_DEBIT := "00000"
	DETA->DIG_AGEDB := ""
	DETA->RAZAO_CC  := "00000"
	DETA->CONTA     := "0000000"
	DETA->DIG_CC    := ""
	DETA->ID_EMPRESA:= "00060" + ALLTRIM(MV_PAR06)+cConta //00060019801621599"
	DETA->CONTR_PART:= ""
	DETA->COD_BANCO := "237"
	DETA->ZEROS     := "00000"
	_NossoNum := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "03" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" ) + strzero(val(_nseq),7)
	Calc_Num()     && Calcula numero conforme especif. banco
	DETA->DESC_BONIF:= "0000000000"
	DETA->COND_EMISS:= "2"
	DETA->DEB_AUTOM := "N"
	DETA->ID_OPERAC := ""
	DETA->ID_RATEIO := ""
	DETA->END_DBAUT := "2"
	DETA->ID_OCORR  := "01"
	If MV_PAR09 == 1  .OR. MV_PAR09 == 3 .OR. MV_PAR09 == 5
		DETA->NUM_DOCTO := strzero(mv_par01,2)+" "+SA1->A1_COD+mv_par02
	elseif MV_PAR09 == 2 .OR. MV_PAR09 == 4
		DETA->NUM_DOCTO := strzero(mv_par01,2)+"E"+SA1->A1_COD+mv_par02
	Endif
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
	DETA->PRIM_MSG   := MV_PAR10
	DETA->SEGUND_MSG := MV_PAR11 + MV_PAR12
	dbSelectArea("SZ9")
	Reclock("SZ9",.T.)
	SZ9->Z9_FILIAL := xFilial("SZ9")
	SZ9->Z9_TITULO := _NossoNum		&& Numero retorno
	SZ9->Z9_CGC    := SA1->A1_CGC
	SZ9->Z9_VENCTO := mv_par03
	IF !EMPTY(SA1->A1_ESCCONT)
		SZ9->Z9_PARCELA:= strzero(mv_par01,2)+"E"+MV_PAR02   && PP AA
	ELSE
		SZ9->Z9_PARCELA:= strzero(mv_par01,2)+" "+MV_PAR02   && PP AA
	ENDIF
	msUnlock()
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	DETA->NUM_SEQUEN := _nseq     //Sequencia
	msUnlock()
	dbSelectArea("MALA")
	Reclock("MALA",.T.)
	MALA->CGC_SACADO := SA1->A1_CGC
	MALA->NOME_SACAD  := SA1->A1_NOME
	MALA->END_SACADO  := SA1->A1_END
	MALA->CEP_SACADO  := SUBSTR(SA1->A1_CEP,1,5)
	MALA->CEPC_SACAD  := SUBSTR(SA1->A1_CEP,6,3)
	MALA->BAI_SACADO  := SA1->A1_BAIRRO
	MALA->MUN_SACADO  := SA1->A1_MUN
	mala->est_SACADO  := sA1->A1_EST		
	IF !EMPTY(SA1->A1_ESCCONT)
		MALA->NOME_ENT    := szc->zc_nomesc
		MALA->END_ENT     := SZC->ZC_END
		MALA->CEP_ENT     := SUBSTR(SZC->ZC_CEP,1,5)
		MALA->CEPC_ENT    := SUBSTR(SZC->ZC_CEP,6,3)
		MALA->BAI_ent     := Szc->zc_BAIRRO
		MALA->MUN_ent     := Szc->zc_MUN	
		mala->est_ent     := szc->zc_EST		
	else
		MALA->NOME_ent := SA1->A1_NOME
		MALA->END_ent  := SA1->A1_END
		MALA->CEP_ent  := SUBSTR(SA1->A1_CEP,1,5)
		MALA->CEPC_ent := SUBSTR(SA1->A1_CEP,6,3)
		MALA->BAI_ent  := SA1->A1_BAIRRO
		MALA->MUN_ent  := SA1->A1_MUN
		mala->est_ent  := sA1->A1_EST		
	endif
	dbcommit()
	msUnlock()
	_nNumSeq := val( _nseq )
	_nNumSeq := _nNumSeq + 1
	_nseq := strzero( _nNumSeq,6 )
	_nRegistros := _nRegistros + 1
	dbSelectArea("SA1")
	dbskip()
End

// Adiciona 1 ao SX!
IF SX1->( DbSeek( cPerg + "05" ) )
   RecLock( "SX1", .F. )
   SX1->X1_CNT01 := Strzero( ( Val( SX1->X1_CNT01 ) + 1 ), 4 )
   MsUnLock() 
ENDIF   

dbSelectArea("SEE")
if dbseek( xFilial()+MV_PAR05+MV_PAR06+MV_PAR07+MV_PAR08 )
	RecLock("SEE",.F.)
	SEE->EE_ULTDSK := strzero(val(SEE->EE_ULTDSK)+1,6)
	dbcommit()
	MsUnlock()
endif
dbSelectArea("TRAI")  //GERANDO REGISTRO TRAILLER
RecLock("TRAI",.T.)
TRAI->COD_REGIS := "9"
TRAI->NUM_SEQUEN := _nseq
dbcommit()
MsUnlock()

dbSelectArea("HEAD")
COPY TO HEAD.txt SDF
dbSelectArea("DETA")
COPY TO DETA.TXT SDF
dbSelectArea("TRAI")
COPY TO TRAI.TXT SDF
dbSelectArea("REGI")
Append From HEAD.TXT SDF
append From DETA.TXT SDF
Append From TRAI.TXT SDF
ARQ := "\arquivos\COnfederativa\"+MV_PAR04
COPY TO &ARQ SDF
dbSelectArea("MALA")
ARQ := "\arquivos\confederativa\"+MV_PAR16
COPY TO &ARQ 	  && Gera arquivo DBF para mala direta
dbCloseArea()
If File(c_ArqTmp4+".DBF")
	Ferase(c_ArqTmp4+".DBF")
EndIf

// Adiciona 1 ao SX5 da tabela GR - Responsavel pelos contadores de todas as geracoes

/*BEGINDOC
//�����������������������������������������������������</Ow�.�.�
//�	01    	<Title lang="pt">Gera��o Assoc.</Title>         �
//�				<Function>RFINA104</Function>                    �

//�	02			<Title lang="pt">Gera��o Conf.real</Title>      �
//�				<Function>RFINA105</Function>                   �

//�	03			<Title lang="pt">Gera��o Conf.bradesco</Title>  �
//�				<Function>RFINA127</Function>                   �

//�	04			<Title lang="pt">Gera��o Conf.cef</Title>       �
//�				<Function>RFINA137</Function>                   �

//�	05			<Title lang="pt">Gera��o Itau - Cart.173</Title>�
//�				<Function>RFINA135</Function>                   �

//�	06			<Title lang="pt">Gera��o Assist.</Title>        �
//�				<Function>RFINA108</Function>                   �

//�	07			<Title lang="pt">Gera��o Assoc/Conf</Title>     �
//�				<Function>RFINATST</Function>                   �

//�	08			<Title lang="pt">Gera��o Sindical</Title>       �
//�				<Function>RFINA124</Function>                   �
//�����������������������������������������������������</Ow�
ENDDOC*/

IF SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "03" ) )
   RecLock( "SX5", .F. )
   SX5->X5_DESCSPA := Strzero( ( Val( SX5->X5_DESCSPA ) + 1 ), 4 )
   MsUnLock() 
ENDIF   

TOTCAD()

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
if File(c_ArqTmp1+".DBF")
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
cDesc1 := "Este programa ir� gerar o resumo da gera��o da contribui��o."
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "P"
tipo := 15
limite := 220
Titulo := _cTitulo
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
LI := 80
if Li >= 60
    cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
    nLinha := prow() + 1
endif
@ li+ 1,000 PSAY "Registros gerados: "
@ li+ 1,030 psay 	_nRegistros picture "@e 999999"
@ li+ 2,000 PSAY "Registros incluidos: "
@ li+ 2,030 psay 	_nIncluidos picture "@e 999999"
@ li+ 3,000 psay 	"Numero do Bordero "
@ li+ 3,030 psay 	C_BORDERO  PICTURE "@E 999999" 
@ li+ 4,000 psay 	"Numero Sequencial: "
@ li+ 4,030 psay 	VAL( SX5->X5_DESCSPA )-1 PICTURE "@E 999999" 
set device to screen
if aReturn[5] == 1
   set printer to
   dbcommit()
   ourspool(wnrel)
endif
MS_FLUSH()
return

***************************
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
//if MV_PAR09 == 1 .or. MV_PAR09 == 3 .OR. MV_PAR09 == 5
	_cTexto := SA1->A1_END
/*else
	_cTexto := SZC->ZC_END
endif                     */
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->END_SACADO := _cTexto
//if MV_PAR09 == 1 .or. MV_PAR09 == 3 .OR. MV_PAR09 == 5
	_cTexto := SUBSTR(SA1->A1_CEP,1,5)
/*else
	_cTexto := SUBSTR(SZC->ZC_CEP,1,5)
endif*/
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->CEP_SACADO := _cTexto
//if MV_PAR09 == 1 .or. MV_PAR09 == 3 .OR. MV_PAR09 == 5
	_cTexto := SUBSTR(SA1->A1_CEP,6,3)
/*else
	_cTexto := SUBSTR(SZC->ZC_CEP,6,3)
endif*/
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->CEPC_SACADO := _cTexto
return
***************************
Static FUNCTION Calc_Num()
_vNum := "06" + substr(_NossoNum,1,11)
_m1 := val(substr(_vNum,1,1)) * 2
_m2 := val(substr(_vNum,2,1)) * 7
_m3 := val(substr(_vNum,3,1)) * 6
_m4 := val(substr(_vNum,4,1)) * 5
_m5 := val(substr(_vNum,5,1)) * 4
_m6 := val(substr(_vNum,6,1)) * 3
_m7 := val(substr(_vNum,7,1)) * 2
_m8  := val(substr(_vNum,8,1)) * 7
_m9  := val(substr(_vNum,9,1)) * 6
_m10 := val(substr(_vNum,10,1)) * 5
_m11 := val(substr(_vNum,11,1)) * 4
_m12 := val(substr(_vNum,12,1)) * 3
_m13 := val(substr(_vNum,13,1)) * 2
_S1 := _m1 + _m2 + _m3 + _m4 + _m5 + _m6 + _m7 + _m8 + _m9 + _m10 + _m11 + _m12	+ _m13
_r11 := mod (_S1,11)
if _r11 == 0
	_digito := "0"
	DETA->NOSSO_NUM := _NossoNum + _digito
	_NossoNum := _NossoNum + _digito
	return
endif
if _r11 == 1
	_digito := "P"
	DETA->NOSSO_NUM := _NossoNum + _digito
	_NossoNum := _NossoNum + _digito
	return
endif
_digito := str((11 - _r11),1)
DETA->NOSSO_NUM := _NossoNum + _digito
_NossoNum := _NossoNum + _digito
return
