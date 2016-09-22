#include "rwmake.ch"
#include "topconn.ch"
User Function RELempr()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ RELASSOC ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 14.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao relatorio de Associados                          ³±±
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
cDesc1 := "Este programa irá imprimir a relatorio de Cadastro de Empresas"
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Cadastro de Empresas"
cabec2 := ""
cabec1 := "Sind.  Nome                                                CNPJ                Socio   Telefone             Natureza    AS  SS  IS  FIL  Cidade                         Inic.Assoc.  Fim Assoc. Categoria  Inativo"
//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22        23
aReturn := { "Zebrado", 1,"Administração", 4, 2, 1, "",1 }
nomeprog := "RELASSOC"
nLastkey := 0
cPerg := "RELEMP"
/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ 01       ¦ Natureza                       ¦ C       ¦         10³
//³ 02       ¦ Quais Ersin                    ¦ C       ¦         30³
//³ 03       ¦ Qual Cidade                    ¦ C       ¦         25³
//³ 04       ¦ Quais Bases                    ¦ C       ¦         50³
//³ 05       ¦ Quais Categorias               ¦ C       ¦         50³
//³ 06       ¦ Categoria de                   ¦ C       ¦          5³
//³ 07       ¦ Categoria Ate                  ¦ C       ¦          5³
//³ 08       ¦ Filantropico                   ¦ N       ¦          1³
//³ 09       ¦ Qual Cliente                   ¦ C       ¦          6³
//³ 10       ¦ Valor de                       ¦ N       ¦         17³
//³ 11       ¦ Valor ate                      ¦ N       ¦         17³
//³ 12       ¦ Qual Ordem ?                   ¦ N       ¦          1³
//³ 13       ¦ Data de Cadastro ate           ¦ D       ¦          8³
//³ 13       ¦ Quanto Impressao               ¦ N       ¦          1³
//³ 14       ¦ Data Inicio Assoc de           ¦ D       ¦          8³
//³ 15       ¦ Data Inicio Assoc ate          ¦ D       ¦          8³
//³ 16       ¦ Data Fim Assoc de              ¦ D       ¦          8³
//³ 17       ¦ Data Fim Assoc ate             ¦ D       ¦          8³
//³ 18       ¦ Quais Situacoes                ¦ C       ¦         15³
//³ 19       ¦ Sindicato Hospitais            ¦ C       ¦          2³
//³ 20       ¦ De Data Inicio Sind.           ¦ D       ¦          8³
//³ 21       ¦ Ate Data Inicio Sind.          ¦ D       ¦          8³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

m_pag := 1
li := 0
pergunte(cPerg,.f.)
wnrel := "RELASSOC"
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)
if nLastkey == 27
	return
endif
SetDefault(aReturn,cString)
if nLastkey == 27
	return
endif
RptStatus({|| impREL() },titulo)
Return
**********
Static function ImpREL()
_aEstr := {}

AADD(_aEstr,{"NATUREZA"  , "C" , 10 , 0})
AADD(_aEstr,{"SOC_AS"    , "C" , 01 , 0})
AADD(_aEstr,{"SOC_SS"    , "C" , 01 , 0})
AADD(_aEstr,{"SOC_IS"    , "C" , 01 , 0})
AADD(_aEstr,{"SOC_CT"    , "C" , 01 , 0})
AADD(_aEstr,{"SOC_FIL"   , "C" , 01 , 0})
AADD(_aEstr,{"VALOR"     , "N" , 17 , 2})
AADD(_aEstr,{"BASE"      , "C" , 04 , 0})


