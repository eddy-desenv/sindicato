#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://localhost:8081/sindhosp/SHATENDE.apw?WSDL
Gerado em        06/18/10 13:55:51
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.090116
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _BYXQOMS ; Return  // "dummy" function - Internal Use 

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
	WSMETHOD VERCADEMP
	WSMETHOD VERCADESC
	WSMETHOD VEREMPAUX
	WSMETHOD VEREMPESC
	WSMETHOD VERESCAUX
	WSMETHOD VINCESCR

	WSDATA   _URL                      AS String
	WSDATA   cCEP                      AS string
	WSDATA   oWSBUSCACEPRESULT         AS SHATENDE_SEND
	WSDATA   cCODESCR                  AS string
	WSDATA   oWSBUSCAESCRESULT         AS SHATENDE_SESCRITO
	WSDATA   cCCGC                     AS string
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
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.090818P-20100111] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSSHATENDE
	::oWSBUSCACEPRESULT  := SHATENDE_SEND():New()
	::oWSBUSCAESCRESULT  := SHATENDE_SESCRITO():New()
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
	::cCCGC              := NIL 
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
	oClone:cCCGC         := ::cCCGC
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

cSoap += '<BUSCACEP xmlns="http://localhost:8081/">'
cSoap += WSSoapValue("CEP", ::cCEP, cCEP , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCACEP>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8081/BUSCACEP",; 
	"DOCUMENT","http://localhost:8081/",,"1.031217",; 
	"http://localhost:8081/sindhosp/SHATENDE.apw")

::Init()
::oWSBUSCACEPRESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCACEPRESPONSE:_BUSCACEPRESULT","SEND",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BUSCAESC of Service WSSHATENDE

WSMETHOD BUSCAESC WSSEND cCODESCR WSRECEIVE oWSBUSCAESCRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BUSCAESC xmlns="http://localhost:8081/">'
cSoap += WSSoapValue("CODESCR", ::cCODESCR, cCODESCR , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCAESC>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8081/BUSCAESC",; 
	"DOCUMENT","http://localhost:8081/",,"1.031217",; 
	"http://localhost:8081/sindhosp/SHATENDE.apw")

::Init()
::oWSBUSCAESCRESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCAESCRESPONSE:_BUSCAESCRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VERCADEMP of Service WSSHATENDE

WSMETHOD VERCADEMP WSSEND cCCGC WSRECEIVE oWSVERCADEMPRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VERCADEMP xmlns="http://localhost:8081/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VERCADEMP>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8081/VERCADEMP",; 
	"DOCUMENT","http://localhost:8081/",,"1.031217",; 
	"http://localhost:8081/sindhosp/SHATENDE.apw")

::Init()
::oWSVERCADEMPRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VERCADEMPRESPONSE:_VERCADEMPRESULT","SEMPRATND",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VERCADESC of Service WSSHATENDE

WSMETHOD VERCADESC WSSEND cCCGC WSRECEIVE oWSVERCADESCRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VERCADESC xmlns="http://localhost:8081/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VERCADESC>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8081/VERCADESC",; 
	"DOCUMENT","http://localhost:8081/",,"1.031217",; 
	"http://localhost:8081/sindhosp/SHATENDE.apw")

::Init()
::oWSVERCADESCRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VERCADESCRESPONSE:_VERCADESCRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VEREMPAUX of Service WSSHATENDE

WSMETHOD VEREMPAUX WSSEND cCCGC WSRECEIVE oWSVEREMPAUXRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VEREMPAUX xmlns="http://localhost:8081/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VEREMPAUX>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8081/VEREMPAUX",; 
	"DOCUMENT","http://localhost:8081/",,"1.031217",; 
	"http://localhost:8081/sindhosp/SHATENDE.apw")

::Init()
::oWSVEREMPAUXRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VEREMPAUXRESPONSE:_VEREMPAUXRESULT","SEMPRATND",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VEREMPESC of Service WSSHATENDE

WSMETHOD VEREMPESC WSSEND cCODESCR WSRECEIVE oWSVEREMPESCRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VEREMPESC xmlns="http://localhost:8081/">'
cSoap += WSSoapValue("CODESCR", ::cCODESCR, cCODESCR , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VEREMPESC>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8081/VEREMPESC",; 
	"DOCUMENT","http://localhost:8081/",,"1.031217",; 
	"http://localhost:8081/sindhosp/SHATENDE.apw")

::Init()
::oWSVEREMPESCRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VEREMPESCRESPONSE:_VEREMPESCRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VERESCAUX of Service WSSHATENDE

WSMETHOD VERESCAUX WSSEND cCCGC WSRECEIVE oWSVERESCAUXRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VERESCAUX xmlns="http://localhost:8081/">'
cSoap += WSSoapValue("CCGC", ::cCCGC, cCCGC , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VERESCAUX>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8081/VERESCAUX",; 
	"DOCUMENT","http://localhost:8081/",,"1.031217",; 
	"http://localhost:8081/sindhosp/SHATENDE.apw")

::Init()
::oWSVERESCAUXRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VERESCAUXRESPONSE:_VERESCAUXRESULT","SESCRITO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VINCESCR of Service WSSHATENDE

