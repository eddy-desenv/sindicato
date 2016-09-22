#include "rwmake.ch"
User Function RFINA104()
SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,N_OPC,CPERG,SAIDA")
SetPrvt("C_BORDERO,_CNUMBORR,_ASTRU,C_ARQTMP,_ASTRU1,C_ARQTMP1")
SetPrvt("_ASTRU2,C_ARQTMP2,_ASTRU3,C_ARQTMP3,_ASTRU4,C_ARQTMP4")
SetPrvt("_DVENC,_DEMIS,_CPERIODO,_NREGISTROS,_NINCLUIDOS,_NSEQ")
SetPrvt("_NVALTOT,_CTEXTO,W,MES,AMES,")
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � RFINA104 � Autor � Andreia dos Santos    � Data � 18/03/98 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Envio de Contribuicoes associativas                        ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico SINDHOSP                                        ���
���          � H:\BCOREAL\ASSOCMM.txt (arquivo para envio)                ���
�������������������������������������������������������������������������Ĵ��
���Obs.:     � E' atualizado os arquivo SE1, SEA,                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
_oldArea  := alias()
_oldOrder := indexord()
cTitulo   := "Cobranca Associativa"
n_Opc := 0
cPerg    := "FINA04"
/*
����������������������������������������������������������������������������Ŀ
� Variaveis utilizadas para parametros                                       �
� mv_par01   // Mes para envio                                               �
� mv_par02   // ano para envio                                               �
� mv_par03   // Data de vencimento                                           �
--�> mv_par04 // Data de Emissao                                             �
--�> mv_par05 // Sequencia                                                   �
� mv_par04   --> mv_par04 // arquivo de saida := "H:\"+strzero(MES,2)+".txt" �
� mv_par05   --> mv_par05 // Codigo Sindicato                                �
� mv_par06   --> mv_par06 // codigo do Banco                                 �
� mv_par07   --> mv_par07 // codigo da agencia                               �
� mv_par08   --> mv_par08   // codigo da conta                               �
� MV_PAR09   --> mv_par09   // codigo da subconta                            �
� mv_par10   --> mv_par10   // Mensagem Linha 01                             �
� mv_par11   --> mv_par11   // Mensagem Linha 02                             �
� mv_par12   --> mv_par12   // Mensagem Linha 03                             �
� mv_par13   --> mv_par13   // Mensagem Linha 04                             �
� MV_PAR14   --> mv_par14   // Mensagem Linha 05                             �
� MV_PAR15   --> mv_par15    � De Data Inicio Sind.           � D       �   8�
� mv_par16   --> mv_par16    � Ate Data Inicio Sind.          � D       �   8�
������������������������������������������������������������������������������
*/

Pergunte(cPerg,.T.)

C_BORDERO := ""
_cNUMBORR := val( getMV("MV_NUMBORR")) +1
C_BORDERO := strzero(_cNUMBORR,6)
@ 096,042 TO 375,505 DIALOG oDlg1 TITLE cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a geracao de Arquivo para cobranca da "
@ 033,014 SAY "Contribuicao Associativa "
@ 043,014 SAY "BORDERO : " + C_BORDERO
@ 063,014 SAY "CONFIRME PARA INICIAR A IMPORTACAO DE DADOS         "

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

