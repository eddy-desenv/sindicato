#INCLUDE "PROTHEUS.CH"
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SHPERFIL �Autor  �GISELE NUNCHERINO   �  Data �  25/05/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � CHAMA A PAGINA DE PERFIS						              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SINDHOSP                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Web Function SHPERFIL()

Local cHtml := ""

Web Extended Init cHtml 
    
  
	HTTPSESSION->AEMPRESA 	:= NIL
	HTTPSESSION->CGC 		:= NIL
	HTTPPOST->CGC 			:= NIL
	HTTPSESSION->ROTINA		:= NIL
	HTTPSESSION->PERFIL		:= NIL
	HTTPSESSION->ESCRITO	:= NIL
 		
	cHtml := ExecInPage("SHPERFIL")
                                      
Web Extended End


Return cHtml  
      

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  SHCONTRIB �Autor  �GISELE NUNCHERINO   �  Data �  25/05/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � CHAMA A PAGINA DE CONTRIBUINTES/ASSOCIADOS                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SINDHOSP                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Web Function SHCONTRIB()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPSESSION->PERFIL := 'A'
	cHtml := ExecInPage("MENU")
	cHtml := ExecInPage("INDEXCONTR")
                                      
Web Extended End


Return cHtml

     
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  SHFUNC    �Autor  �GISELE NUNCHERINO   �  Data �  28/05/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � CHAMA A PAGINA DE FUNCIONARIOS			                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SINDHOSP                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Web Function SHFUNC()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPSESSION->PERFIL := 'F'
	cHtml := ExecInPage("ATENDE")
                                      
Web Extended End


Return cHtml

/*********************************************************************
* UserIsOn - GISELE NUNCHERINO - 28.05.2010
* Fun��o que retorna para a tela de login caso o 
* usu�rio n�o esteja logado
**********************************************************************/
Web Function UserIsOn()
	Local cHtml := ""

	If Empty(HTTPSESSION->PERFIL)
		    
		HTTPSESSION->AEMPRESA 	:= NIL
		HTTPSESSION->CGC 		:= NIL
		HTTPPOST->CGC 			:= NIL
		HTTPSESSION->ROTINA		:= NIL
		HTTPSESSION->PERFIL		:= NIL
		HTTPSESSION->ESCRITO	:= NIL		

		cHtml += "<script>top.location = 'W_SHPERFIL.APW';</script>"
		cHtml += "</html>"

	EndIf                 
	
Return cHtml