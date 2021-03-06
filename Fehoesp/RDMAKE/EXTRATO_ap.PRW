#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 23/12/12
#INCLUDE "PROTHEUS.CH"
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"

User Function EXTRATO()        // incluido pelo assistente de conversao do AP6 IDE em 23/12/12

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP6 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
        
SetPrvt("CHTML,LERRO,NX,WSEXT,WSEMP,SINDPGO")
SetPrvt("CONFPGO,ASSOPGO,SINDABT,CONFABT,ASSOABT,CANO_SIND")
SetPrvt("CCCGC,CCCODIGO,CCFILANTR,CCFILIAL,CCFOLCENT,CCLOJA")
SetPrvt("DDINIATV,DDDTNASC,NNCATEGOR,CCNATUREZ,LLSIND,LLCONFNEG")
SetPrvt("LLASSOC,CCCONFNEG,OWSAEMPRESA,")


// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 23/12/12 ==> #INCLUDE "PROTHEUS.CH"
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 23/12/12 ==> #INCLUDE "WEBEXDEF.CH"   
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 23/12/12 ==> #INCLUDE "APWEBEX.CH"
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 23/12/12 ==> #INCLUDE "AP5MAIL.CH"



/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿐XTRATO   튍utor  쿒ISELE NUNCHERINO   � Data �  04/23/10   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     � CHAMA A PAGINA DE EXTRATOS					              볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � SINDHOSP                                                   볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/


Return(nil)        // incluido pelo assistente de conversao do AP6 IDE em 23/12/12

// Substituido pelo assistente de conversao do AP6 IDE em 23/12/12 ==> USER Function EXTRATO1()
Static USER Function EXTRATO1()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPPOST->MSGATUA := NIL
	cHtml := ExecInPage("SINDEXTR")
                                      
Web Extended End


Return cHtml  

  
/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿒ERAEXTR   튍utor  쿒ISELE NUNCHERINO   � Data �  04/23/10  볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     � GERA OS EXTRATOS E CHAMA A PAGINA DE EXIBICAO DE EXTRATOS  볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � SINDHOSP                                                   볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

// Substituido pelo assistente de conversao do AP6 IDE em 23/12/12 ==> USER Function GERAEXTR()
Static USER Function GERAEXTR()

Local cMensagem

Local lErro := .F.

Local cHtml 			:= ''
LOCAL NX				:= 0
LOCAL WSEXT 			:= WSSHEXTRATO():NEW()
LOCAL WSEMP				:= WSSINDHOSP():NEW()   
LOCAL SINDPGO			:= {}
LOCAL CONFPGO			:= {}
LOCAL ASSOPGO			:= {}
LOCAL SINDABT			:= {}
LOCAL CONFABT			:= {}
LOCAL ASSOABT			:= {} 

Local cANO_SIND			:= Right(Alltrim(Str(Year(Date())-4)),2)
              

HttpSession->XRaizURL  := HttpPost->VerURL 


Web Extended Init cHtml //Start "w_UserIsOn"

IF U_LIMPACGC(HTTPPOST->CGC) == NIL
	HTTPPOST->ERRO := "CNPJ em branco/invalido"
	cHtml := ExecInPage("ERRO")	        
ELSE
 
WSEMP:CCCGC := U_LIMPACGC(HTTPPOST->CGC)

HTTPSESSION->CGC := HTTPPOST->CGC

HTTPPOST->SINDABT := {}
HTTPPOST->CONFABT := {}
HTTPPOST->ASSOABT := {}
HTTPPOST->SINDPGO := {}
HTTPPOST->CONFPGO := {}
HTTPPOST->ASSOPGO := {}