AADD(_aEstr,{"CODIGO"    , "C" , 06 , 0})
AADD(_aEstr,{"NOME"      , "C" , 50 , 0})
AADD(_aEstr,{"NOMEfanta" , "C" , 50 , 0})
AADD(_aEstr,{"ENDERECO"  , "C" , 40 , 0})
AADD(_aEstr,{"BAIRRO"    , "C" , 25 , 0})
AADD(_aEstr,{"CEP"       , "C" , 08 , 0})
AADD(_aEstr,{"CIDADE"    , "C" , 25 , 0})
AADD(_aEstr,{"ESTADO"    , "C" , 02 , 0})
AADD(_aEstr,{"TIPOEND"   , "C" , 10 , 0})
AADD(_aEstr,{"CNPJ"      , "C" , 14 , 0})
AADD(_aEstr,{"DDD"       , "C" , 02 , 0})
AADD(_aEstr,{"FONE"      , "C" , 15 , 0})
AADD(_aEstr,{"FONE2"     , "C" , 15 , 0})
AADD(_aEstr,{"FONE3"     , "C" , 15 , 0})
AADD(_aEstr,{"EMAIL"     , "C" , 60 , 0})
AADD(_aEstr,{"EMAIL2"    , "C" , 60 , 0})
AADD(_aEstr,{"EMAIL3"    , "C" , 60 , 0})
AADD(_aEstr,{"CONTATO"   , "C" , 40 , 0})

AADD(_aEstr,{"SINDMED"   , "C" , 04 , 0})
AADD(_aEstr,{"ERSIN"     , "C" , 02 , 0})
AADD(_aEstr,{"SOCIO"     , "C" , 01 , 0})
AADD(_aEstr,{"CATEGORIA" , "C" , 05 , 0})
AADD(_aEstr,{"DATAINICIO", "D" , 08 , 0})
AADD(_aEstr,{"DATAFIM"   , "D" , 08 , 0})
AADD(_aEstr,{"DTCADASTRO", "D" , 08 , 0})
AADD(_aEstr,{"SITUACAO"  , "C" , 02 , 0})
AADD(_aEstr,{"CODASSO"   , "C" , 06 , 0})
AADD(_aEstr,{"FAX"       , "C" , 25 , 0})
AADD(_aEstr,{"CARTAO"    , "C" , 06 , 0}) 
AADD(_aEstr,{"LEITOS"    , "N" , 10 , 0}) 
AADD(_aEstr,{"NUM_FUNC"  , "N" , 10 , 0}) 
AADD(_aEstr,{"FILANT"    , "C" , 01 , 0})
AADD(_aEstr,{"ESCCONT"   , "C" , 14 , 0})
AADD(_aEstr,{"SINDICA"   , "C" , 02 , 0})
AADD(_aEstr,{"VALASSO"   , "N" , 08 , 2})
AADD(_aEstr,{"CATLEIT"   , "C" , 02 , 0})
AADD(_aEstr,{"FISICO"    , "C" , 01 , 0})
AADD(_aEstr,{"HISTASS"   , "C" , 80 , 0})
AADD(_aEstr,{"SCONTAT"   , "C" , 40 , 0})
AADD(_aEstr,{"EMAIL4"    , "C" , 60 , 0})
AADD(_aEstr,{"NOMPRES"   , "C" , 40 , 0})
AADD(_aEstr,{"EMAIL5"    , "C" , 60 , 0})
AADD(_aEstr,{"ADMPROV"   , "C" , 40 , 0})
AADD(_aEstr,{"EMAIL6"    , "C" , 60 , 0})
AADD(_aEstr,{"SUPERIN"   , "C" , 40 , 0})
AADD(_aEstr,{"EMAIL7"    , "C" , 60 , 0})
AADD(_aEstr,{"DIRCLIN"   , "C" , 40 , 0})
AADD(_aEstr,{"EMAIL8"    , "C" , 60 , 0})
AADD(_aEstr,{"DIRFIN"    , "C" , 40 , 0})
AADD(_aEstr,{"EMAIL9"    , "C" , 60 , 0})
AADD(_aEstr,{"DIRRH"     , "C" , 40 , 0})
AADD(_aEstr,{"EMAIL0"    , "C" , 60 , 0})
AADD(_aEstr,{"DIRADM"    , "C" , 40 , 0})
AADD(_aEstr,{"EMAIL10"   , "C" , 60 , 0})
AADD(_aEstr,{"CADATIV"   , "D" , 08 , 0})
//
AADD(_aEstr,{"CODDESCINA"	, "C" , 02 , 0})
AADD(_aEstr,{"DESCRINAT"	, "C" , 60 , 0})
AADD(_aEstr,{"TPCADAS"	 	, "C" , 01 , 0})
//
AADD(_aEstr,{"COML"    , "C" , 40 , 0})
AADD(_aEstr,{"EMAIL12"   , "C" , 60 , 0})

