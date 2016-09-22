#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://200.171.40.85:8502/ws/SINDHOSP.apw?WSDL
Gerado em        01/21/16 15:43:38
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _QYQZHWN ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSSINDHOSP
------------------------------------------------------------------------------- */

WSCLIENT WSSINDHOSP

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD AUTENTICAR
	WSMETHOD BUSCACEP
	WSMETHOD BUSCAESC
	WSMETHOD CADEMPRESA
	WSMETHOD CADESCRIT
	WSMETHOD VERCADEMP
	WSMETHOD VERCADESC
	WSMETHOD VEREMPAUX
	WSMETHOD VEREMPESC
	WSMETHOD VERESCAUX
	WSMETHOD VINCESCR

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   cCUSERCODE                AS string
	WSDATA   cCPASSWORD                AS string
	WSDATA   oWSAUTENTICARRESULT       AS SINDHOSP_USERDADOS
	WSDATA   cCEP                      AS string
	WSDATA   oWSBUSCACEPRESULT         AS SINDHOSP_SEND
	WSDATA   cCODESCR                  AS string
	WSDATA   oWSBUSCAESCRESULT         AS SINDHOSP_SESCRITO
	WSDATA   oWSAEMPRESA               AS SINDHOSP_STREMPRESA
	WSDATA   cCROTINA                  AS string
	WSDATA   lCADEMPRESARESULT         AS boolean
	WSDATA   oWSAESCRITO               AS SINDHOSP_SESCRITO
	WSDATA   lCADESCRITRESULT          AS boolean
	WSDATA   cCCGC                     AS string
	WSDATA   oWSVERCADEMPRESULT        AS SINDHOSP_STREMPRESA
	WSDATA   oWSVERCADESCRESULT        AS SINDHOSP_SESCRITO
	WSDATA   oWSVEREMPAUXRESULT        AS SINDHOSP_STREMPRESA
	WSDATA   oWSVEREMPESCRESULT        AS SINDHOSP_SESCRITO
	WSDATA   oWSVERESCAUXRESULT        AS SINDHOSP_SESCRITO
	WSDATA   cCODEMP                   AS string
	WSDATA   lVINCESCRRESULT           AS boolean

	// Estruturas mantidas por compatibilidade - NÃO USAR
	WSDATA   oWSSTREMPRESA             AS SINDHOSP_STREMPRESA
	WSDATA   oWSSESCRITO               AS SINDHOSP_SESCRITO

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSSINDHOSP
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20141125] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSSINDHOSP
	::oWSAUTENTICARRESULT := SINDHOSP_USERDADOS():New()
	::oWSBUSCACEPRESULT  := SINDHOSP_SEND():New()
	::oWSBUSCAESCRESULT  := SINDHOSP_SESCRITO():New()
	::oWSAEMPRESA        := SINDHOSP_STREMPRESA():New()
	::oWSAESCRITO        := SINDHOSP_SESCRITO():New()
	::oWSVERCADEMPRESULT := SINDHOSP_STREMPRESA():New()
	::oWSVERCADESCRESULT := SINDHOSP_SESCRITO():New()
	::oWSVEREMPAUXRESULT := SINDHOSP_STREMPRESA():New()
	::oWSVEREMPESCRESULT := SINDHOSP_SESCRITO():New()
	::oWSVERESCAUXRESULT := SINDHOSP_SESCRITO():New()

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSSTREMPRESA      := ::oWSAEMPRESA
	::oWSSESCRITO        := ::oWSAESCRITO
Return

