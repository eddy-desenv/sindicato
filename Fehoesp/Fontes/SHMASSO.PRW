#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  SHMASSO     � Autor � GISELE NUNCHERINO � Data �  18/05/10   ���
�������������������������������������������������������������������������͹��
���Descricao � CADASTRO/MANUTENCAO DA BASE DE CALCULO P/ ASSOCIATIVA      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SINDHOSP                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function SHMASSO

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "PAG"

dbSelectArea("PAG")
dbSetOrder(1)

AxCadastro(cString,"Base de C�lculo - Associativa/Associativa Confederativa",cVldExc,"U_ASSOTDOK()")

Return


USER FUNCTION ASSOTDOK()
LOCAL LVALID 	:= .T.
LOCAL CMSG		:= ''

/** VERIFICA SE JA EXISTE REGISTRO COM OS MESMOS DADOS **/
//ZG_FILIAL+ZG_VENCTIT+ZG_VENCCON+ZG_CODIGO
PAG->(DBORDERNICKNAME("VENCTITULO"))
IF (PAG->( dbSeek( XFILIAL("PAG") + DTOS(M->PAG_VCTIT) + DTOS(M->PAG_VENCON))))
	IF PAG->PAG_CODIGO <> M->PAG_CODIGO
		CMSG 	:= 'Vencimentos J� Definidos'
		LVALID 	:= .F.
	ENDIF
ENDIF
                
IIF (!LVALID,ALERT(CMSG),)

RETURN LVALID