AADD(_aEstr,{"ADVOGA"		, "C" , 40 , 0})	
AADD(_aEstr,{"EMAIL11"		, "C" , 60 , 0})
AADD(_aEstr,{"INAT"			, "C" , 01 , 0})		
AADD(_aEstr,{"DATINAT"		, "D" , 08 , 0})		
//
AADD(_aEstr,{"CAPITAL1"		, "N" , 15 , 2})


c_ArqImp := CriaTrab(_aEstr,.t.)
dbusearea(.t.,,c_ArqImp,"TMP",.T.)
dbselectarea("TMP")
CQUERY := " SELECT * FROM "+RETSQLNAME("SA1")+" SA1 "
CQUERY += " WHERE D_E_L_E_T_='' "
CQUERY += " AND A1_CATEG1 BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"' "

	CQUERY += " AND A1_SINDICA between '"+MV_PAR19+"' and '"+mv_par20+"' "

IF !EMPTY(MV_PAR21)
	CQUERY += " AND A1_INISIND>='"+DTOS(MV_PAR21)+"' "
ENDIF

IF !EMPTY(MV_PAR22)
	CQUERY += " AND A1_INISIND<='"+DTOS(MV_PAR22)+"' "
ENDIF

IF !EMPTY(MV_PAR01)
	CQUERY += " AND A1_NATUREZ='"+MV_PAR01+"' "
ENDIF
IF !EMPTY(MV_PAR14)
	CQUERY += " AND A1_DTINASS BETWEEN '"+DTOS(MV_PAR14)+"' AND '"+DTOS(MV_PAR15)+"' "
ENDIF
IF !EMPTY(MV_PAR16)
	CQUERY += " AND A1_DTFIMAS BETWEEN '"+DTOS(MV_PAR16)+"' AND '"+DTOS(MV_PAR17)+"' "
ENDIF
IF !EMPTY(MV_PAR24)
	CQUERY += " AND A1_DTCADAS BETWEEN '"+DTOS(MV_PAR24)+"' AND '"+DTOS(MV_PAR25)+"' "
ENDIF
IF !EMPTY(MV_PAR27)
	CQUERY += " AND A1_CADATIV BETWEEN '"+DTOS(MV_PAR27)+"' AND '"+DTOS(MV_PAR28)+"' "
ENDIF                                                                                 
IF !EMPTY(MV_PAR29)
	CQUERY += " AND A1_DATINAT BETWEEN '"+DTOS(MV_PAR29)+"' AND '"+DTOS(MV_PAR30)+"' "
ENDIF


IF !EMPTY(MV_PAR02)
	CQUERY += " AND  A1_ERSIN IN "+FORMATIN(alltrim(MV_PAR02),"/")
ENDIF
IF !EMPTY(MV_PAR03)
	CQUERY += " AND  A1_MUN ='"+MV_PAR03+"' "
ENDIF
IF !EMPTY(MV_PAR04)
	CQUERY += " AND  A1_BASE IN "+FORMATIN(alltrim(MV_PAR04),"/")
ENDIF
IF !EMPTY(MV_PAR05)
	CQUERY += " AND  A1_CATEG1 IN "+FORMATIN(alltrim(MV_PAR05),"/")