WSMETHOD RESET WSCLIENT WSSINDHOSP
	::cCUSERCODE         := NIL 
	::cCPASSWORD         := NIL 
	::oWSAUTENTICARRESULT := NIL 
	::cCEP               := NIL 
	::oWSBUSCACEPRESULT  := NIL 
	::cCODESCR           := NIL 
	::oWSBUSCAESCRESULT  := NIL 
	::oWSAEMPRESA        := NIL 
	::cCROTINA           := NIL 
	::lCADEMPRESARESULT  := NIL 
	::oWSAESCRITO        := NIL 
	::lCADESCRITRESULT   := NIL 
	::cCCGC              := NIL 
	::oWSVERCADEMPRESULT := NIL 
	::oWSVERCADESCRESULT := NIL 
	::oWSVEREMPAUXRESULT := NIL 
	::oWSVEREMPESCRESULT := NIL 
	::oWSVERESCAUXRESULT := NIL 
	::cCODEMP            := NIL 
	::lVINCESCRRESULT    := NIL 

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSSTREMPRESA      := NIL
	::oWSSESCRITO        := NIL
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSSINDHOSP
Local oClone := WSSINDHOSP():New()
	oClone:_URL          := ::_URL 
	oClone:cCUSERCODE    := ::cCUSERCODE
	oClone:cCPASSWORD    := ::cCPASSWORD
	oClone:oWSAUTENTICARRESULT :=  IIF(::oWSAUTENTICARRESULT = NIL , NIL ,::oWSAUTENTICARRESULT:Clone() )
	oClone:cCEP          := ::cCEP
	oClone:oWSBUSCACEPRESULT :=  IIF(::oWSBUSCACEPRESULT = NIL , NIL ,::oWSBUSCACEPRESULT:Clone() )
	oClone:cCODESCR      := ::cCODESCR
	oClone:oWSBUSCAESCRESULT :=  IIF(::oWSBUSCAESCRESULT = NIL , NIL ,::oWSBUSCAESCRESULT:Clone() )
	oClone:oWSAEMPRESA   :=  IIF(::oWSAEMPRESA = NIL , NIL ,::oWSAEMPRESA:Clone() )
	oClone:cCROTINA      := ::cCROTINA
	oClone:lCADEMPRESARESULT := ::lCADEMPRESARESULT
	oClone:oWSAESCRITO   :=  IIF(::oWSAESCRITO = NIL , NIL ,::oWSAESCRITO:Clone() )
	oClone:lCADESCRITRESULT := ::lCADESCRITRESULT
	oClone:cCCGC         := ::cCCGC
	oClone:oWSVERCADEMPRESULT :=  IIF(::oWSVERCADEMPRESULT = NIL , NIL ,::oWSVERCADEMPRESULT:Clone() )
	oClone:oWSVERCADESCRESULT :=  IIF(::oWSVERCADESCRESULT = NIL , NIL ,::oWSVERCADESCRESULT:Clone() )
	oClone:oWSVEREMPAUXRESULT :=  IIF(::oWSVEREMPAUXRESULT = NIL , NIL ,::oWSVEREMPAUXRESULT:Clone() )
	oClone:oWSVEREMPESCRESULT :=  IIF(::oWSVEREMPESCRESULT = NIL , NIL ,::oWSVEREMPESCRESULT:Clone() )
	oClone:oWSVERESCAUXRESULT :=  IIF(::oWSVERESCAUXRESULT = NIL , NIL ,::oWSVERESCAUXRESULT:Clone() )
	oClone:cCODEMP       := ::cCODEMP
	oClone:lVINCESCRRESULT := ::lVINCESCRRESULT

	// Estruturas mantidas por compatibilidade - NÃO USAR
	oClone:oWSSTREMPRESA := oClone:oWSAEMPRESA
	oClone:oWSSESCRITO   := oClone:oWSAESCRITO
Return oClone

// WSDL Method AUTENTICAR of Service WSSINDHOSP

WSMETHOD AUTENTICAR WSSEND cCUSERCODE,cCPASSWORD WSRECEIVE oWSAUTENTICARRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<AUTENTICAR xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CUSERCODE", ::cCUSERCODE, cCUSERCODE , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CPASSWORD", ::cCPASSWORD, cCPASSWORD , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</AUTENTICAR>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/AUTENTICAR",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::oWSAUTENTICARRESULT:SoapRecv( WSAdvValue( oXmlRet,"_AUTENTICARRESPONSE:_AUTENTICARRESULT","USERDADOS",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BUSCACEP of Service WSSINDHOSP

WSMETHOD BUSCACEP WSSEND cCEP WSRECEIVE oWSBUSCACEPRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BUSCACEP xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CEP", ::cCEP, cCEP , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCACEP>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/BUSCACEP",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::oWSBUSCACEPRESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCACEPRESPONSE:_BUSCACEPRESULT","SEND",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BUSCAESC of Service WSSINDHOSP