Do  While .T.

	If  !( WSEMP:VERCADEMP() )   //ACHOU A EMPRESA
		HTTPPOST->ERRO := GetWSCError()
		cHtml := ExecInPage("ERRO")
		CONOUT(GetWSCError())
		Exit
	EndIf
		
	If  Empty(WSEMP:oWSVERCADEMPRESULT:cCCODIGO) 
		HTTPPOST->MSGATUA := "CNPJ N�o Encontrado! Deseja Se Cadastrar?"
		cHtml := ExecInPage("SINDEXTR")
		Exit
	EndIf
		
	HTTPSESSION->AEMPRESA := WSEMP:oWSVERCADEMPRESULT:Clone() 
	
  	If  !( (HTTPSESSION->AEMPRESA:DDDTNASC == DATE() .And. Alltrim(HTTPSESSION->AEMPRESA:CCINAT) == "X") .Or.;
  	       (Alltrim(HTTPSESSION->AEMPRESA:CCINAT) != "X") )
		HTTPPOST->ERRO := "Cliente inativo - Favor entrar em contato com o departamento de Cadastro, atrav�s do telefone (11) 3331-1555 na op豫o 7 ou <BR> e-mail: cadastro@sindhosp.com.br"
		cHtml := ExecInPage("ERRO")
		Exit
	EndIf

    WSEXT:oWSAEMPRESA:cCCGC 	:= HTTPPOST->CGC
    WSEXT:oWSAEMPRESA:cCCODIGO 	:= WSEMP:oWSVERCADEMPRESULT:cCCODIGO
    WSEXT:oWSAEMPRESA:cCFILANTR := WSEMP:oWSVERCADEMPRESULT:cCFILANTR
    WSEXT:oWSAEMPRESA:cCFILIAL 	:= WSEMP:oWSVERCADEMPRESULT:cCFILIAL
    WSEXT:oWSAEMPRESA:cCFOLCENT := WSEMP:oWSVERCADEMPRESULT:cCFOLCENT
    WSEXT:oWSAEMPRESA:cCLOJA 	:= WSEMP:oWSVERCADEMPRESULT:cCLOJA
    WSEXT:oWSAEMPRESA:dDINIATV 	:= WSEMP:oWSVERCADEMPRESULT:dDINIATV
    WSEXT:oWSAEMPRESA:dDDTNASC 	:= WSEMP:oWSVERCADEMPRESULT:dDDTNASC
    WSEXT:oWSAEMPRESA:nNCATEGOR := VAL(WSEMP:oWSVERCADEMPRESULT:CNCATEGOR)
    WSEXT:oWSAEMPRESA:CCNATUREZ := WSEMP:oWSVERCADEMPRESULT:CCNATUREZ
    
    WSEXT:lLSIND 		:= IIF(HTTPPOST->CHKSIND <> NIL,.T.,.F.)
    WSEXT:lLCONFNEG 	:= IIF(HTTPPOST->CHKCONFASSIST <> NIL,.T.,.F.)
    WSEXT:lLASSOC 		:= IIF(HTTPPOST->CHKASSOC <> NIL,.T.,.F.) 
    
    HTTPSESSION->SIND 		:= IIF(HTTPPOST->CHKSIND <> NIL,1,2)
    HTTPSESSION->CONFNEG 	:= IIF(HTTPPOST->CHKCONFASSIST <> NIL,1,2)
    HTTPSESSION->ASSOC 		:= IIF(HTTPPOST->CHKASSOC <> NIL,1,2)
    
    /****************************************************************************/
    /*							T I T U L O S   P A G O S 						*/
    /****************************************************************************/

    Do  While .T.
    
	    If  !( WSEXT:LSTPAG() )
			cHtml := ExecInPage("SINDEXTR")	        
	        CONOUT(GetWSCError())
	        lErro := .T.
	        Exit
	    EndIf   
	    
        /*
            WSEXT:oWSLSTABTRESULT:oWSSTITPAG:xxxx
		*/  
		IF LEN(WSEXT:OWSLSTPAGRESULT:oWSSTITPAG) > 0
			FOR NX := 1 TO LEN(WSEXT:oWSLSTPAGRESULT:OWSSTITPAG)
				IF  (WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '003') .And. (Left(WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCANO,2) >= cANO_SIND) //SINDICAL
					AADD(SINDPGO,WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx])
				ENDIF
				IF WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '002' .OR. WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '0301' //CONFEDERATIVA
					AADD(CONFPGO,WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx])					
				ENDIF
				IF WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '001' .OR. WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '1000' //ASSOCIATIVA
					AADD(ASSOPGO,WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx])					
				ENDIF
			NEXT NX   

			HTTPPOST->SINDPGO := Asort(SINDPGO,,,{|x,y| x:CCANO > y:CCANO})
			HTTPPOST->CONFPGO := Asort(CONFPGO,,,{|x,y| x:CCANO+x:CCPARCELA > y:CCANO+y:CCPARCELA})
			HTTPPOST->ASSOPGO := Asort(ASSOPGO,,,{|x,y| x:CCANO+x:CCMES > y:CCANO+y:CCMES})
                                  
			IF LEN(SINDPGO)<=0
				HTTPPOST->MSINDPGO	:= "N�o Existem T�tulos Pagos"				
			ELSE
			    HTTPPOST->MSINDPGO	:= ''	
			ENDIF

			IF LEN(CONFPGO)<=0
				HTTPPOST->MCONFPGO	:= "N�o Existem T�tulos Pagos"				
			ELSE
			    HTTPPOST->MCONFPGO	:= ''	
			ENDIF

			IF WSEMP:oWSVERCADEMPRESULT:CCSITUAC <> 'SS' .AND. WSEMP:oWSVERCADEMPRESULT:CCSITUAC <> "AS"
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa n�o � associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3331-1555 op豫o 7, Fax (11) 3331-3344 e Email: cadastro@sindhosp.com.br"
			ELSE
			
				IF LEN(ASSOPGO)<=0
					HTTPPOST->MASSOPGO	:= "N�o Existem T�tulos Pagos"				
				ELSE
				    HTTPPOST->MASSOPGO	:= ''	
				ENDIF
			ENDIF								
		ELSE
			HTTPPOST->MSINDPGO	:= "N�o Existem T�tulos Pagos"
			HTTPPOST->MCONFPGO	:= "N�o Existem T�tulos Pagos"   
			IF WSEMP:oWSVERCADEMPRESULT:CCSITUAC <> 'SS' .AND. WSEMP:oWSVERCADEMPRESULT:CCSITUAC <> "AS"
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa n�o � associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3331-1555 op豫o 7, Fax (11) 3331-3344 e Email: cadastro@sindhosp.com.br"
			ELSE				
				HTTPPOST->MASSOPGO	:= "N�o Existem T�tulos Pagos"
			ENDIF
		ENDIF
		
		Exit
	EndDo
					
        CONOUT('INICIO')
    /****************************************************************************/
    /*						T I T U L O S   E M   A B E R T O					*/
    /****************************************************************************/	
    //LSTABT WSRECEIVE AEMPRESA, LSIND, LCONFNEG, LASSOC, CCONFNEG

    WSEXT:CCCONFNEG := ''

	WSEXT:oWSAEMPRESA := HTTPSESSION->AEMPRESA:Clone()	    

	Do  While .T.
	
    	If  !( WSEXT:LSTABT() )
			cHtml := ExecInPage("SINDEXTR")	        
        	CONOUT(GetWSCError())
        	lErro := .T.
			Exit
		EndIf
			
		IF LEN(WSEXT:oWSLSTABTRESULT:OWSSTITABT) > 0           
		           
			FOR NX := 1 TO LEN(WSEXT:oWSLSTABTRESULT:oWSSTITABT)	
				IF  (WSEXT:oWSLSTABTRESULT:OWSSTITABT[NX]:CCNAT == '003') .And. (Left(WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCANO,2) >= cANO_SIND) //SINDICAL
					AADD(SINDABT,WSEXT:oWSLSTABTRESULT:OWSSTITABT[NX])
				ENDIF
				IF WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '002' .OR. WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '0301' //CONFEDERATIVA
					AADD(CONFABT,WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX])					
				ENDIF
				IF WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '001' .OR. WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '1000' //ASSOCIATIVA
					AADD(ASSOABT,WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX])					
				ENDIF
			NEXT NX

			HTTPPOST->SINDABT := Asort(SINDABT,,,{|x,y| x:CCANO > y:CCANO})
			HTTPPOST->CONFABT := Asort(CONFABT,,,{|x,y| x:CCANO+x:CCPARCELA > y:CCANO+y:CCPARCELA})
			HTTPPOST->ASSOABT := Asort(ASSOABT,,,{|x,y| x:CCANO+x:CCMES > y:CCANO+y:CCMES})
			IF  (LEN(SINDABT) <= 0)
			    If  (HTTPSESSION->AEMPRESA:cCCAPCENT == 'S')
					HTTPPOST->MSINDABT	:= "Capital Social centralizado!<br> Esta contribui豫o n�o � devida para este CNPJ!"			
				Else
					HTTPPOST->MSINDABT	:= "N�o Existem T�tulos em Aberto"
				EndIf	
			ELSE
			    HTTPPOST->MSINDABT	:= ''	
			ENDIF

			IF LEN(CONFABT)<=0
			    If  (HTTPSESSION->AEMPRESA:cCFOLCENT == 'S')
					HTTPPOST->MCONFABT	:= "Folha de Pagamento centralizada!<br> Esta contribui豫o n�o � devida para este CNPJ!"			
				Else
					HTTPPOST->MCONFABT	:= "N�o Existem T�tulos em Aberto"
				EndIf				
			ELSE
			    HTTPPOST->MCONFABT	:= ''	
			ENDIF

            IF WSEMP:oWSVERCADEMPRESULT:CCSITUAC <> 'SS' .AND. WSEMP:oWSVERCADEMPRESULT:CCSITUAC <> "AS"
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa n�o � associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3331-1555 op豫o 7, Fax (11) 3331-3344 e Email: cadastro@sindhosp.com.br"
			ELSE
			
				IF LEN(ASSOABT)<=0
					HTTPPOST->MASSOABT	:= "N�o Existem T�tulos em Aberto"
				ELSE
				    HTTPPOST->MASSOABT	:= ''	
				ENDIF				
					
	        ENDIF
		ELSE
			HTTPPOST->MSINDABT	:= "N�o Existem T�tulos em Aberto"
			HTTPPOST->MCONFABT	:= "N�o Existem T�tulos em Aberto"