ENDIF
IF MV_PAR08 == 2
	CQUERY += " AND  A1_FILANT IN ('X','S') "
ELSEIF MV_PAR08 == 3
	CQUERY += " AND  A1_FILANT NOT IN ('X','S') "
ENDIF
IF !EMPTY(MV_PAR09)
	CQUERY += " AND  A1_COD ='"+MV_PAR09+"' "
ENDIF
IF !EMPTY(MV_PAR18)
	CQUERY += " AND  A1_SITUAC IN "+FORMATIN(alltrim(MV_PAR18)+"/  ","/")
ENDIF                                                                       
IF MV_PAR26 =2
	CQUERY += " AND A1_SITUAC IN ('  ','IS')  "
ELSEIF MV_PAR26 == 1
	CQUERY += " AND A1_SITUAC NOT IN ('  ','IS')  "
ENDIF    
if mv_par31 == 2
	cquery += " AND A1_INAT<>'X' "
ELSEif mv_par31 == 3
	cquery += " AND A1_INAT='X' "
ENDIF
IF MV_PAR12 == 1
	CQUERY += " ORDER BY A1_SINDICA,A1_ERSIN,A1_NOME "
ELSEIF MV_PAR12 == 2
	CQUERY += " ORDER BY A1_SINDICA,A1_ERSIN,A1_CGC "
ELSEIF MV_PAR12 == 3
	CQUERY += " ORDER BY A1_SINDICA,A1_ERSIN,A1_CODASSO "
ENDIF
TCQUERY cQuery NEW ALIAS "TRB"
LI := 80
DBSELECTAREA("TRB")
dbgotop()
REGS := 0
SETREGUA(RECCOUNT())
totAS := totSS := totCT := totfiLANT := totTOTAL := totIS := totvalor := TOTNS :=0
DO WHILE !EOF()
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	SINDANT := TRB->A1_SINDICA                                                                                                   
	SINDAS := SINDSS := SINDCT := SINDFILANT := SINDTOTAL := SINDIS := SINDvalor := SINDNS :=0
	ERSINANT := TRB->A1_ERSIN
	ERSINAS := ERSINSS := ERSINCT := ERSINFILANT := ERSINTOTAL := ERSINIS := ersinvalor := ERSINNS := 0
	Dbselectarea("SA1")
	dbOrderNickName('8')  // dbSETORDER(8) // Alterado (UPDXFUN).
	DBSEEK(XFILIAL("SA1")+TRB->A1_CODASSO)
	cSindicato := trb->A1_SINDICA
	dbSETORDER(1) // Atencao (UPDXFUN).

	dbselectarea("sx5")
	dbSETORDER(1)
	DBSEEK(XFILIAL()+"96"+TRB->A1_ERSIN)
	NOMESIND = ""
	IF TRB->A1_SINDICA=="02"
		NOMESIND = "SINDHOSPRU"
	ELSEIF TRB->A1_SINDICA=="03"
		NOMESIND = "SINDRIBEIRAO"
		//NOMESIND = "SINDHORP" Márcio 24/03/2015
	ELSEIF TRB->A1_SINDICA=="04"
		NOMESIND = "SINDMOGIDASCRUZES"
		//NOMESIND = "SINDHOSCLAB-MOGI" Márcio 24/03/2015
	ELSEIF TRB->A1_SINDICA=="05"
		NOMESIND = "SINDJUNDIAI"
		//NOMESIND = "SINDHOSCLAB-JUNDIAI"Márcio 24/03/2015
	ELSEIF TRB->A1_SINDICA=="06"
		NOMESIND = "SINDSUZANO" 
		//NOMESIND = "SINDHOSCLAB-SUZANO"Márcio 24/03/2015
	ENDIF

	@ li+0,000 psay "SINDICATO "+cSindicato+" "+NOMESIND
	li++
