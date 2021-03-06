USER FUNCTION TESTA_IE()

pRIVATE nHdLog

nHdLog := CreateLog( "TESTE_IE.log" )

Processa({||testa_a1()}, "Testando e Corrigindo IE", "Aguarde...")

Fclose( nHdLog )
ConOut( "FIM" )

STATIC FUNCTION TESTA_A1()

ProcRegua(SA1->(Reccount()))

SA1->( DbGoTop() )                            	
DO WHILE ! SA1->( EOF() )

	iNCpROC()
	IF ! IE(SA1->A1_INSCR,SA1->A1_EST,.F.) 
		cMsg := SA1->( A1_COD + ' - ' + A1_INSCR + " - " + A1_EST + " " + A1_INAT )
		GravaLog( nHdLog, "W", cMsg )
      ConOut( cMsg )

		RECLOCK("SA1",.F.)
		A1_INSCR := " "
		MSUNLOCK()
		
  ENDIF
  
  SA1->( DBSKIP() )
  
ENDDO  

GravaLog( nHdLog, "GW" )

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GravaLog � Autor � Felipe Raposo      � Data �  20/12/07   ���
�������������������������������������������������������������������������͹��
���Descricao � Grava no arquivo de log e exibe a mensagem no console.     ���
���          �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static function GravaLog(nHandle, cTipo, cMsg)

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis.                                            �
//�����������������������������������������������������������������������
Static aWarns[0]

If cTipo == "W"  // Armazena warnings.
	aAdd(aWarns, cMsg)
ElseIf cTipo == "GW"  // Grava warnings.
	aEval(aWarns, {|cMsg| 	FWrite(nHandle, cMsg + CHR(13)+CHR(10 ) ) })
	aWarns := {}
Endif

Return .T.

Static function CreateLog(cArquivo)

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis.                                            �
//�����������������������������������������������������������������������
Local nHandle

If (nHandle := FCreate(cArquivo)) < 1
	MsgInfo("N�o foi poss�vel criar o arquivo de log.", cArquivo)
Endif

Return nHandle
   

   
   
   
   
   
   