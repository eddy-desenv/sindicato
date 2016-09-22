#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://192.168.0.2:8502/ws/SHATENDE.apw?WSDL
Gerado em        06/22/15 16:35:17
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _HBXRGQQ ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSSHATENDE
------------------------------------------------------------------------------- */

WSCLIENT WSSHATENDE

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD BUSCACEP
	WSMETHOD BUSCAESC
	WSMETHOD GETCOMBO
	WSMETHOD GETLOGIN
	WSMETHOD VERCADEMP
	WSMETHOD VERCADESC
	WSMETHOD VEREMPAUX
	WSMETHOD VEREMPESC
	WSMETHOD VERESCAUX
	WSMETHOD VINCESCR

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   cCEP                      AS string
	WSDATA   oWSBUSCACEPRESULT         AS SHATENDE_SEND
	WSDATA   cCODESCR                  AS string
	WSDATA   oWSBUSCAESCRESULT         AS SHATENDE_SESCRITO
	WSDATA   cCTIPO                    AS string
	WSDATA   cCNOME                    AS string
	WSDATA   oWSGETCOMBORESULT         AS SHATENDE_ARRAYOFSCOMBO
	WSDATA   cUSUARIO                  AS string
	WSDATA   cSENHA                    AS string
	WSDATA   oWSGETLOGINRESULT         AS SHATENDE_STRLOGIN
	WSDATA   cCCGC                     AS string
	WSDATA   cCLCGC                    AS string
	WSDATA   cCCOD                     AS string
	WSDATA   cCLNOME                   AS string
	WSDATA   oWSVERCADEMPRESULT        AS SHATENDE_SEMPRATND
	WSDATA   oWSVERCADESCRESULT        AS SHATENDE_SESCRITO
	WSDATA   oWSVEREMPAUXRESULT        AS SHATENDE_SEMPRATND
	WSDATA   oWSVEREMPESCRESULT        AS SHATENDE_SESCRITO
	WSDATA   oWSVERESCAUXRESULT        AS SHATENDE_SESCRITO
	WSDATA   cCODEMP                   AS string
	WSDATA   lVINCESCRRESULT           AS boolean

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSSHATENDE
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20141125] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSSHATENDE
	::oWSBUSCACEPRESULT  := SHATENDE_SEND():New()
	::oWSBUSCAESCRESULT  := SHATENDE_SESCRITO():New()
	::oWSGETCOMBORESULT  := SHATENDE_ARRAYOFSCOMBO():New()
	::oWSGETLOGINRESULT  := SHATENDE_STRLOGIN():New()
	::oWSVERCADEMPRESULT := SHATENDE_SEMPRATND():New()
	::oWSVERCADESCRESULT := SHATENDE_SESCRITO():New()
	::oWSVEREMPAUXRESULT := SHATENDE_SEMPRATND():New()
	::oWSVEREMPESCRESULT := SHATENDE_SESCRITO():New()
	::oWSVERESCAUXRESULT := SHATENDE_SESCRITO():New()
Return

WSMETHOD RESET WSCLIENT WSSHATENDE
	::cCEP               := NIL 
	::oWSBUSCACEPRESULT  := NIL 
	::cCODESCR           := NIL 
	::oWSBUSCAESCRESULT  := NIL 
	::cCTIPO             := NIL 
	::cCNOME             := NIL 
	::oWSGETCOMBORESULT  := NIL 
	::cUSUARIO           := NIL 
	::cSENHA             := NIL 
	::oWSGETLOGINRESULT  := NIL 
	::cCCGC              := NIL 
	::cCLCGC             := NIL 
	::cCCOD              := NIL 
	::cCLNOME            := NIL 
	::oWSVERCADEMPRESULT := NIL 
	::oWSVERCADESCRESULT := NIL 
	::oWSVEREMPAUXRESULT := NIL 
	::oWSVEREMPESCRESULT := NIL 
	::oWSVERESCAUXRESULT := NIL 
	::cCODEMP            := NIL 
	::lVINCESCRRESULT    := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSSHATENDE
Local oClone := WSSHATENDE():New()
	oClone:_URL          := ::_URL 
	oClone:cCEP          := ::cCEP
	oClone:oWSBUSCACEPRESULT :=  IIF(::oWSBUSCACEPRESULT = NIL , NIL ,::oWSBUSCACEPRESULT:Clone() )
	oClone:cCODESCR      := ::cCODESCR
	oClone:oWSBUSCAESCRESULT :=  IIF(::oWSBUSCAESCRESULT = NIL , NIL ,::oWSBUSCAESCRESULT:Clone() )
	oClone:cCTIPO        := ::cCTIPO
	oClone:cCNOME        := ::cCNOME
	oClone:oWSGETCOMBORESULT :=  IIF(::oWSGETCOMBORESULT = NIL , NIL ,::oWSGETCOMBORESULT:Clone() )
	oClone:cUSUARIO      := ::cUSUARIO
	oClone:cSENHA        := ::cSENHA
	oClone:oWSGETLOGINRESULT :=  IIF(::oWSGETLOGINRESULT = NIL , NIL ,::oWSGETLOGINRESULT:Clone() )
	oClone:cCCGC         := ::cCCGC
	oClone:cCLCGC        := ::cCLCGC
	oClone:cCCOD         := ::cCCOD
	oClone:cCLNOME       := ::cCLNOME
	oClone:oWSVERCADEMPRESULT :=  IIF(::oWSVERCADEMPRESULT = NIL , NIL ,::oWSVERCADEMPRESULT:Clone() )
	oClone:oWSVERCADESCRESULT :=  IIF(::oWSVERCADESCRESULT = NIL , NIL ,::oWSVERCADESCRESULT:Clone() )
	oClone:oWSVEREMPAUXRESULT :=  IIF(::oWSVEREMPAUXRESULT = NIL , NIL ,::oWSVEREMPAUXRESULT:Clone() )
	oClone:oWSVEREMPESCRESULT :=  IIF(::oWSVEREMPESCRESULT = NIL , NIL ,::oWSVEREMPESCRESULT:Clone() )
	oClone:oWSVERESCAUXRESULT :=  IIF(::oWSVERESCAUXRESULT = NIL , NIL ,::oWSVERESCAUXRESULT:Clone() )
	oClone:cCODEMP       := ::cCODEMP
	oClone:lVINCESCRRESULT := ::lVINCESCRRESULT
Return oClone

// WSDL Method BUSCACEP of Service WSSHATENDE

WSMETHOD BUSCACEP WSSEND cCEP WSRECEIVE oWSBUSCACEPRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BUSCACEP xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CEP", ::cCEP, cCEP , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCACEP>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/BUSCACEP",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::oWSBUSCACEPRESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCACEPRESPONSE:_BUSCACEPRESULT","SEND",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BUSCAESC of Service WSSHATENDE

WSMETHOD BUSCAESC WSSEND cCODESCR WSRECEIVE oWSBUSCAESCRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BUSCAESC xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CODESCR", ::cCODESCR, cCODESCR , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCAESC>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/BUSCAESC",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::oWSBUSCAESCRESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCAESCRESPONSE:_BUSCAESCRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETCOMBO of Service WSSHATENDE

WSMETHOD GETCOMBO WSSEND cCTIPO,cCNOME WSRECEIVE oWSGETCOMBORESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETCOMBO xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CTIPO", ::cCTIPO, cCTIPO , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CNOME", ::cCNOME, cCNOME , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GETCOMBO>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/GETCOMBO",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::oWSGETCOMBORESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETCOMBORESPONSE:_GETCOMBORESULT","ARRAYOFSCOMBO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETLOGIN of Service WSSHATENDE