//	@ li+1,000 psay "ERSIN: "+TRB->A1_ersin+" - "+sx5->x5_descri
	LI+=3                                                                                              
	DBSELECTAREA("TRB")
	DO WHILE !EOF() .AND. TRB->A1_SINDICA == SINDANT

		if Li >= 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		endif
		IF TRB->A1_VALASSO < MV_PAR10 .OR. TRB->A1_VALASSO> MV_PAR11
			DBSELECTAREA("TRB")
			DBSKIP()
			LOOP
		ENDIF
		DBSELECTAREA("TMP")
		RECLOCK("TMP",.T.)
		TMP->ERSIN     := TRB->A1_ERSIN
		TMP->NOME      := TRB->A1_NOME
		tmp->nomefanta := trb->a1_nreduz
		TMP->CNPJ      := TRB->A1_CGC
		TMP->NATUREZA  := TRB->A1_NATUREZ
		TMP->CODIGO    := TRB->A1_CODASSO
		TMP->DDD       := TRB->A1_DDD
		TMP->FONE      := TRB->A1_tel
		IF TRB->A1_SITUAC == "AS"
			TMP->SOC_AS    := "X"
			ERSINAS ++
			sindas++
		elseiF TRB->A1_SITUAC == "SS"
			TMP->SOC_SS    := "X"
			ERSINSS++
   		sindss ++
		elseIF TRB->A1_SITUAC == "IS"
			TMP->SOC_IS    := "X"
			ERSINIS ++
			sindis ++
		ELSE
			ERSINNS ++
			sindNS++
		
		ENDIF
		IF TRB->A1_FILANT == "X"
			tmp->SOC_FIL   := "X"
		endif
		tmp->CIDADE    := trb->a1_mun
		tmp->VALOR     := trb->a1_valasso
		tmp->categoria := trb->a1_categ1
		tmp->BASE      := trb->A1_base
		TMP->INAT      := TRB->A1_INAT                           
		
		tmp->CODIGO   := TRB->A1_COD
		tmp->NOME     := TRB->A1_nome
		tmp->NOMEfanta:= TRB->A1_nreduz
		tmp->ENDERECO := TRB->a1_end
		tmp->BAIRRO   := TRB->A1_bairro
		tmp->CEP      := TRB->a1_cep
		tmp->CIDADE   := TRB->a1_mun
		tmp->ESTADO   := TRB->a1_est
		tmp->TIPOEND  := "ENTIDADE"
		tmp->CNPJ      := TRB->a1_cgc
		tmp->DDD       := TRB->A1_DDD
		tmp->FONE      := TRB->a1_tel 
		tmp->FONE2     := TRB->a1_tel2
		tmp->FONE3     := TRB->a1_tel3
		tmp->EMAIL     := TRB->a1_email
		tmp->EMAIL2    := TRB->a1_email2
		tmp->EMAIL3    := TRB->a1_email3
		tmp->CONTATO   := TRB->a1_Scontat
		tmp->BASE      := TRB->a1_base
		tmp->SINDMED   := TRB->a1_base2
		tmp->ERSIN     := TRB->a1_ersin
		tmp->SOCIO     := TRB->a1_tpcli
		tmp->CATEGORIA := TRB->a1_categ1
		tmp->DATAINICIO:= STOD(TRB->a1_dtinass)
		tmp->DATAFIM   := STOD(TRB->A1_dtfimas)
		tmp->situacao  := trb->A1_SITUAC
		tmp->CODASSO   := TRB->A1_CODASSO
		tmp->FAX       := TRB->A1_FAX
		tmp->CARTAO    := trb->a1_CARTAO
		tmp->LEITOS    := trb->a1_LEITOS
		tmp->NUM_FUNC  := trb->a1_NUMFUN
		tmp->FILANT    := TRB->A1_FILANT
		tmp->ESCCONT   := TRB->A1_ESCCONT
		tmp->DTCADASTRO:= STOD(TRB->A1_DTCADAS)
		tmp->VALASSO   := TRB->A1_VALASSO
		tmp->SINDICA   := TRB->A1_SINDICA
		tmp->CATLEIT   := TRB->A1_CATLEIT
		tmp->FISICO    := TRB->A1_FISICO
		tmp->HISTASS   := TRB->A1_HISTASS
		tmp->SCONTAT   := TRB->A1_SCONTAT
		tmp->EMAIL4    := TRB->A1_EMAIL4   
		tmp->NOMPRES   := TRB->A1_NOMPRES
		tmp->EMAIL5    := TRB->A1_EMAIL5
		tmp->ADMPROV   := TRB->A1_ADMPROV
		tmp->EMAIL6    := TRB->A1_EMAIL6
		tmp->SUPERIN   := TRB->A1_SUPERIN
		tmp->EMAIL7    := TRB->A1_EMAIL7
		tmp->DIRCLIN   := TRB->A1_DIRCLIN
		tmp->EMAIL8    := TRB->A1_EMAIL8
		tmp->DIRFIN    := TRB->A1_DIRFIN
		tmp->EMAIL9    := TRB->A1_EMAIL9
		tmp->DIRRH     := TRB->A1_DIRRH
		tmp->EMAIL0    := TRB->A1_EMAIL0
		tmp->DIRADM    := TRB->A1_DIRADM
		tmp->EMAIL10   := TRB->A1_EMAIL10
		tmp->CADATIV   := STOD(TRB->A1_CADATIV		)
		//
		tmp->CODDESCINAT	:=	TRB->A1_CODDESC
		tmp->DESCRINAT	:=	Posicione("SX5",1,xFilial("SX5")+"Z4"+TRB->A1_CODDESC,"X5DESCRI()" )					
		tmp->TPCADAS				:=	TRB->A1_TPCADAS       
		//
		tmp->ADVOGA	:=	TRB->A1_ADVOGA
		tmp->EMAIL11	:=	TRB->A1_EMAIL11
		tmp->INAT		:=	TRB->A1_INAT
		tmp->DATINAT	:=STOD( TRB->A1_DATINAT )
		tmp->CAPITAL1	:=	TRB->A1_CAPITAL

		
		msunlock()
		ersintotal ++
		ersinvalor += trb->a1_valasso
		sindtotal++
		sindvalor+= trb->a1_valasso
		IF MV_PAR13 == 1
			@ li,000 psay trb->a1_SINDICA
			if mv_par23 == 1
			@ li,007 psay subs(trb->a1_nome,1,50)         
			else
						@ li,007 psay subs(trb->a1_nome,1,50)
			endif
			@ li,059 psay trb->a1_cgc picture "@r 99.999.999/9999-99"
			@ li,079 psay trb->a1_codasso
			@ li,087 psay trb->a1_ddd+" "+trb->a1_tel
			@ li,108 psay trb->a1_naturez
			@ li,120 psay tmp->SOC_as
			@ li,124 psay tmp->soc_ss
			@ li,128 psay tmp->soc_is
	//@ li,132 psay tmp->soc_ct
			@ li,132 psay tmp->soc_fil
			@ li,137 psay subs(trb->a1_mun,1,25)
			@ li,168 psay stod(trb->a1_dtinass)
			@ li,181 psay stod(trb->a1_dtfimas)
			@ li,192 psay trb->a1_categ1
			@ LI,203 PSAY TRB->a1_INAT

			li++
		endif
		dbselectarea("trb")
		dbskip()