//			HTTPPOST->ASSOABT	:= NIL
			IF WSEMP:oWSVERCADEMPRESULT:CCSITUAC <> 'SS' .AND. WSEMP:oWSVERCADEMPRESULT:CCSITUAC <> "AS"
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa n�o � associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3331-1555 op豫o 7, Fax (11) 3331-3344 e Email: cadastro@sindhosp.com.br"
			ELSE
				HTTPPOST->MASSOABT	:= "N�o Existem T�tulos em Aberto"
			ENDIF
		ENDIF
		
		Exit			
    EndDo
      
    If  !( lErro )
		cHtml := ExecInPage("SINDLISTEXT")
	EndIf	
	
	Exit
EndDo

ENDIF
                 
Web Extended End

Return cHtml 


/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿍OLSIND    튍utor  쿒ISELE NUNCHERINO   � Data �  16/06/10  볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     � CHAMA A PAGINA DE CALCULO DO BOLETO DA SINDICAL            볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � SINDHOSP                                                   볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

// Substituido pelo assistente de conversao do AP6 IDE em 23/12/12 ==> USER Function BOLSIND()
Static USER Function BOLSIND()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPPOST->TPBOLETO := '1'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml  

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿍OLCONF    튍utor  쿒ISELE NUNCHERINO   � Data �  16/06/10  볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     � CHAMA A PAGINA DE CALCULO DO BOLETO DA CONFEDERATIVA       볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � SINDHOSP                                                   볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