WSMETHOD BUSCAESC WSSEND cCODESCR WSRECEIVE oWSBUSCAESCRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BUSCAESC xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CODESCR", ::cCODESCR, cCODESCR , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCAESC>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/BUSCAESC",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::oWSBUSCAESCRESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCAESCRESPONSE:_BUSCAESCRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CADEMPRESA of Service WSSINDHOSP

WSMETHOD CADEMPRESA WSSEND oWSAEMPRESA,cCROTINA WSRECEIVE lCADEMPRESARESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CADEMPRESA xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("AEMPRESA", ::oWSAEMPRESA, oWSAEMPRESA , "STREMPRESA", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CROTINA", ::cCROTINA, cCROTINA , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</CADEMPRESA>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/CADEMPRESA",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::lCADEMPRESARESULT  :=  WSAdvValue( oXmlRet,"_CADEMPRESARESPONSE:_CADEMPRESARESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CADESCRIT of Service WSSINDHOSP

WSMETHOD CADESCRIT WSSEND oWSAESCRITO,cCROTINA WSRECEIVE lCADESCRITRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CADESCRIT xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("AESCRITO", ::oWSAESCRITO, oWSAESCRITO , "SESCRITO", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CROTINA", ::cCROTINA, cCROTINA , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</CADESCRIT>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/CADESCRIT",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::lCADESCRITRESULT   :=  WSAdvValue( oXmlRet,"_CADESCRITRESPONSE:_CADESCRITRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VERCADEMP of Service WSSINDHOSP

WSMETHOD VERCADEMP WSSEND cCCGC WSRECEIVE oWSVERCADEMPRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VERCADEMP xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VERCADEMP>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VERCADEMP",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::oWSVERCADEMPRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VERCADEMPRESPONSE:_VERCADEMPRESULT","STREMPRESA",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VERCADESC of Service WSSINDHOSP

WSMETHOD VERCADESC WSSEND cCCGC WSRECEIVE oWSVERCADESCRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VERCADESC xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VERCADESC>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VERCADESC",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::oWSVERCADESCRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VERCADESCRESPONSE:_VERCADESCRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VEREMPAUX of Service WSSINDHOSP

WSMETHOD VEREMPAUX WSSEND cCCGC WSRECEIVE oWSVEREMPAUXRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VEREMPAUX xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VEREMPAUX>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VEREMPAUX",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::oWSVEREMPAUXRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VEREMPAUXRESPONSE:_VEREMPAUXRESULT","STREMPRESA",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VEREMPESC of Service WSSINDHOSP

WSMETHOD VEREMPESC WSSEND cCODESCR WSRECEIVE oWSVEREMPESCRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VEREMPESC xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CODESCR", ::cCODESCR, cCODESCR , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VEREMPESC>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VEREMPESC",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::oWSVEREMPESCRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VEREMPESCRESPONSE:_VEREMPESCRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VERESCAUX of Service WSSINDHOSP

WSMETHOD VERESCAUX WSSEND cCCGC WSRECEIVE oWSVERESCAUXRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VERESCAUX xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VERESCAUX>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VERESCAUX",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::oWSVERESCAUXRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VERESCAUXRESPONSE:_VERESCAUXRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VINCESCR of Service WSSINDHOSP

WSMETHOD VINCESCR WSSEND cCODESCR,cCODEMP WSRECEIVE lVINCESCRRESULT WSCLIENT WSSINDHOSP
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VINCESCR xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CODESCR", ::cCODESCR, cCODESCR , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CODEMP", ::cCODEMP, cCODEMP , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VINCESCR>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VINCESCR",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://200.171.40.85:8502/ws/SINDHOSP.apw")

::Init()
::lVINCESCRRESULT    :=  WSAdvValue( oXmlRet,"_VINCESCRRESPONSE:_VINCESCRRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure USERDADOS

WSSTRUCT SINDHOSP_USERDADOS
	WSDATA   cCCODIGO                  AS string
	WSDATA   cCEMAIL                   AS string
	WSDATA   cCFORNEC                  AS string
	WSDATA   cCLOJA                    AS string
	WSDATA   cCNOME                    AS string
	WSDATA   cCPERFIL                  AS string
	WSDATA   cCUSER                    AS string
	WSDATA   lLADM                     AS boolean
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SINDHOSP_USERDADOS
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SINDHOSP_USERDADOS
Return

WSMETHOD CLONE WSCLIENT SINDHOSP_USERDADOS
	Local oClone := SINDHOSP_USERDADOS():NEW()
	oClone:cCCODIGO             := ::cCCODIGO
	oClone:cCEMAIL              := ::cCEMAIL
	oClone:cCFORNEC             := ::cCFORNEC
	oClone:cCLOJA               := ::cCLOJA
	oClone:cCNOME               := ::cCNOME
	oClone:cCPERFIL             := ::cCPERFIL
	oClone:cCUSER               := ::cCUSER
	oClone:lLADM                := ::lLADM
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SINDHOSP_USERDADOS
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCCODIGO           :=  WSAdvValue( oResponse,"_CCODIGO","string",NIL,"Property cCCODIGO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCEMAIL            :=  WSAdvValue( oResponse,"_CEMAIL","string",NIL,"Property cCEMAIL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCFORNEC           :=  WSAdvValue( oResponse,"_CFORNEC","string",NIL,"Property cCFORNEC as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCLOJA             :=  WSAdvValue( oResponse,"_CLOJA","string",NIL,"Property cCLOJA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCNOME             :=  WSAdvValue( oResponse,"_CNOME","string",NIL,"Property cCNOME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCPERFIL           :=  WSAdvValue( oResponse,"_CPERFIL","string",NIL,"Property cCPERFIL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCUSER             :=  WSAdvValue( oResponse,"_CUSER","string",NIL,"Property cCUSER as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::lLADM              :=  WSAdvValue( oResponse,"_LADM","boolean",NIL,"Property lLADM as s:boolean on SOAP Response not found.",NIL,"L",NIL,NIL) 
Return

// WSDL Data Structure SEND

WSSTRUCT SINDHOSP_SEND
	WSDATA   cBAIRRO                   AS string
	WSDATA   cBASE                     AS string
	WSDATA   cBASE2                    AS string
	WSDATA   cCEP                      AS string
	WSDATA   cENDERECO                 AS string
	WSDATA   cERSIN                    AS string
	WSDATA   cEST                      AS string
	WSDATA   cMUN                      AS string
	WSDATA   cSINDICATO                AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SINDHOSP_SEND
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SINDHOSP_SEND
Return

WSMETHOD CLONE WSCLIENT SINDHOSP_SEND
	Local oClone := SINDHOSP_SEND():NEW()
	oClone:cBAIRRO              := ::cBAIRRO
	oClone:cBASE                := ::cBASE
	oClone:cBASE2               := ::cBASE2
	oClone:cCEP                 := ::cCEP
	oClone:cENDERECO            := ::cENDERECO
	oClone:cERSIN               := ::cERSIN
	oClone:cEST                 := ::cEST
	oClone:cMUN                 := ::cMUN
	oClone:cSINDICATO           := ::cSINDICATO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SINDHOSP_SEND
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cBAIRRO            :=  WSAdvValue( oResponse,"_BAIRRO","string",NIL,"Property cBAIRRO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cBASE              :=  WSAdvValue( oResponse,"_BASE","string",NIL,"Property cBASE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cBASE2             :=  WSAdvValue( oResponse,"_BASE2","string",NIL,"Property cBASE2 as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCEP               :=  WSAdvValue( oResponse,"_CEP","string",NIL,"Property cCEP as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cENDERECO          :=  WSAdvValue( oResponse,"_ENDERECO","string",NIL,"Property cENDERECO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cERSIN             :=  WSAdvValue( oResponse,"_ERSIN","string",NIL,"Property cERSIN as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cEST               :=  WSAdvValue( oResponse,"_EST","string",NIL,"Property cEST as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cMUN               :=  WSAdvValue( oResponse,"_MUN","string",NIL,"Property cMUN as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cSINDICATO         :=  WSAdvValue( oResponse,"_SINDICATO","string",NIL,"Property cSINDICATO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure SESCRITO

WSSTRUCT SINDHOSP_SESCRITO
	WSDATA   cCBAIRRO                  AS string OPTIONAL
	WSDATA   cCCEP                     AS string OPTIONAL
	WSDATA   cCCGC                     AS string OPTIONAL
	WSDATA   cCCODIGO                  AS string OPTIONAL
	WSDATA   cCCONTATO                 AS string OPTIONAL
	WSDATA   cCEMAIL                   AS string OPTIONAL
	WSDATA   cCEND                     AS string OPTIONAL
	WSDATA   cCFAX                     AS string OPTIONAL
	WSDATA   cCFILIAL                  AS string OPTIONAL
	WSDATA   cCMUN                     AS string OPTIONAL
	WSDATA   cCNOME                    AS string OPTIONAL
	WSDATA   cCTEL                     AS string OPTIONAL
	WSDATA   cCUF                      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SINDHOSP_SESCRITO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SINDHOSP_SESCRITO
Return

WSMETHOD CLONE WSCLIENT SINDHOSP_SESCRITO
	Local oClone := SINDHOSP_SESCRITO():NEW()
	oClone:cCBAIRRO             := ::cCBAIRRO
	oClone:cCCEP                := ::cCCEP
	oClone:cCCGC                := ::cCCGC
	oClone:cCCODIGO             := ::cCCODIGO
	oClone:cCCONTATO            := ::cCCONTATO
	oClone:cCEMAIL              := ::cCEMAIL
	oClone:cCEND                := ::cCEND
	oClone:cCFAX                := ::cCFAX
	oClone:cCFILIAL             := ::cCFILIAL
	oClone:cCMUN                := ::cCMUN
	oClone:cCNOME               := ::cCNOME
	oClone:cCTEL                := ::cCTEL
	oClone:cCUF                 := ::cCUF
Return oClone

WSMETHOD SOAPSEND WSCLIENT SINDHOSP_SESCRITO
	Local cSoap := ""
	cSoap += WSSoapValue("CBAIRRO", ::cCBAIRRO, ::cCBAIRRO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCEP", ::cCCEP, ::cCCEP , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCGC", ::cCCGC, ::cCCGC , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCODIGO", ::cCCODIGO, ::cCCODIGO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCONTATO", ::cCCONTATO, ::cCCONTATO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CEMAIL", ::cCEMAIL, ::cCEMAIL , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CEND", ::cCEND, ::cCEND , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CFAX", ::cCFAX, ::cCFAX , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CFILIAL", ::cCFILIAL, ::cCFILIAL , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CMUN", ::cCMUN, ::cCMUN , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CNOME", ::cCNOME, ::cCNOME , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CTEL", ::cCTEL, ::cCTEL , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CUF", ::cCUF, ::cCUF , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SINDHOSP_SESCRITO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCBAIRRO           :=  WSAdvValue( oResponse,"_CBAIRRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCEP              :=  WSAdvValue( oResponse,"_CCEP","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCGC              :=  WSAdvValue( oResponse,"_CCGC","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCODIGO           :=  WSAdvValue( oResponse,"_CCODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCONTATO          :=  WSAdvValue( oResponse,"_CCONTATO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEMAIL            :=  WSAdvValue( oResponse,"_CEMAIL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEND              :=  WSAdvValue( oResponse,"_CEND","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFAX              :=  WSAdvValue( oResponse,"_CFAX","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFILIAL           :=  WSAdvValue( oResponse,"_CFILIAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCMUN              :=  WSAdvValue( oResponse,"_CMUN","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNOME             :=  WSAdvValue( oResponse,"_CNOME","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCTEL              :=  WSAdvValue( oResponse,"_CTEL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCUF               :=  WSAdvValue( oResponse,"_CUF","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure STREMPRESA

WSSTRUCT SINDHOSP_STREMPRESA
	WSDATA   cCBAIRRO                  AS string OPTIONAL
	WSDATA   cCBASE                    AS string OPTIONAL
	WSDATA   cCBASE2                   AS string OPTIONAL
	WSDATA   cCCAPCENT                 AS string OPTIONAL
	WSDATA   cCCAPITAL                 AS string OPTIONAL
	WSDATA   cCCEP                     AS string OPTIONAL
	WSDATA   cCCGC                     AS string OPTIONAL
	WSDATA   cCCODIGO                  AS string OPTIONAL
	WSDATA   cCCONTATO                 AS string OPTIONAL
	WSDATA   cCEMAIL                   AS string OPTIONAL
	WSDATA   cCEND                     AS string OPTIONAL
	WSDATA   cCFAX                     AS string OPTIONAL
	WSDATA   cCFILANTR                 AS string OPTIONAL
	WSDATA   cCFILIAL                  AS string OPTIONAL
	WSDATA   cCFOLCENT                 AS string OPTIONAL
	WSDATA   cCINAT                    AS string OPTIONAL
	WSDATA   cCLOJA                    AS string OPTIONAL
	WSDATA   cCMUN                     AS string OPTIONAL
	WSDATA   cCNAE                     AS string OPTIONAL
	WSDATA   cCNATUREZ                 AS string OPTIONAL
	WSDATA   cCNOME                    AS string OPTIONAL
	WSDATA   cCODESCR                  AS string OPTIONAL
	WSDATA   cCSINDICA                 AS string OPTIONAL
	WSDATA   cCSITUAC                  AS string OPTIONAL
	WSDATA   cCTEL                     AS string OPTIONAL
	WSDATA   cCUF                      AS string OPTIONAL
	WSDATA   dDDTNASC                  AS date OPTIONAL
	WSDATA   dDINIATV                  AS date OPTIONAL
	WSDATA   cERSIN                    AS string OPTIONAL
	WSDATA   dINISIND                  AS date OPTIONAL
	WSDATA   cNCATEGOR                 AS string OPTIONAL
	WSDATA   cNLEITOS                  AS string OPTIONAL
	WSDATA   cNNUMFUN                  AS string OPTIONAL
	WSDATA   cPORTAL                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SINDHOSP_STREMPRESA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SINDHOSP_STREMPRESA
Return

WSMETHOD CLONE WSCLIENT SINDHOSP_STREMPRESA
	Local oClone := SINDHOSP_STREMPRESA():NEW()
	oClone:cCBAIRRO             := ::cCBAIRRO
	oClone:cCBASE               := ::cCBASE
	oClone:cCBASE2              := ::cCBASE2
	oClone:cCCAPCENT            := ::cCCAPCENT
	oClone:cCCAPITAL            := ::cCCAPITAL
	oClone:cCCEP                := ::cCCEP
	oClone:cCCGC                := ::cCCGC
	oClone:cCCODIGO             := ::cCCODIGO
	oClone:cCCONTATO            := ::cCCONTATO
	oClone:cCEMAIL              := ::cCEMAIL
	oClone:cCEND                := ::cCEND
	oClone:cCFAX                := ::cCFAX
	oClone:cCFILANTR            := ::cCFILANTR
	oClone:cCFILIAL             := ::cCFILIAL
	oClone:cCFOLCENT            := ::cCFOLCENT
	oClone:cCINAT               := ::cCINAT
	oClone:cCLOJA               := ::cCLOJA
	oClone:cCMUN                := ::cCMUN
	oClone:cCNAE                := ::cCNAE
	oClone:cCNATUREZ            := ::cCNATUREZ
	oClone:cCNOME               := ::cCNOME
	oClone:cCODESCR             := ::cCODESCR
	oClone:cCSINDICA            := ::cCSINDICA
	oClone:cCSITUAC             := ::cCSITUAC
	oClone:cCTEL                := ::cCTEL
	oClone:cCUF                 := ::cCUF
	oClone:dDDTNASC             := ::dDDTNASC
	oClone:dDINIATV             := ::dDINIATV
	oClone:cERSIN               := ::cERSIN
	oClone:dINISIND             := ::dINISIND
	oClone:cNCATEGOR            := ::cNCATEGOR
	oClone:cNLEITOS             := ::cNLEITOS
	oClone:cNNUMFUN             := ::cNNUMFUN
	oClone:cPORTAL              := ::cPORTAL
Return oClone

WSMETHOD SOAPSEND WSCLIENT SINDHOSP_STREMPRESA
	Local cSoap := ""
	cSoap += WSSoapValue("CBAIRRO", ::cCBAIRRO, ::cCBAIRRO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CBASE", ::cCBASE, ::cCBASE , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CBASE2", ::cCBASE2, ::cCBASE2 , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCAPCENT", ::cCCAPCENT, ::cCCAPCENT , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCAPITAL", ::cCCAPITAL, ::cCCAPITAL , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCEP", ::cCCEP, ::cCCEP , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCGC", ::cCCGC, ::cCCGC , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCODIGO", ::cCCODIGO, ::cCCODIGO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCONTATO", ::cCCONTATO, ::cCCONTATO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CEMAIL", ::cCEMAIL, ::cCEMAIL , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CEND", ::cCEND, ::cCEND , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CFAX", ::cCFAX, ::cCFAX , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CFILANTR", ::cCFILANTR, ::cCFILANTR , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CFILIAL", ::cCFILIAL, ::cCFILIAL , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CFOLCENT", ::cCFOLCENT, ::cCFOLCENT , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CINAT", ::cCINAT, ::cCINAT , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CLOJA", ::cCLOJA, ::cCLOJA , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CMUN", ::cCMUN, ::cCMUN , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CNAE", ::cCNAE, ::cCNAE , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CNATUREZ", ::cCNATUREZ, ::cCNATUREZ , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CNOME", ::cCNOME, ::cCNOME , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CODESCR", ::cCODESCR, ::cCODESCR , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CSINDICA", ::cCSINDICA, ::cCSINDICA , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CSITUAC", ::cCSITUAC, ::cCSITUAC , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CTEL", ::cCTEL, ::cCTEL , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CUF", ::cCUF, ::cCUF , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DDTNASC", ::dDDTNASC, ::dDDTNASC , "date", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DINIATV", ::dDINIATV, ::dDINIATV , "date", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("ERSIN", ::cERSIN, ::cERSIN , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("INISIND", ::dINISIND, ::dINISIND , "date", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NCATEGOR", ::cNCATEGOR, ::cNCATEGOR , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NLEITOS", ::cNLEITOS, ::cNLEITOS , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NNUMFUN", ::cNNUMFUN, ::cNNUMFUN , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PORTAL", ::cPORTAL, ::cPORTAL , "string", .F. , .F., 0 , NIL, .F.) 
Return cSoap

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SINDHOSP_STREMPRESA
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCBAIRRO           :=  WSAdvValue( oResponse,"_CBAIRRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCBASE             :=  WSAdvValue( oResponse,"_CBASE","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCBASE2            :=  WSAdvValue( oResponse,"_CBASE2","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCAPCENT          :=  WSAdvValue( oResponse,"_CCAPCENT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCAPITAL          :=  WSAdvValue( oResponse,"_CCAPITAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCEP              :=  WSAdvValue( oResponse,"_CCEP","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCGC              :=  WSAdvValue( oResponse,"_CCGC","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCODIGO           :=  WSAdvValue( oResponse,"_CCODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCONTATO          :=  WSAdvValue( oResponse,"_CCONTATO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEMAIL            :=  WSAdvValue( oResponse,"_CEMAIL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEND              :=  WSAdvValue( oResponse,"_CEND","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFAX              :=  WSAdvValue( oResponse,"_CFAX","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFILANTR          :=  WSAdvValue( oResponse,"_CFILANTR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFILIAL           :=  WSAdvValue( oResponse,"_CFILIAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFOLCENT          :=  WSAdvValue( oResponse,"_CFOLCENT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCINAT             :=  WSAdvValue( oResponse,"_CINAT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCLOJA             :=  WSAdvValue( oResponse,"_CLOJA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCMUN              :=  WSAdvValue( oResponse,"_CMUN","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNAE              :=  WSAdvValue( oResponse,"_CNAE","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNATUREZ          :=  WSAdvValue( oResponse,"_CNATUREZ","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNOME             :=  WSAdvValue( oResponse,"_CNOME","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCODESCR           :=  WSAdvValue( oResponse,"_CODESCR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCSINDICA          :=  WSAdvValue( oResponse,"_CSINDICA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCSITUAC           :=  WSAdvValue( oResponse,"_CSITUAC","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCTEL              :=  WSAdvValue( oResponse,"_CTEL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCUF               :=  WSAdvValue( oResponse,"_CUF","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dDDTNASC           :=  WSAdvValue( oResponse,"_DDTNASC","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDINIATV           :=  WSAdvValue( oResponse,"_DINIATV","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cERSIN             :=  WSAdvValue( oResponse,"_ERSIN","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dINISIND           :=  WSAdvValue( oResponse,"_INISIND","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cNCATEGOR          :=  WSAdvValue( oResponse,"_NCATEGOR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cNLEITOS           :=  WSAdvValue( oResponse,"_NLEITOS","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cNNUMFUN           :=  WSAdvValue( oResponse,"_NNUMFUN","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cPORTAL            :=  WSAdvValue( oResponse,"_PORTAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return