/*	enddo
	if Li >= 52
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	li++
	@ LI,000 PSAY "Total do ERSIN: "+ersinant+" - "+sx5->x5_descri
	li+= 2
	@ LI,000 PSAY "Socios Ativos: "
	@ li,050 psay ersinas picture "@e 9,999,999"
	li++
	@ LI,000 PSAY "Socios Suspensos: "
	@ li,050 psay ersinss picture "@e 9,999,999"
	li++
	@ LI,000 PSAY "Socios Inativos: "
	@ li,050 psay ersinis picture "@e 9,999,999"
	li++
	@ LI,000 PSAY "Socios Contratos: "
	@ li,050 psay ersinct picture "@e 9,999,999"
	li++
	@ LI,000 PSAY "Socios Filantropicos: "
	@ li,050 psay ersinfilant picture "@e 9,999,999"
	li++
	@ li,050 psay "---------"
	li++
	@ LI,000 PSAY "Total de Sócios: "
	@ li,050 psay ersintotal picture "@e 9,999,999"
	li++
	@ LI,000 PSAY "Valor Total: "
	@ li,047 psay ersinvalor picture "@e 9,999,999.99"
	totAS += ersinas
	totSS += ersinss
	totCT += ersinct
	totfiLANT += ersinfilant
	totTOTAL  += ersintotal
	totIS += ersinis
	totvalor  += ersinvalor
	li+= 2                 */
	ENDDO
	if Li >= 52
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	li++
	@ LI,000 PSAY "Total do Sindicato: "+sindant+" "+NOMESIND
	li+= 2
	@ LI,000 PSAY "Socios Ativos: "
	@ li,050 psay sindas picture "@e 9,999,999"
	li++
	@ LI,000 PSAY "Socios Suspensos: "
	@ li,050 psay sindss picture "@e 9,999,999"
	li++
	@ LI,000 PSAY "Socios Inativos: "
	@ li,050 psay sindis picture "@e 9,999,999"
	li++
	@ LI,000 PSAY "Nao Socios: "
	@ li,050 psay sindNS picture "@e 9,999,999"
	li++
	@ li,050 psay "---------"
	li++
	@ LI,000 PSAY "Total Geral:     "
	@ li,050 psay sindtotal picture "@e 9,999,999"
	li++
	totAS += SINDas
	totSS += SINDss
	totCT += SINDct
	totfiLANT += SINDfilant
	totTOTAL  += SINDTOtal
	totIS += SINDis
	totvalor  += SINDvalor
	TOTNS += sindns