_aStru := {}    //REGISTRO HEADER
AADD( _aStru, { "COD_REGIST"  , "C" , 001 , 0 } )
AADD( _aStru, { "CONSTANTE"   , "C" , 025 , 0 } )
AADD( _aStru, { "ZERO"        , "C" , 001 , 0 } )
AADD( _aStru, { "AGE_CEDENT"  , "C" , 004 , 0 } )
AADD( _aStru, { "ZERO2"       , "C" , 001 , 0 } )
AADD( _aStru, { "CTA_CEDENT"  , "C" , 007 , 0 } )
AADD( _aStru, { "VAGO"        , "C" , 007 , 0 } )
AADD( _aStru, { "NOME_CEDEN"  , "C" , 030 , 0 } )
AADD( _aStru, { "IDENT_BANC"  , "C" , 003 , 0 } )
AADD( _aStru, { "NOME_BANCO"  , "C" , 015 , 0 } )
AADD( _aStru, { "DATA_PROCE"  , "C" , 006 , 0 } )
AADD( _aStru, { "CONSTANTE2"  , "C" , 008 , 0 } )
AADD( _aStru, { "VAGO2"       , "C" , 282 , 0 } )
AADD( _aStru, { "SEQUEN_MOV"  , "C" , 004 , 0 } )
AADD( _aStru, { "NUM_SEQUEN"  , "C" , 006 , 0 } )
c_ArqTmp := CriaTrab(_aStru,.t.)
dbUseArea(.t.,,c_ArqTmp,"HEAD")
dbSelectArea("HEAD")
_aStru1 := {}  //REGISTRO TRAILLER
AADD( _aStru1, { "COD_REGIS"  , "C" , 001 , 0 } )
AADD( _aStru1, { "QUANT_REG"  , "C" , 006 , 0 } )
AADD( _aStru1, { "VLR_TOTAL"  , "C" , 013 , 0 } )
AADD( _aStru1, { "VAGO"       , "C" , 374 , 0 } )
AADD( _aStru1, { "NUM_SEQUEN" , "C" , 006 , 0 } )
c_ArqTmp1 := CriaTrab(_aStru1,.t.)
dbUseArea(.t.,,c_ArqTmp1,"TRAI")
dbSelectArea("TRAI")
_aStru2 := {}
AADD( _aStru2, { "COD_REGIST"  , "C" , 001 , 0 } )
AADD( _aStru2, { "COD_INSCRI"  , "C" , 002 , 0 } )
AADD( _aStru2, { "CGC_SDHOSP"  , "C" , 014 , 0 } )
AADD( _aStru2, { "ZERO_1"      , "C" , 001 , 0 } )
AADD( _aStru2, { "AG_CEDENTE"  , "C" , 004 , 0 } )
AADD( _aStru2, { "ZERO_2"      , "C" , 001 , 0 } )
AADD( _aStru2, { "CT_CEDENTE"  , "C" , 007 , 0 } )
AADD( _aStru2, { "VAGO_1"      , "C" , 032 , 0 } )
AADD( _aStru2, { "ZERO_3"      , "C" , 002 , 0 } )
AADD( _aStru2, { "NUMTIT_BAN"  , "C" , 013 , 0 } )
AADD( _aStru2, { "VAGO_2"      , "C" , 031 , 0 } )
AADD( _aStru2, { "COD_OCORRE"  , "C" , 002 , 0 } )
AADD( _aStru2, { "VAGO_3"      , "C" , 010 , 0 } )
AADD( _aStru2, { "DATA_VENC"   , "C" , 006 , 0 } )
AADD( _aStru2, { "VLR_TITULO"  , "C" , 013 , 0 } )
AADD( _aStru2, { "IDENT_BANC"  , "C" , 003 , 0 } )
AADD( _aStru2, { "VAGO_4"      , "C" , 005 , 0 } )
AADD( _aStru2, { "ESP_TITULO"  , "C" , 002 , 0 } )
AADD( _aStru2, { "VAGO_5"      , "C" , 001 , 0 } )
AADD( _aStru2, { "DATA_EMISS"  , "C" , 006 , 0 } )
AADD( _aStru2, { "VAGO_6"      , "C" , 004 , 0 } )
AADD( _aStru2, { "JUROS_MORA"  , "C" , 013 , 0 } )
AADD( _aStru2, { "DATA_DESCO"  , "C" , 006 , 0 } )
AADD( _aStru2, { "VLR_DESCON"  , "C" , 013 , 0 } )
AADD( _aStru2, { "VLR_IOC"     , "C" , 013 , 0 } )
AADD( _aStru2, { "VLR_ABATIM"  , "C" , 013 , 0 } )
AADD( _aStru2, { "CPF_OU_CGC"  , "C" , 002 , 0 } )
AADD( _aStru2, { "CGC_SACADO"  , "C" , 014 , 0 } )
AADD( _aStru2, { "NOME_SACAD"  , "C" , 040 , 0 } )
AADD( _aStru2, { "END_SACADO"  , "C" , 040 , 0 } )
AADD( _aStru2, { "BAIRRO_SAC"  , "C" , 012 , 0 } )
AADD( _aStru2, { "CEP_SACADO"  , "C" , 008 , 0 } )
AADD( _aStru2, { "CIDADE_SAC"  , "C" , 015 , 0 } )
AADD( _aStru2, { "ESTADO_SAC"  , "C" , 002 , 0 } )
AADD( _aStru2, { "SACADOR"     , "C" , 040 , 0 } )
AADD( _aStru2, { "VAGO_7"      , "C" , 001 , 0 } )
AADD( _aStru2, { "VLR_MOEDA"   , "C" , 001 , 0 } )
AADD( _aStru2, { "TIPO_MOEDA"  , "C" , 001 , 0 } )
AADD( _aStru2, { "NUM_SEQUEN"  , "C" , 006 , 0 } )
c_ArqTmp2 := CriaTrab(_aStru2,.t.)
dbUseArea(.t.,,c_ArqTmp2,"DETA")
dbSelectArea("DETA")
_aStru3 := {}  //ARQUIVO FINAL
AADD( _aStru3, { "REGISTRO"  , "C" , 400 , 0 } )
c_ArqTmp3 := CriaTrab(_aStru3,.t.)
dbUseArea(.t.,,c_ArqTmp3,"REGI")
dbSelectArea("REGI")
_aStru4 := {}
AADD( _aStru4, { "COD_REGIS"  , "C" , 001 , 0 } )
AADD( _aStru4, { "SEQ_REGMSG" , "C" , 001 , 0 } )
AADD( _aStru4, { "AG_CEDENTE" , "C" , 004 , 0 } )
AADD( _aStru4, { "CT_CEDENTE" , "C" , 007 , 0 } )
AADD( _aStru4, { "ZERO_1"     , "C" , 002 , 0 } )
AADD( _aStru4, { "NUMTIT_BAN" , "C" , 013 , 0 } )