WSMETHOD VINCESCR WSSEND cCODESCR,cCODEMP WSRECEIVE lVINCESCRRESULT WSCLIENT WSSHATENDE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VINCESCR xmlns="http://localhost:8081/">'
cSoap += WSSoapValue("CODESCR", ::cCODESCR, cCODESCR , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CODEMP", ::cCODEMP, cCODEMP , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</VINCESCR>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost:8081/VINCESCR",; 
	"DOCUMENT","http://localhost:8081/",,"1.031217",; 
	"http://localhost:8081/sindhosp/SHATENDE.apw")

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

// WSDL Data Structure SEMPRATND

WSSTRUCT SHATENDE_SEMPRATND
	WSDATA   cCBAIRRO                  AS string OPTIONAL
	WSDATA   cCCATEG1                  AS string OPTIONAL
	WSDATA   cCCEP                     AS string OPTIONAL
	WSDATA   cCCGC                     AS string OPTIONAL
	WSDATA   cCCODASSO                 AS string OPTIONAL
	WSDATA   cCCODIGO                  AS string OPTIONAL
	WSDATA   cCEMAIL                   AS string OPTIONAL
	WSDATA   cCEND                     AS string OPTIONAL
	WSDATA   cCESCCONT                 AS string OPTIONAL
	WSDATA   cCEST                     AS string OPTIONAL
	WSDATA   cCFILANT                  AS string OPTIONAL
	WSDATA   cCFILIAL                  AS string OPTIONAL
	WSDATA   cCLOJA                    AS string OPTIONAL
	WSDATA   cCMUN                     AS string OPTIONAL
	WSDATA   cCNOME                    AS string OPTIONAL
	WSDATA   cCNREDUZ                  AS string OPTIONAL
	WSDATA   cCSINDICA                 AS string OPTIONAL
	WSDATA   cCSITUAC                  AS string OPTIONAL
	WSDATA   cCTEL                     AS string OPTIONAL
	WSDATA   dDDTABERT                 AS date OPTIONAL
	WSDATA   dDDTCADAS                 AS date OPTIONAL
	WSDATA   dDDTINASS                 AS date OPTIONAL
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
	oClone:cCCATEG1             := ::cCCATEG1
	oClone:cCCEP                := ::cCCEP
	oClone:cCCGC                := ::cCCGC
	oClone:cCCODASSO            := ::cCCODASSO
	oClone:cCCODIGO             := ::cCCODIGO
	oClone:cCEMAIL              := ::cCEMAIL
	oClone:cCEND                := ::cCEND
	oClone:cCESCCONT            := ::cCESCCONT
	oClone:cCEST                := ::cCEST
	oClone:cCFILANT             := ::cCFILANT
	oClone:cCFILIAL             := ::cCFILIAL
	oClone:cCLOJA               := ::cCLOJA
	oClone:cCMUN                := ::cCMUN
	oClone:cCNOME               := ::cCNOME
	oClone:cCNREDUZ             := ::cCNREDUZ
	oClone:cCSINDICA            := ::cCSINDICA
	oClone:cCSITUAC             := ::cCSITUAC
	oClone:cCTEL                := ::cCTEL
	oClone:dDDTABERT            := ::dDDTABERT
	oClone:dDDTCADAS            := ::dDDTCADAS
	oClone:dDDTINASS            := ::dDDTINASS
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHATENDE_SEMPRATND
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCBAIRRO           :=  WSAdvValue( oResponse,"_CBAIRRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCATEG1           :=  WSAdvValue( oResponse,"_CCATEG1","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCEP              :=  WSAdvValue( oResponse,"_CCEP","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCGC              :=  WSAdvValue( oResponse,"_CCGC","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCODASSO          :=  WSAdvValue( oResponse,"_CCODASSO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCODIGO           :=  WSAdvValue( oResponse,"_CCODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEMAIL            :=  WSAdvValue( oResponse,"_CEMAIL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEND              :=  WSAdvValue( oResponse,"_CEND","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCESCCONT          :=  WSAdvValue( oResponse,"_CESCCONT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCEST              :=  WSAdvValue( oResponse,"_CEST","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFILANT           :=  WSAdvValue( oResponse,"_CFILANT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCFILIAL           :=  WSAdvValue( oResponse,"_CFILIAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCLOJA             :=  WSAdvValue( oResponse,"_CLOJA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCMUN              :=  WSAdvValue( oResponse,"_CMUN","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNOME             :=  WSAdvValue( oResponse,"_CNOME","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNREDUZ           :=  WSAdvValue( oResponse,"_CNREDUZ","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCSINDICA          :=  WSAdvValue( oResponse,"_CSINDICA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCSITUAC           :=  WSAdvValue( oResponse,"_CSITUAC","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCTEL              :=  WSAdvValue( oResponse,"_CTEL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dDDTABERT          :=  WSAdvValue( oResponse,"_DDTABERT","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDDTCADAS          :=  WSAdvValue( oResponse,"_DDTCADAS","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDDTINASS          :=  WSAdvValue( oResponse,"_DDTINASS","date",NIL,NIL,NIL,"D",NIL,NIL) 
Return