enddo
if Li >= 52
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
endif
li++
@ LI,000 PSAY "Total Geral:"
li+= 2
@ LI,000 PSAY "Socios Ativos: "
@ li,050 psay totas picture "@e 9,999,999"
li++
@ LI,000 PSAY "Socios Suspensos: "
@ li,050 psay totss picture "@e 9,999,999"
li++
@ LI,000 PSAY "Socios Inativos: "
@ li,050 psay totis picture "@e 9,999,999"
li++
@ LI,000 PSAY "Nao Socios: "
@ li,050 psay TOTNS picture "@e 9,999,999"
li++
@ li,050 psay "---------"
li++
@ LI,000 PSAY "Total Geral: "
@ li,050 psay tottotal picture "@e 9,999,999"
li++



// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
// 0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
// ERSIN  Nome                                                CNPJ                Codigo  Telefone             Natureza    AS  SS  IS  CT  FIL  Cidade                            Valor  Categoria  Base Inic.Assoc.  Fim Assoc.
// XX     XXXXXXXXXXCCCCCCCCCCDDDDDDDDDDFFFFFFFFFFGGGGGGGGGG  99.999.999/9999-99  999999  gggggggggggggggggggg 9999999999  XX  XX  XX  XX  XX   XXXXXXXXXXDDDDDDDDDDFFFFF  9,999,999.99  99999      9999
if LI <> 80
	roda(cbcont,cbtxt,tamanho)
endif

DBSELECTAREA("Tmp")
CARQ := "\arquivos\"+ALLTRIM(SUBS(CUSUARIO,7,15))
COPY TO &CARQ
DBCLOSEAREA("Tmp")
DBSELECTAREA("trb")
DBCLOSEAREA("trb")
set device to screen
if aReturn[5] == 1
	set printer to
	dbcommit()
	ourspool(wnrel)
endif
MS_FLUSH()
dbselectarea(_cAlias)
return