AADD( _aStru4, { "MENSAGEM_1" , "C" , 069 , 0 } )
AADD( _aStru4, { "CODLOCAL_1" , "C" , 001 , 0 } )

AADD( _aStru4, { "MENSAGEM_2" , "C" , 069 , 0 } )
AADD( _aStru4, { "CODLOCAL_2" , "C" , 001 , 0 } )

AADD( _aStru4, { "MENSAGEM_3" , "C" , 069 , 0 } )
AADD( _aStru4, { "CODLOCAL_3" , "C" , 001 , 0 } )

AADD( _aStru4, { "MENSAGEM_4" , "C" , 069 , 0 } )
AADD( _aStru4, { "CODLOCAL_4" , "C" , 001 , 0 } )

AADD( _aStru4, { "MENSAGEM_5" , "C" , 069 , 0 } )
AADD( _aStru4, { "CODLOCAL_5" , "C" , 001 , 0 } )

AADD( _aStru4, { "VAGO"       , "C" , 016 , 0 } )
AADD( _aStru4, { "NUM_SEQUEN" , "C" , 006 , 0 } )
c_ArqTmp4 := CriaTrab(_aStru4,.t.)
dbUseArea(.t.,,c_ArqTmp4,"MSG")
dbSelectArea("MSG")
_DVenc := strzero(day(mv_par03),2)+strzero(month(mv_par03),2)+strzero(val(substr(str(year(mv_par03),4),3,2)),2)
_Demis := strzero(day(dDataBase),2)+strzero(month(dDataBase),2)+strzero(val(substr(str(year(dDataBase),4),3,2)),2)
dbSelectArea("HEAD")  //GERANDO REGISTRO HEADER
RecLock("HEAD",.T.)
HEAD->COD_REGIST  := "0"
HEAD->CONSTANTE   := "1REMESSA01COBRANCA"
HEAD->ZERO        := "0"
HEAD->AGE_CEDENT  := MV_PAR08 // "1874" - Nava
HEAD->ZERO2       := "0"
HEAD->CTA_CEDENT  := MV_PAR09 // "7710534" - Nava
HEAD->NOME_CEDEN  := "SINDHOSP-SIND.HOSPITAIS EST SP"
HEAD->IDENT_BANC  := MV_PAR07 //"356" - Nava
HEAD->NOME_BANCO  := "BANCO REAL S.A."
HEAD->DATA_PROCE  := _Demis
HEAD->CONSTANTE2  := "01600BPI"
HEAD->SEQUEN_MOV  := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "01" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" )
HEAD->NUM_SEQUEN  := "000001"
DBCOMMIT()
MsUnLock()
dbSelectArea("HEAD")
COPY TO HEAD.txt SDF
dbSelectArea("REGI")	      // Gera Header
Append From HEAD.TXT SDF
_cPeriodo := substr(_DVenc,5,2) + substr(_DVenc,3,2)
dbSelectArea("SA1")
dbsetorder(3)
dbGotop()
ProcRegua(RecCount(),18,05)
_nRegistros := 0
_nIncluidos := 0
_cTitulo := "Gerando Arquivo Bancario - Associativa"
_NSEQ := "000002"
_nValTot := 0
_cNUMBORR := val( getMV("MV_NUMBORR")) +1
Do While !Eof()
	IncProc("Cliente: "+sa1->a1_cod+"-"+sa1->a1_nreduz)
	IF LEN(ALLTRIM(SA1->A1_CEP))<> 8
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF

	dbSelectArea("SA1")

	// Rodrigo - Desabilitado porque todas as naturezas jah sao 1.000
