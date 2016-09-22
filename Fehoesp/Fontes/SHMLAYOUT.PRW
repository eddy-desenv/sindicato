#INCLUDE "PROTHEUS.CH"

USER FUNCTION SHMLAYOUT()

dbSelectArea("PA7")
dbSetOrder(1)

AxCadastro("PA7","SindicatoXLayoutXBanco",,"U_ValidOK()")

Return


USER FUNCTION ValidOK()
LOCAL LVALID 	:= .T.
LOCAL CMSG		:= ''

/** VERIFICA SE JA EXISTE REGISTRO COM OS MESMOS DADOS **/
//PA7_FILIAL+PA7_CODSIN+PA7_NATURE
PA7->(dbsetorder(1))
IF (PA7->( dbSeek( XFILIAL("PA7") + (M->PA7_CODSIN) + (M->PA7_NATURE))))
	IF PA7->PA7_CODIGO <> M->PA7_CODIGO
		CMSG 	:= 'Sindicatos Já Definidos'
		LVALID 	:= .F.
	ENDIF
ENDIF
                
IIF (!LVALID,ALERT(CMSG),)

RETURN LVALID