// Substituido pelo assistente de conversao do AP6 IDE em 23/12/12 ==> USER Function BOLCONF()
Static USER Function BOLCONF()

Local cHtml := ""

Web Extended Init cHtml   
	
	HTTPPOST->TPBOLETO := '2'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml  

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿍OLASSOC   튍utor  쿒ISELE NUNCHERINO   � Data �  16/06/10  볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     � CHAMA A PAGINA DE CALCULO DO BOLETO DA ASSOCIATIVA         볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � SINDHOSP                                                   볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

// Substituido pelo assistente de conversao do AP6 IDE em 23/12/12 ==> USER Function BOLASSOC()
Static USER Function BOLASSOC()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPPOST->TPBOLETO := '3'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml  

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿍OLASSCONF 튍utor  쿒ISELE NUNCHERINO   � Data �  16/06/10  볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     � CHAMA A PAGINA DE CALCULO DO BOLETO DA ASSOCIATIVA         볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � SINDHOSP                                                   볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

// Substituido pelo assistente de conversao do AP6 IDE em 23/12/12 ==> USER Function BOLASSCONF()
Static USER Function BOLASSCONF()

Local cHtml := ""

Web Extended Init cHtml 

	HTTPPOST->TPBOLETO := '4'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml 


/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿍OLNEG	 튍utor  쿒ISELE NUNCHERINO   � Data �  16/06/10  볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     � CHAMA A PAGINA DE CALCULO DO BOLETO DA ASSISTENCIAL/NEGOCIAL굇
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � SINDHOSP                                                   볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

// Substituido pelo assistente de conversao do AP6 IDE em 23/12/12 ==> USER Function BOLNEG()
Static USER Function BOLNEG()

Local cHtml := ""

Web Extended Init cHtml 
	HTTPPOST->TPBOLETO := '5'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml 