/*
	if sa1->a1_catleit $"66/67/68/70/71/72"
		reclock("sa1",.f.)
		sa1->a1_naturez:="1000"
		msunlock()
	endif
*/
	If ! EMPTY( MV_PAR05) .AND. SA1->A1_SINDICA <> MV_PAR05
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	If !EMPTY(SA1->A1_INAT)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	if ALLTRIM(SA1->A1_NATUREZ)=="1000"
		dbskip()
		Loop
	EndIf

	IF !EMPTY(MV_PAR16) .AND. SA1->A1_INISIND < MV_PAR16
		dbskip()
		Loop
	EndIf
	
	IF !EMPTY(MV_PAR17) .AND. SA1->A1_INISIND > MV_PAR17
		dbskip()
		Loop
	EndIf

	If empty(SA1->A1_CODASSO)
		dbskip()
		Loop
	Endif
	if SA1->A1_SITUAC <> "AS" .and. SA1->A1_SITUAC <> "SS"
		dbskip()
		Loop
	Endif
	If !empty(SA1->A1_DTFIMAS)
		dbskip()
		Loop
	Endif
	if val(SA1->A1_CATLEIT) <= 0
		dbskip()
		Loop
	Endif
	if val( TABELA("90",SA1->A1_CATLEIT) ) <= 0
		dbskip()
		Loop
	Endif

	dbSelectArea("SE1")
	dbsetorder(1)
	dbseek(xFilial()+strzero(MV_PAR02,2)+" "+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4))
	if !eof()
		dbSelectArea("SA1")
		dbskip()
		Loop
	Endif
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	RecLock("DETA",.T.)
	DETA->COD_REGIST := "1"
	DETA->COD_INSCRI := "02"
	DETA->CGC_SDHOSP := "47436373000173"
	DETA->ZERO_1     := "0"
	DETA->AG_CEDENTE := MV_PAR08 // "1874" - Nava
	DETA->ZERO_2     := "0"
	DETA->CT_CEDENTE := MV_PAR09 // "7710534" - Nava
	DETA->ZERO_3     := "00"
	DETA->NUMTIT_BAN := strzero(MV_PAR02,2)+"0"+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)+"0000"
	DETA->COD_OCORRE := "01"
	DETA->DATA_VENC  := _DVenc
	DETA->VLR_TITULO := strzero(val( TABELA("90",SA1->A1_CATLEIT) )*100,13)
	DETA->IDENT_BANC := MV_PAR07 //"356" - Nava
	DETA->ESP_TITULO := "01"
	DETA->DATA_EMISS := _Demis
	DETA->JUROS_MORA := "0000000000000"
	DETA->DATA_DESCO := "000000"
	DETA->VLR_DESCON := "0000000000000"
	DETA->VLR_IOC    := "0000000000000"
	DETA->VLR_ABATIM := "0000000000000"
	DETA->CPF_OU_CGC := "02"
	DETA->CGC_SACADO := SA1->A1_CGC
	Ver_Ascii()
	DETA->SACADOR    := "SINDICATO DOS HOSPITAIS DO EST.SAO PAULO"
	DETA->VLR_MOEDA  := "7"
	DETA->TIPO_MOEDA := "7"
	DETA->NUM_SEQUEN := _nseq     //Sequencia
	dbcommit()
	MsUnlock()
	_nValTot := _nValTot + val( TABELA("90",SA1->A1_CATLEIT) )
	_nRegistros := _nRegistros + 1
	_nseq := strzero((val(_nSeq)+1),6)
	dbSelectArea("MSG")  //GERANDO REGISTRO MENSAGEM
	RecLock("MSG",.T.)
	MSG->COD_REGIS  := "7"
	MSG->SEQ_REGMSG := "1"
	MSG->AG_CEDENTE := MV_PAR08 // "1874" - Nava
	MSG->CT_CEDENTE := MV_PAR09 // "7710534" - Nava
	MSG->ZERO_1     := "00"
	MSG->NUMTIT_BAN := strzero(MV_PAR02,2)+"0"+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)+"0000"
	MSG->MENSAGEM_1 := MV_PAR11
	MSG->CODLOCAL_1 := "3"
	MSG->MENSAGEM_2 := MV_PAR12
	MSG->CODLOCAL_2 := "3"
	MSG->MENSAGEM_3 := MV_PAR13
	MSG->CODLOCAL_3 := "3"
	MSG->MENSAGEM_4 := MV_PAR14
	MSG->CODLOCAL_4 := "3"
	MSG->MENSAGEM_5 := MV_PAR15
	MSG->CODLOCAL_5 := "3"
	MSG->NUM_SEQUEN := _nseq     //Sequencia
	dbcommit()
	MsUnlock()
	Do While ! (MSG->NUMTIT_BAN == strzero(MV_PAR02,2)+"0"+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)+"0000" )
	EndDo
	_nRegistros := _nRegistros + 1
	_nseq := strzero((val(_nSeq)+1),6)
	dbSelectArea("SE1")  //GERANDO Contas a receber
	dbseek(xFilial()+strzero(MV_PAR02,2)+" "+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4))
	if eof()
		RecLock("SE1",.T.)
		SE1->E1_FILIAL   := xFilial()
		SE1->E1_PREFIXO  := strzero(MV_PAR02,2)+" "
		SE1->E1_NUM      := strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)
		SE1->E1_PARCELA  := ""
		SE1->E1_TIPO     := "DP"
		SE1->E1_NATUREZ  := mv_par06
		SE1->E1_CLIENTE  := SA1->A1_COD
		SE1->E1_LOJA     := SA1->A1_LOJA
		SE1->E1_NOMCLI   := SA1->A1_NREDUZ
		SE1->E1_EMISSAO  := dDataBase
		SE1->E1_VENCTO   := mv_par03
		SE1->E1_VENCREA  := DataValida( mv_par03,.t.)
		SE1->E1_VALOR    := val( TABELA("90",SA1->A1_CATLEIT) )
		SE1->E1_EMIS1    := dDataBase
		SE1->E1_SITUACA  := "0"
		SE1->E1_SALDO    := val( TABELA("90",SA1->A1_CATLEIT) )
		SE1->E1_VLCRUZ   := val( TABELA("90",SA1->A1_CATLEIT) )
		SE1->E1_VALJUR   := 1
		SE1->E1_VENCORI  := mv_par03
		SE1->E1_MOEDA    := 1
		SE1->E1_HIST     := "Ref.Contr.Assoc. de "+strzero(mv_par01,2)+"/"+strzero(mv_par02,2)
		//APOS BORDERO
		SE1->E1_PORTADO := MV_PAR07 //"356" - Nava
		SE1->E1_AGEDEP  := MV_PAR08 // "1874" - Nava
		SE1->E1_CONTA   := MV_PAR09 // "7710534" - Nava
		SE1->E1_NUMBOR  :=  strzero(_cNUMBORR,6)  //NUMERO DO BORDERO
		C_BORDERO       :=  strzero(_cNUMBORR,6)  //NUMERO DO BORDERO
		SE1->E1_DATABOR :=  DDatabase //DATA DO BORDERO
		SE1->E1_MOVIMEN :=  DDatabase
		SE1->E1_SITUACA := "1"
		SE1->E1_OCORREN := "01"
		SE1->E1_ORIGEM  := "FINA040"
		SE1->E1_STATUS  := "A"
		SE1->E1_OK      := CHR(56)+CHR (121)
		SE1->E1_CGC     := SA1->A1_CGC
		SE1->E1_CODASSO := SA1->A1_CODASSO
		SE1->E1_CATEG1  := SA1->A1_CATEG1
		SE1->E1_ERSIN   := SA1->A1_ERSIN
		SE1->E1_BASE    := SA1->A1_BASE
		SE1->E1_SINDICA := SA1->A1_SINDICA
		//APOS GERACAO
		//    SE1->E1_NUMBCO := //NOSSO NUMERO
		_nIncluidos := _nIncluidos+1
		dbcommit()
		MsUnlock()
		//ATUALIZA-SE O SEA
		dbSelectArea("SEA")  //GERANDO Contas a receber
		RecLock("SEA",.T.)
		SEA->EA_FILIAL  := xFilial()
		SEA->EA_PREFIXO := strzero(MV_PAR02,2)+" "
		SEA->EA_PARCELA := ""
		SEA->EA_NUM     := strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)
		SEA->EA_PORTADO := MV_PAR07 //"356" - Nava
		SEA->EA_AGEDEP  := MV_PAR08 // "1874" - Nava
		SEA->EA_NUMCON  := MV_PAR09 // "7710534" - Nava
		SEA->EA_NUMBOR  := strzero(_cNUMBORR,6)
		SEA->EA_DATABOR :=  dDatabase
		SEA->EA_TIPO    := "DP"
		SEA->EA_CART    := "R"
		SEA->EA_SITUACA := "1"
		//APOS GERAR ARQUIVO
		SEA->EA_TRANSF := "S"
		dbcommit()
		MsUnlock()
		RecLock("SA1",.F.)
		SA1->A1_MCOMPRA := SA1->A1_MCOMPRA +val( TABELA("90",SA1->A1_CATLEIT) )
		SA1->A1_SALDUP  := SA1->A1_SALDUP +val( TABELA("90",SA1->A1_CATLEIT) )
		SA1->A1_PRICOM  := if(empty(SA1->A1_PRICOM),dDataBase,SA1->A1_PRICOM)
		SA1->A1_ULTCOM  := dDataBase
		dbcommit()
		MsUnlock()
	ENDIF
	dbSelectArea("SA1")
	dbskip()