WSMETHOD GETLOGIN WSSEND cUSUARIO,cSENHA WSRECEIVE oWSGETLOGINRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETLOGIN xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("USUARIO", ::cUSUARIO, cUSUARIO , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("SENHA", ::cSENHA, cSENHA , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</GETLOGIN>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/GETLOGIN",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::oWSGETLOGINRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETLOGINRESPONSE:_GETLOGINRESULT","STRLOGIN",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VERCADEMP of Service WSSHATENDE

WSMETHOD VERCADEMP WSSEND cCCGC,cCLCGC,cCCOD,cCNOME,cCLNOME WSRECEIVE oWSVERCADEMPRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VERCADEMP xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CLCGC", ::cCLCGC, cCLCGC , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CCOD", ::cCCOD, cCCOD , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CNOME", ::cCNOME, cCNOME , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CLNOME", ::cCLNOME, cCLNOME , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</VERCADEMP>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VERCADEMP",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::oWSVERCADEMPRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VERCADEMPRESPONSE:_VERCADEMPRESULT","SEMPRATND",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VERCADESC of Service WSSHATENDE

WSMETHOD VERCADESC WSSEND cCCGC WSRECEIVE oWSVERCADESCRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VERCADESC xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</VERCADESC>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VERCADESC",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::oWSVERCADESCRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VERCADESCRESPONSE:_VERCADESCRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VEREMPAUX of Service WSSHATENDE

WSMETHOD VEREMPAUX WSSEND cCCGC WSRECEIVE oWSVEREMPAUXRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VEREMPAUX xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</VEREMPAUX>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VEREMPAUX",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::oWSVEREMPAUXRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VEREMPAUXRESPONSE:_VEREMPAUXRESULT","SEMPRATND",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VEREMPESC of Service WSSHATENDE

WSMETHOD VEREMPESC WSSEND cCODESCR WSRECEIVE oWSVEREMPESCRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VEREMPESC xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CODESCR", ::cCODESCR, cCODESCR , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</VEREMPESC>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VEREMPESC",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::oWSVEREMPESCRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VEREMPESCRESPONSE:_VEREMPESCRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VERESCAUX of Service WSSHATENDE

WSMETHOD VERESCAUX WSSEND cCCGC WSRECEIVE oWSVERESCAUXRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VERESCAUX xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</VERESCAUX>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VERESCAUX",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::oWSVERESCAUXRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VERESCAUXRESPONSE:_VERESCAUXRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VINCESCR of Service WSSHATENDE

WSMETHOD VINCESCR WSSEND cCODESCR,cCODEMP WSRECEIVE lVINCESCRRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VINCESCR xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("CODESCR", ::cCODESCR, cCODESCR , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CODEMP", ::cCODEMP, cCODEMP , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</VINCESCR>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/VINCESCR",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHATENDE.apw")

::Init()
::lVINCESCRRESULT    :=  WSAdvValue( oXmlRet,"_VINCESCRRESPONSE:_VINCESCRRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure SEND

WSSTRUCT SHATENDE_SEND
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

WSMETHOD NEW WSCLIENT SHATENDE_SEND
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHATENDE_SEND
Return

WSMETHOD CLONE WSCLIENT SHATENDE_SEND
	Local oClone := SHATENDE_SEND():NEW()
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

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHATENDE_SEND
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

WSSTRUCT SHATENDE_SESCRITO
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
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHATENDE_SESCRITO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHATENDE_SESCRITO
Return

WSMETHOD CLONE WSCLIENT SHATENDE_SESCRITO
	Local oClone := SHATENDE_SESCRITO():NEW()
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

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHATENDE_SESCRITO
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

// WSDL Data Structure ARRAYOFSCOMBO

WSSTRUCT SHATENDE_ARRAYOFSCOMBO
	WSDATA   oWSSCOMBO                 AS SHATENDE_SCOMBO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHATENDE_ARRAYOFSCOMBO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHATENDE_ARRAYOFSCOMBO
	::oWSSCOMBO            := {} // Array Of  SHATENDE_SCOMBO():New()
Return

WSMETHOD CLONE WSCLIENT SHATENDE_ARRAYOFSCOMBO
	Local oClone := SHATENDE_ARRAYOFSCOMBO():NEW()
	oClone:oWSSCOMBO := NIL
	If ::oWSSCOMBO <> NIL 
		oClone:oWSSCOMBO := {}
		aEval( ::oWSSCOMBO , { |x| aadd( oClone:oWSSCOMBO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHATENDE_ARRAYOFSCOMBO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_SCOMBO","SCOMBO",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSSCOMBO , SHATENDE_SCOMBO():New() )
			::oWSSCOMBO[len(::oWSSCOMBO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure STRLOGIN

WSSTRUCT SHATENDE_STRLOGIN
	WSDATA   cCODIGO                   AS string OPTIONAL
	WSDATA   cNOME                     AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHATENDE_STRLOGIN
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHATENDE_STRLOGIN
Return

WSMETHOD CLONE WSCLIENT SHATENDE_STRLOGIN
	Local oClone := SHATENDE_STRLOGIN():NEW()
	oClone:cCODIGO              := ::cCODIGO
	oClone:cNOME                := ::cNOME
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHATENDE_STRLOGIN
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCODIGO            :=  WSAdvValue( oResponse,"_CODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cNOME              :=  WSAdvValue( oResponse,"_NOME","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure SEMPRATND

WSSTRUCT SHATENDE_SEMPRATND
	WSDATA   cCBAIRRO                  AS string OPTIONAL
	WSDATA   cCBASE                    AS string OPTIONAL
	WSDATA   cCBASE2                   AS string OPTIONAL
	WSDATA   cCCAPITAL                 AS string OPTIONAL
	WSDATA   cCCATEG1                  AS string OPTIONAL
	WSDATA   cCCEP                     AS string OPTIONAL
	WSDATA   cCCGC                     AS string OPTIONAL
	WSDATA   cCCODASSO                 AS string OPTIONAL
	WSDATA   cCCODIGO                  AS string OPTIONAL
	WSDATA   cCCONTATO                 AS string OPTIONAL
	WSDATA   cCEMAIL                   AS string OPTIONAL
	WSDATA   cCEND                     AS string OPTIONAL
	WSDATA   cCERSIN                   AS string OPTIONAL
	WSDATA   cCESCCONT                 AS string OPTIONAL
	WSDATA   cCEST                     AS string OPTIONAL
	WSDATA   cCFAX                     AS string OPTIONAL
	WSDATA   cCFILANT                  AS string OPTIONAL
	WSDATA   cCFILIAL                  AS string OPTIONAL
	WSDATA   cCFOLCENT                 AS string OPTIONAL
	WSDATA   cCINAT                    AS string OPTIONAL
	WSDATA   cCLOJA                    AS string OPTIONAL
	WSDATA   cCMUN                     AS string OPTIONAL
	WSDATA   cCNATUREZ                 AS string OPTIONAL
	WSDATA   cCNOME                    AS string OPTIONAL
	WSDATA   cCNREDUZ                  AS string OPTIONAL
	WSDATA   cCSINDICA                 AS string OPTIONAL
	WSDATA   cCSITUAC                  AS string OPTIONAL
	WSDATA   cCTEL                     AS string OPTIONAL
	WSDATA   cCUF                      AS string OPTIONAL
	WSDATA   dDDTABERT                 AS date OPTIONAL
	WSDATA   dDDTCADAS                 AS date OPTIONAL
	WSDATA   dDDTFIMAS                 AS date OPTIONAL
	WSDATA   dDDTINASS                 AS date OPTIONAL
	WSDATA   dDDTNASC                  AS date OPTIONAL
	WSDATA   dDINIATV                  AS date OPTIONAL
	WSDATA   cNCATEGOR                 AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHATENDE_SEMPRATND
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHATENDE_SEMPRATND
Return

WSMETHOD CLONE WSCLIENT SHATENDE_SEMPRATND
	Local oClone := SHATENDE_SEMPRATND():NEW()
	oClone:cCBAIRRO             := ::cCBAIRRO
	oClone:cCBASE               := ::cCBASE
	oClone:cCBASE2              := ::cCBASE2
	oClone:cCCAPITAL            := ::cCCAPITAL
	oClone:cCCATEG1             := ::cCCATEG1
	oClone:cCCEP                := ::cCCEP
	oClone:cCCGC                := ::cCCGC
	oClone:cCCODASSO            := ::cCCODASSO
	oClone:cCCODIGO             := ::cCCODIGO
	oClone:cCCONTATO            := ::cCCONTATO
	oClone:cCEMAIL              := ::cCEMAIL
	oClone:cCEND                := ::cCEND
	oClone:cCERSIN              := ::cCERSIN
	oClone:cCESCCONT            := ::cCESCCONT
	oClone:cCEST                := ::cCEST
	oClone:cCFAX                := ::cCFAX
	oClone:cCFILANT             := ::cCFILANT
	oClone:cCFILIAL             := ::cCFILIAL
	oClone:cCFOLCENT            := ::cCFOLCENT
	oClone:cCINAT               := ::cCINAT
	oClone:cCLOJA               := ::cCLOJA
	oClone:cCMUN                := ::cCMUN
	oClone:cCNATUREZ            := ::cCNATUREZ
	oClone:cCNOME               := ::cCNOME
	oClone:cCNREDUZ             := ::cCNREDUZ
	oClone:cCSINDICA            := ::cCSINDICA
	oClone:cCSITUAC             := ::cCSITUAC
	oClone:cCTEL                := ::cCTEL
	oClone:cCUF                 := ::cCUF
	oClone:dDDTABERT            := ::dDDTABERT
	oClone:dDDTCADAS            := ::dDDTCADAS
	oClone:dDDTFIMAS            := ::dDDTFIMAS
	oClone:dDDTINASS            := ::dDDTINASS
	oClone:dDDTNASC             := ::dDDTNASC
	oClone:dDINIATV             := ::dDINIATV
	oClone:cNCATEGOR            := ::cNCATEGOR
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHATENDE_SEMPRATND
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCBAIRRO           :=  WSAdvValue( oResponse,"_CBAIRRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCBASE             :=  WSAdvValue( oResponse,"_CBASE","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCBASE2            :=  WSAdvValue( oResponse,"_CBASE2","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCAPITAL          :=  WSAdvValue( oResponse,"_CCAPITAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCATEG1           :=  WSAdvValue( oResponse,"_CCATEG1","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCEP              :=  WSAdvValue( oResponse,"_CCEP","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCGC              :=  WSAdvValue( oResponse,"_CCGC","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCODASSO          :=  WSAdvValue( oResponse,"_CCODASSO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCODIGO           :=  WSAdvValue( oResponse,"_CCODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCONTATO          :=  WSAdvValue( oResponse,"_CCONTATO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEMAIL            :=  WSAdvValue( oResponse,"_CEMAIL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEND              :=  WSAdvValue( oResponse,"_CEND","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCERSIN            :=  WSAdvValue( oResponse,"_CERSIN","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCESCCONT          :=  WSAdvValue( oResponse,"_CESCCONT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEST              :=  WSAdvValue( oResponse,"_CEST","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFAX              :=  WSAdvValue( oResponse,"_CFAX","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFILANT           :=  WSAdvValue( oResponse,"_CFILANT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFILIAL           :=  WSAdvValue( oResponse,"_CFILIAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFOLCENT          :=  WSAdvValue( oResponse,"_CFOLCENT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCINAT             :=  WSAdvValue( oResponse,"_CINAT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCLOJA             :=  WSAdvValue( oResponse,"_CLOJA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCMUN              :=  WSAdvValue( oResponse,"_CMUN","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNATUREZ          :=  WSAdvValue( oResponse,"_CNATUREZ","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNOME             :=  WSAdvValue( oResponse,"_CNOME","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNREDUZ           :=  WSAdvValue( oResponse,"_CNREDUZ","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCSINDICA          :=  WSAdvValue( oResponse,"_CSINDICA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCSITUAC           :=  WSAdvValue( oResponse,"_CSITUAC","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCTEL              :=  WSAdvValue( oResponse,"_CTEL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCUF               :=  WSAdvValue( oResponse,"_CUF","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dDDTABERT          :=  WSAdvValue( oResponse,"_DDTABERT","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDDTCADAS          :=  WSAdvValue( oResponse,"_DDTCADAS","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDDTFIMAS          :=  WSAdvValue( oResponse,"_DDTFIMAS","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDDTINASS          :=  WSAdvValue( oResponse,"_DDTINASS","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDDTNASC           :=  WSAdvValue( oResponse,"_DDTNASC","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDINIATV           :=  WSAdvValue( oResponse,"_DINIATV","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cNCATEGOR          :=  WSAdvValue( oResponse,"_NCATEGOR","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure SCOMBO

WSSTRUCT SHATENDE_SCOMBO
	WSDATA   cCVALUE                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHATENDE_SCOMBO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHATENDE_SCOMBO
Return

WSMETHOD CLONE WSCLIENT SHATENDE_SCOMBO
	Local oClone := SHATENDE_SCOMBO():NEW()
	oClone:cCVALUE              := ::cCVALUE
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHATENDE_SCOMBO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCVALUE            :=  WSAdvValue( oResponse,"_CVALUE","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return


