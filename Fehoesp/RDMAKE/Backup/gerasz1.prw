#INCLUDE "RWMAKE.CH"
USER FUNCTION GERASZ1()
DBSELECTAREA("SET")
DBGOTOP()
DO WHILE !EOF()
	DBSELECTAREA("SZ1")
	RECLOCK("SZ1",.T.)
	SZ1->Z1_FILIAL  := set->et_filial
	SZ1->Z1_NUM     := set->et_num
	SZ1->Z1_PREFIXO	:= set->et_prefixo
	SZ1->Z1_NATUREZ := set->et_naturez
	SZ1->Z1_CLIENTE := set->et_cliente
	SZ1->Z1_EMISSAO := set->et_emissao
	SZ1->Z1_NOMCLI  := set->et_nomcli
	SZ1->Z1_VALOR   := set->et_valor
	SZ1->Z1_NUMPARC := set->et_numparc
	SZ1->Z1_BAIXA   := set->et_baixa
	SZ1->Z1_HIST    := set->et_hist
	SZ1->Z1_CGC     := set->et_cgc
	SZ1->Z1_CODASSO := set->et_codasso
	SZ1->Z1_CATEG   := set->et_categ
	SZ1->Z1_ERSIN   := set->et_ersin
	SZ1->Z1_GERAPC  := set->et_gerapc
	SZ1->Z1_GERABX  := set->et_gerabx
	SZ1->Z1_PCINIA  := set->et_pcinia
	SZ1->Z1_PCFINA  := set->et_pcfina
	SZ1->Z1_PCVLRA  := set->et_pcvlra
	SZ1->Z1_PCINIC  := set->et_pcinic
	SZ1->Z1_PCFINC  := set->et_pcfinc
	SZ1->Z1_PCVLRC  := set->et_pcvlrc
	SZ1->Z1_LOJA	:= set->et_loja
	SZ1->Z1_VENCTO  := set->et_vencto
	SZ1->Z1_BASE    := set->et_base
	msunlock()
	dbselectarea("set")
	dbskiP()
enddo