End

/*

dbselectArea("SI2")
dbsetorder(3)
dbseek( xFilial() + dtos(dDataBase) + "7500" )
if _nvalTot > 0 .and. eof()
	recLock("SI2",.T.)
	SI2->I2_FILIAL := "01"
	SI2->I2_NUM    := "7500001"
	SI2->I2_LINHA  := "01"
	SI2->I2_DATA   := mv_par03
	SI2->I2_DC     := "X"
	SI2->I2_MOEDAS := "SNNNN"
	SI2->I2_VALOR  := _nvalTot
	SI2->I2_DTVENC := mv_par03
	SI2->I2_ROTINA := "RFINA104"
	SI2->I2_PERIODO:= _cPeriodo
	SI2->I2_ORIGEM := "L.GER P/RFINA04"
	SI2->I2_FILORIG:= "01"
	SI2->I2_DEBITO := "1123010001"
	SI2->I2_CREDITO:= "3111040001"
	SI2->I2_HIST   := "PROVISAO REFERENTE AO MES " + strzero(mv_par01) + "/" + strzero(mv_par02)
	MsUnlock()
endif


// Adiciona 1 ao SX!

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


IF SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "01" ) )
   RecLock( "SX5", .F. )
   SX5->X5_DESCSPA := Strzero( ( Val( SX5->X5_DESCSPA ) + 1 ), 4 )
   MsUnLock() 
ENDIF   

PUTMV( "MV_NUMBORR", strzero(_cNUMBORR,6) )

//ATUALIZA-SE O SEE
dbSelectArea("SEE")  //GERANDO Contas a receber
if dbseek( xFilial()+MV_PAR07+MV_PAR08+MV_PAR09+MV_PAR10 )
	RecLock("SEE",.F.)
	SEE->EE_ULTDSK := strzero(val(SEE->EE_ULTDSK)+1,6)
	dbcommit()
	MsUnlock()
Endif
dbSelectArea("TRAI")  //GERANDO REGISTRO TRAILLER
RecLock("TRAI",.T.)
TRAI->COD_REGIS := "9"
TRAI->QUANT_REG := Strzero( _nRegistros,6 )
TRAI->VLR_TOTAL := substr(strzero(_nValTot,13,2),1,10)+ ;
substr(strzero(_nValTot,13,2),12,2)
TRAI->NUM_SEQUEN := strzero(val(_nSeq),6) //INCREMENTA()
dbcommit()
MsUnlock()

dbSelectArea("TRAI")
COPY TO TRAI.TXT SDF
dbSelectArea("DETA")
DbGotop()
dbSelectArea("MSG")
DbGotop()
Do While !(MSG->(eof()))
	dbSelectArea("DETA")
	COPY NEXT 1 TO DETA.TXT SDF
	dbSelectArea("MSG")
	COPY NEXT 1 TO MSG.TXT SDF
	dbSelectArea("REGI")	  // Gera Detalhes e Mensagem
	Append From DETA.TXT SDF
	Append From MSG.TXT SDF
	dbSelectArea("DETA")
//	DbSkip()
	dbSelectArea("MSG")
//	DbSkip()
EndDo
dbSelectArea("REGI")	    // Gera Trailler
Append From TRAI.TXT SDF
ARQ := "\arquivos\associativa\"+MV_PAR04
COPY TO &arq SDF	    // Copia arq. definitivo

TOTCAD()

@ 96,42 TO 290,405 DIALOG oDlg1 TITLE "Termino da Geracao"
@ 8,10 TO 73,170
@ 23,22 SAY "Registros Gerados"
@ 23,95 GET _nRegistros PICTURE "@E 999,999" WHEN .F.
@ 38,22 SAY "Registros Incluidos"
@ 38,95 GET _nIncluidos PICTURE "@E 999,999" WHEN .F.
@ 53,22 SAY "Numero do Bordero "
@ 53,95 GET C_BORDERO  PICTURE "@E 999999" WHEN .F.
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
dbSelectArea("MSG")
dbCloseArea()
If File(c_ArqTmp4+".DBF")
	Ferase(c_ArqTmp4+".DBF")
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
DETA->NOME_SACAD := _cTexto
_cTexto := SA1->A1_END
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->END_SACADO := _cTexto
_cTexto := SA1->A1_CEP
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->CEP_SACADO := _cTexto
_cTexto := SA1->A1_MUN
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->CIDADE_SAC := _cTexto
_cTexto := SA1->A1_EST
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->ESTADO_SAC := _cTexto
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
wnrel :=  "RFINA104"
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
@ li+ 4,030 psay 	VAL( SX5->X5_DESCSPA ) - 1 PICTURE "@E 999999" 
set device to screen
if aReturn[5] == 1
   set printer to
   dbcommit()
   ourspool(wnrel)
endif
MS_FLUSH()
return

