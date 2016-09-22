#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://192.168.0.2:8502/ws/SHBOLETO.apw?WSDL
Gerado em        06/23/15 14:41:41
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _OVXWQDV ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSSHBOLETO
------------------------------------------------------------------------------- */

WSCLIENT WSSHBOLETO

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD BUSCAANO
	WSMETHOD BUSCAASSO
	WSMETHOD BUSCACONF
	WSMETHOD BUSCADADO
	WSMETHOD CALCASSI
	WSMETHOD DADOSASSO
	WSMETHOD DADOSCONF
	WSMETHOD DADOSNEG
	WSMETHOD GRAVADADO

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   cNULO                     AS string
	WSDATA   oWSBUSCAANORESULT         AS SHBOLETO_ARRAYOFSANO
	WSDATA   oWSAEMPRESA               AS SHBOLETO_STREMPRESA
	WSDATA   oWSBUSCAASSORESULT        AS SHBOLETO_ARRAYOFSCASSO
	WSDATA   cSINDICA                  AS string
	WSDATA   oWSBUSCACONFRESULT        AS SHBOLETO_SINDICAL
	WSDATA   cANO                      AS string
	WSDATA   oWSBUSCADADORESULT        AS SHBOLETO_SINDICAL
	WSDATA   oWSCALCASSIRESULT         AS SHBOLETO_ARRAYOFSCLCASSI
	WSDATA   oWSAPEDIDO                AS SHBOLETO_SPEDIDO
	WSDATA   oWSDADOSASSORESULT        AS SHBOLETO_SINDICAL
	WSDATA   lLRETURN                  AS boolean
	WSDATA   cCODIGO                   AS string
	WSDATA   cITEM                     AS string
	WSDATA   oWSDADOSCONFRESULT        AS SHBOLETO_ARRAYOFSCCONF
	WSDATA   oWSDADOSNEGRESULT         AS SHBOLETO_SINDICAL
	WSDATA   oWSABOLETO                AS SHBOLETO_SBOLETO
	WSDATA   cGRAVADADORESULT          AS string

	// Estruturas mantidas por compatibilidade - NÃO USAR
	WSDATA   oWSSTREMPRESA             AS SHBOLETO_STREMPRESA
	WSDATA   oWSSPEDIDO                AS SHBOLETO_SPEDIDO
	WSDATA   oWSSBOLETO                AS SHBOLETO_SBOLETO

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSSHBOLETO
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20141125] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSSHBOLETO
	::oWSBUSCAANORESULT  := SHBOLETO_ARRAYOFSANO():New()
	::oWSAEMPRESA        := SHBOLETO_STREMPRESA():New()
	::oWSBUSCAASSORESULT := SHBOLETO_ARRAYOFSCASSO():New()
	::oWSBUSCACONFRESULT := SHBOLETO_SINDICAL():New()
	::oWSBUSCADADORESULT := SHBOLETO_SINDICAL():New()
	::oWSCALCASSIRESULT  := SHBOLETO_ARRAYOFSCLCASSI():New()
	::oWSAPEDIDO         := SHBOLETO_SPEDIDO():New()
	::oWSDADOSASSORESULT := SHBOLETO_SINDICAL():New()
	::oWSDADOSCONFRESULT := SHBOLETO_ARRAYOFSCCONF():New()
	::oWSDADOSNEGRESULT  := SHBOLETO_SINDICAL():New()
	::oWSABOLETO         := SHBOLETO_SBOLETO():New()

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSSTREMPRESA      := ::oWSAEMPRESA
	::oWSSPEDIDO         := ::oWSAPEDIDO
	::oWSSBOLETO         := ::oWSABOLETO
Return

WSMETHOD RESET WSCLIENT WSSHBOLETO
	::cNULO              := NIL 
	::oWSBUSCAANORESULT  := NIL 
	::oWSAEMPRESA        := NIL 
	::oWSBUSCAASSORESULT := NIL 
	::cSINDICA           := NIL 
	::oWSBUSCACONFRESULT := NIL 
	::cANO               := NIL 
	::oWSBUSCADADORESULT := NIL 
	::oWSCALCASSIRESULT  := NIL 
	::oWSAPEDIDO         := NIL 
	::oWSDADOSASSORESULT := NIL 
	::lLRETURN           := NIL 
	::cCODIGO            := NIL 
	::cITEM              := NIL 
	::oWSDADOSCONFRESULT := NIL 
	::oWSDADOSNEGRESULT  := NIL 
	::oWSABOLETO         := NIL 
	::cGRAVADADORESULT   := NIL 

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSSTREMPRESA      := NIL
	::oWSSPEDIDO         := NIL
	::oWSSBOLETO         := NIL
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSSHBOLETO
Local oClone := WSSHBOLETO():New()
	oClone:_URL          := ::_URL 
	oClone:cNULO         := ::cNULO
	oClone:oWSBUSCAANORESULT :=  IIF(::oWSBUSCAANORESULT = NIL , NIL ,::oWSBUSCAANORESULT:Clone() )
	oClone:oWSAEMPRESA   :=  IIF(::oWSAEMPRESA = NIL , NIL ,::oWSAEMPRESA:Clone() )
	oClone:oWSBUSCAASSORESULT :=  IIF(::oWSBUSCAASSORESULT = NIL , NIL ,::oWSBUSCAASSORESULT:Clone() )
	oClone:cSINDICA      := ::cSINDICA
	oClone:oWSBUSCACONFRESULT :=  IIF(::oWSBUSCACONFRESULT = NIL , NIL ,::oWSBUSCACONFRESULT:Clone() )
	oClone:cANO          := ::cANO
	oClone:oWSBUSCADADORESULT :=  IIF(::oWSBUSCADADORESULT = NIL , NIL ,::oWSBUSCADADORESULT:Clone() )
	oClone:oWSCALCASSIRESULT :=  IIF(::oWSCALCASSIRESULT = NIL , NIL ,::oWSCALCASSIRESULT:Clone() )
	oClone:oWSAPEDIDO    :=  IIF(::oWSAPEDIDO = NIL , NIL ,::oWSAPEDIDO:Clone() )
	oClone:oWSDADOSASSORESULT :=  IIF(::oWSDADOSASSORESULT = NIL , NIL ,::oWSDADOSASSORESULT:Clone() )
	oClone:lLRETURN      := ::lLRETURN
	oClone:cCODIGO       := ::cCODIGO
	oClone:cITEM         := ::cITEM
	oClone:oWSDADOSCONFRESULT :=  IIF(::oWSDADOSCONFRESULT = NIL , NIL ,::oWSDADOSCONFRESULT:Clone() )
	oClone:oWSDADOSNEGRESULT :=  IIF(::oWSDADOSNEGRESULT = NIL , NIL ,::oWSDADOSNEGRESULT:Clone() )
	oClone:oWSABOLETO    :=  IIF(::oWSABOLETO = NIL , NIL ,::oWSABOLETO:Clone() )
	oClone:cGRAVADADORESULT := ::cGRAVADADORESULT

	// Estruturas mantidas por compatibilidade - NÃO USAR
	oClone:oWSSTREMPRESA := oClone:oWSAEMPRESA
	oClone:oWSSPEDIDO    := oClone:oWSAPEDIDO
	oClone:oWSSBOLETO    := oClone:oWSABOLETO
Return oClone

// WSDL Method BUSCAANO of Service WSSHBOLETO

WSMETHOD BUSCAANO WSSEND cNULO WSRECEIVE oWSBUSCAANORESULT WSCLIENT WSSHBOLETO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BUSCAANO xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("NULO", ::cNULO, cNULO , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCAANO>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/BUSCAANO",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHBOLETO.apw")

::Init()
::oWSBUSCAANORESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCAANORESPONSE:_BUSCAANORESULT","ARRAYOFSANO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BUSCAASSO of Service WSSHBOLETO

WSMETHOD BUSCAASSO WSSEND oWSAEMPRESA WSRECEIVE oWSBUSCAASSORESULT WSCLIENT WSSHBOLETO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BUSCAASSO xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("AEMPRESA", ::oWSAEMPRESA, oWSAEMPRESA , "STREMPRESA", .T. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCAASSO>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/BUSCAASSO",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHBOLETO.apw")

::Init()
::oWSBUSCAASSORESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCAASSORESPONSE:_BUSCAASSORESULT","ARRAYOFSCASSO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BUSCACONF of Service WSSHBOLETO

WSMETHOD BUSCACONF WSSEND cSINDICA WSRECEIVE oWSBUSCACONFRESULT WSCLIENT WSSHBOLETO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BUSCACONF xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("SINDICA", ::cSINDICA, cSINDICA , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCACONF>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/BUSCACONF",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHBOLETO.apw")

::Init()
::oWSBUSCACONFRESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCACONFRESPONSE:_BUSCACONFRESULT","SINDICAL",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method BUSCADADO of Service WSSHBOLETO

WSMETHOD BUSCADADO WSSEND cANO,oWSAEMPRESA WSRECEIVE oWSBUSCADADORESULT WSCLIENT WSSHBOLETO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<BUSCADADO xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("ANO", ::cANO, cANO , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("AEMPRESA", ::oWSAEMPRESA, oWSAEMPRESA , "STREMPRESA", .T. , .F., 0 , NIL, .F.) 
cSoap += "</BUSCADADO>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/BUSCADADO",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHBOLETO.apw")

::Init()
::oWSBUSCADADORESULT:SoapRecv( WSAdvValue( oXmlRet,"_BUSCADADORESPONSE:_BUSCADADORESULT","SINDICAL",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CALCASSI of Service WSSHBOLETO

WSMETHOD CALCASSI WSSEND oWSAEMPRESA WSRECEIVE oWSCALCASSIRESULT WSCLIENT WSSHBOLETO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CALCASSI xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("AEMPRESA", ::oWSAEMPRESA, oWSAEMPRESA , "STREMPRESA", .T. , .F., 0 , NIL, .F.) 
cSoap += "</CALCASSI>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/CALCASSI",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHBOLETO.apw")

::Init()
::oWSCALCASSIRESULT:SoapRecv( WSAdvValue( oXmlRet,"_CALCASSIRESPONSE:_CALCASSIRESULT","ARRAYOFSCLCASSI",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method DADOSASSO of Service WSSHBOLETO

WSMETHOD DADOSASSO WSSEND oWSAPEDIDO,oWSAEMPRESA WSRECEIVE oWSDADOSASSORESULT WSCLIENT WSSHBOLETO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<DADOSASSO xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("APEDIDO", ::oWSAPEDIDO, oWSAPEDIDO , "SPEDIDO", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("AEMPRESA", ::oWSAEMPRESA, oWSAEMPRESA , "STREMPRESA", .T. , .F., 0 , NIL, .F.) 
cSoap += "</DADOSASSO>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/DADOSASSO",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHBOLETO.apw")

::Init()
::oWSDADOSASSORESULT:SoapRecv( WSAdvValue( oXmlRet,"_DADOSASSORESPONSE:_DADOSASSORESULT","SINDICAL",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method DADOSCONF of Service WSSHBOLETO

WSMETHOD DADOSCONF WSSEND lLRETURN,cCODIGO,cITEM,oWSAEMPRESA WSRECEIVE oWSDADOSCONFRESULT WSCLIENT WSSHBOLETO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<DADOSCONF xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("LRETURN", ::lLRETURN, lLRETURN , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CODIGO", ::cCODIGO, cCODIGO , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("ITEM", ::cITEM, cITEM , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("AEMPRESA", ::oWSAEMPRESA, oWSAEMPRESA , "STREMPRESA", .T. , .F., 0 , NIL, .F.) 
cSoap += "</DADOSCONF>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/DADOSCONF",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHBOLETO.apw")

::Init()
::oWSDADOSCONFRESULT:SoapRecv( WSAdvValue( oXmlRet,"_DADOSCONFRESPONSE:_DADOSCONFRESULT","ARRAYOFSCCONF",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method DADOSNEG of Service WSSHBOLETO

WSMETHOD DADOSNEG WSSEND cSINDICA WSRECEIVE oWSDADOSNEGRESULT WSCLIENT WSSHBOLETO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<DADOSNEG xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("SINDICA", ::cSINDICA, cSINDICA , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += "</DADOSNEG>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/DADOSNEG",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHBOLETO.apw")

::Init()
::oWSDADOSNEGRESULT:SoapRecv( WSAdvValue( oXmlRet,"_DADOSNEGRESPONSE:_DADOSNEGRESULT","SINDICAL",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GRAVADADO of Service WSSHBOLETO

WSMETHOD GRAVADADO WSSEND oWSABOLETO WSRECEIVE cGRAVADADORESULT WSCLIENT WSSHBOLETO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GRAVADADO xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("ABOLETO", ::oWSABOLETO, oWSABOLETO , "SBOLETO", .T. , .F., 0 , NIL, .F.) 
cSoap += "</GRAVADADO>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/GRAVADADO",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHBOLETO.apw")

::Init()
::cGRAVADADORESULT   :=  WSAdvValue( oXmlRet,"_GRAVADADORESPONSE:_GRAVADADORESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure ARRAYOFSANO

WSSTRUCT SHBOLETO_ARRAYOFSANO
	WSDATA   oWSSANO                   AS SHBOLETO_SANO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_ARRAYOFSANO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_ARRAYOFSANO
	::oWSSANO              := {} // Array Of  SHBOLETO_SANO():New()
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_ARRAYOFSANO
	Local oClone := SHBOLETO_ARRAYOFSANO():NEW()
	oClone:oWSSANO := NIL
	If ::oWSSANO <> NIL 
		oClone:oWSSANO := {}
		aEval( ::oWSSANO , { |x| aadd( oClone:oWSSANO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHBOLETO_ARRAYOFSANO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_SANO","SANO",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSSANO , SHBOLETO_SANO():New() )
			::oWSSANO[len(::oWSSANO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure STREMPRESA

WSSTRUCT SHBOLETO_STREMPRESA
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
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_STREMPRESA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_STREMPRESA
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_STREMPRESA
	Local oClone := SHBOLETO_STREMPRESA():NEW()
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

WSMETHOD SOAPSEND WSCLIENT SHBOLETO_STREMPRESA
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

// WSDL Data Structure ARRAYOFSCASSO

WSSTRUCT SHBOLETO_ARRAYOFSCASSO
	WSDATA   oWSSCASSO                 AS SHBOLETO_SCASSO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_ARRAYOFSCASSO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_ARRAYOFSCASSO
	::oWSSCASSO            := {} // Array Of  SHBOLETO_SCASSO():New()
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_ARRAYOFSCASSO
	Local oClone := SHBOLETO_ARRAYOFSCASSO():NEW()
	oClone:oWSSCASSO := NIL
	If ::oWSSCASSO <> NIL 
		oClone:oWSSCASSO := {}
		aEval( ::oWSSCASSO , { |x| aadd( oClone:oWSSCASSO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHBOLETO_ARRAYOFSCASSO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_SCASSO","SCASSO",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSSCASSO , SHBOLETO_SCASSO():New() )
			::oWSSCASSO[len(::oWSSCASSO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure SINDICAL

WSSTRUCT SHBOLETO_SINDICAL
	WSDATA   cADIC                     AS string OPTIONAL
	WSDATA   cAGENCIA                  AS string OPTIONAL
	WSDATA   cALIQ                     AS string OPTIONAL
	WSDATA   lAPLACR                   AS boolean OPTIONAL
	WSDATA   cCEDENTE                  AS string OPTIONAL
	WSDATA   cCNAE                     AS string OPTIONAL
	WSDATA   cCODBCO                   AS string OPTIONAL
	WSDATA   cCONTA                    AS string OPTIONAL
	WSDATA   cCONTRB                   AS string OPTIONAL
	WSDATA   nCORREC                   AS float OPTIONAL
	WSDATA   dDTPGTO                   AS date OPTIONAL
	WSDATA   cIMAGEM                   AS string OPTIONAL
	WSDATA   cLINK                     AS string OPTIONAL
	WSDATA   cMOEDA                    AS string OPTIONAL
	WSDATA   nMORA                     AS float OPTIONAL
	WSDATA   cMSG1                     AS string OPTIONAL
	WSDATA   cMSG2                     AS string OPTIONAL
	WSDATA   cMSG3                     AS string OPTIONAL
	WSDATA   cMSG4                     AS string OPTIONAL
	WSDATA   cMSG5                     AS string OPTIONAL
	WSDATA   cMSG6                     AS string OPTIONAL
	WSDATA   cMSG7                     AS string OPTIONAL
	WSDATA   cMSG8                     AS string OPTIONAL
	WSDATA   cMSG9                     AS string OPTIONAL
	WSDATA   nMULTA                    AS float OPTIONAL
	WSDATA   cNATUREZ                  AS string OPTIONAL
	WSDATA   cNOMEBCO                  AS string OPTIONAL
	WSDATA   cNUMTIT                   AS string OPTIONAL
	WSDATA   cPREFIXO                  AS string OPTIONAL
	WSDATA   cSDBAIRRO                 AS string OPTIONAL
	WSDATA   cSDCEP                    AS string OPTIONAL
	WSDATA   cSDCGC                    AS string OPTIONAL
	WSDATA   cSDEND                    AS string OPTIONAL
	WSDATA   cSDENTID2                 AS string OPTIONAL
	WSDATA   cSDENTIDA                 AS string OPTIONAL
	WSDATA   cSDEST                    AS string OPTIONAL
	WSDATA   cSDMUN                    AS string OPTIONAL
	WSDATA   cSDNOME                   AS string OPTIONAL
	WSDATA   cSIND                     AS string OPTIONAL
	WSDATA   cTIT                      AS string OPTIONAL
	WSDATA   cVALOR                    AS string OPTIONAL
	WSDATA   dVENCTO                   AS date OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_SINDICAL
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_SINDICAL
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_SINDICAL
	Local oClone := SHBOLETO_SINDICAL():NEW()
	oClone:cADIC                := ::cADIC
	oClone:cAGENCIA             := ::cAGENCIA
	oClone:cALIQ                := ::cALIQ
	oClone:lAPLACR              := ::lAPLACR
	oClone:cCEDENTE             := ::cCEDENTE
	oClone:cCNAE                := ::cCNAE
	oClone:cCODBCO              := ::cCODBCO
	oClone:cCONTA               := ::cCONTA
	oClone:cCONTRB              := ::cCONTRB
	oClone:nCORREC              := ::nCORREC
	oClone:dDTPGTO              := ::dDTPGTO
	oClone:cIMAGEM              := ::cIMAGEM
	oClone:cLINK                := ::cLINK
	oClone:cMOEDA               := ::cMOEDA
	oClone:nMORA                := ::nMORA
	oClone:cMSG1                := ::cMSG1
	oClone:cMSG2                := ::cMSG2
	oClone:cMSG3                := ::cMSG3
	oClone:cMSG4                := ::cMSG4
	oClone:cMSG5                := ::cMSG5
	oClone:cMSG6                := ::cMSG6
	oClone:cMSG7                := ::cMSG7
	oClone:cMSG8                := ::cMSG8
	oClone:cMSG9                := ::cMSG9
	oClone:nMULTA               := ::nMULTA
	oClone:cNATUREZ             := ::cNATUREZ
	oClone:cNOMEBCO             := ::cNOMEBCO
	oClone:cNUMTIT              := ::cNUMTIT
	oClone:cPREFIXO             := ::cPREFIXO
	oClone:cSDBAIRRO            := ::cSDBAIRRO
	oClone:cSDCEP               := ::cSDCEP
	oClone:cSDCGC               := ::cSDCGC
	oClone:cSDEND               := ::cSDEND
	oClone:cSDENTID2            := ::cSDENTID2
	oClone:cSDENTIDA            := ::cSDENTIDA
	oClone:cSDEST               := ::cSDEST
	oClone:cSDMUN               := ::cSDMUN
	oClone:cSDNOME              := ::cSDNOME
	oClone:cSIND                := ::cSIND
	oClone:cTIT                 := ::cTIT
	oClone:cVALOR               := ::cVALOR
	oClone:dVENCTO              := ::dVENCTO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHBOLETO_SINDICAL
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cADIC              :=  WSAdvValue( oResponse,"_ADIC","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cAGENCIA           :=  WSAdvValue( oResponse,"_AGENCIA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cALIQ              :=  WSAdvValue( oResponse,"_ALIQ","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::lAPLACR            :=  WSAdvValue( oResponse,"_APLACR","boolean",NIL,NIL,NIL,"L",NIL,NIL) 
	::cCEDENTE           :=  WSAdvValue( oResponse,"_CEDENTE","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNAE              :=  WSAdvValue( oResponse,"_CNAE","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCODBCO            :=  WSAdvValue( oResponse,"_CODBCO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCONTA             :=  WSAdvValue( oResponse,"_CONTA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCONTRB            :=  WSAdvValue( oResponse,"_CONTRB","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nCORREC            :=  WSAdvValue( oResponse,"_CORREC","float",NIL,NIL,NIL,"N",NIL,NIL) 
	::dDTPGTO            :=  WSAdvValue( oResponse,"_DTPGTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cIMAGEM            :=  WSAdvValue( oResponse,"_IMAGEM","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cLINK              :=  WSAdvValue( oResponse,"_LINK","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMOEDA             :=  WSAdvValue( oResponse,"_MOEDA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nMORA              :=  WSAdvValue( oResponse,"_MORA","float",NIL,NIL,NIL,"N",NIL,NIL) 
	::cMSG1              :=  WSAdvValue( oResponse,"_MSG1","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG2              :=  WSAdvValue( oResponse,"_MSG2","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG3              :=  WSAdvValue( oResponse,"_MSG3","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG4              :=  WSAdvValue( oResponse,"_MSG4","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG5              :=  WSAdvValue( oResponse,"_MSG5","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG6              :=  WSAdvValue( oResponse,"_MSG6","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG7              :=  WSAdvValue( oResponse,"_MSG7","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG8              :=  WSAdvValue( oResponse,"_MSG8","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG9              :=  WSAdvValue( oResponse,"_MSG9","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nMULTA             :=  WSAdvValue( oResponse,"_MULTA","float",NIL,NIL,NIL,"N",NIL,NIL) 
	::cNATUREZ           :=  WSAdvValue( oResponse,"_NATUREZ","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cNOMEBCO           :=  WSAdvValue( oResponse,"_NOMEBCO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cNUMTIT            :=  WSAdvValue( oResponse,"_NUMTIT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cPREFIXO           :=  WSAdvValue( oResponse,"_PREFIXO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSDBAIRRO          :=  WSAdvValue( oResponse,"_SDBAIRRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSDCEP             :=  WSAdvValue( oResponse,"_SDCEP","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSDCGC             :=  WSAdvValue( oResponse,"_SDCGC","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSDEND             :=  WSAdvValue( oResponse,"_SDEND","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSDENTID2          :=  WSAdvValue( oResponse,"_SDENTID2","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSDENTIDA          :=  WSAdvValue( oResponse,"_SDENTIDA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSDEST             :=  WSAdvValue( oResponse,"_SDEST","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSDMUN             :=  WSAdvValue( oResponse,"_SDMUN","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSDNOME            :=  WSAdvValue( oResponse,"_SDNOME","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cSIND              :=  WSAdvValue( oResponse,"_SIND","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cTIT               :=  WSAdvValue( oResponse,"_TIT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cVALOR             :=  WSAdvValue( oResponse,"_VALOR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dVENCTO            :=  WSAdvValue( oResponse,"_VENCTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
Return

// WSDL Data Structure ARRAYOFSCLCASSI

WSSTRUCT SHBOLETO_ARRAYOFSCLCASSI
	WSDATA   oWSSCLCASSI               AS SHBOLETO_SCLCASSI OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_ARRAYOFSCLCASSI
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_ARRAYOFSCLCASSI
	::oWSSCLCASSI          := {} // Array Of  SHBOLETO_SCLCASSI():New()
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_ARRAYOFSCLCASSI
	Local oClone := SHBOLETO_ARRAYOFSCLCASSI():NEW()
	oClone:oWSSCLCASSI := NIL
	If ::oWSSCLCASSI <> NIL 
		oClone:oWSSCLCASSI := {}
		aEval( ::oWSSCLCASSI , { |x| aadd( oClone:oWSSCLCASSI , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHBOLETO_ARRAYOFSCLCASSI
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_SCLCASSI","SCLCASSI",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSSCLCASSI , SHBOLETO_SCLCASSI():New() )
			::oWSSCLCASSI[len(::oWSSCLCASSI)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure SPEDIDO

WSSTRUCT SHBOLETO_SPEDIDO
	WSDATA   cCLIENTE                  AS string OPTIONAL
	WSDATA   cFILIAL                   AS string OPTIONAL
	WSDATA   cLOJA                     AS string OPTIONAL
	WSDATA   cNATUREZ                  AS string OPTIONAL
	WSDATA   cNUMERO                   AS string OPTIONAL
	WSDATA   cPARCELA                  AS string OPTIONAL
	WSDATA   cPREFIXO                  AS string OPTIONAL
	WSDATA   nVALOR                    AS float OPTIONAL
	WSDATA   dVECNTO                   AS date OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_SPEDIDO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_SPEDIDO
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_SPEDIDO
	Local oClone := SHBOLETO_SPEDIDO():NEW()
	oClone:cCLIENTE             := ::cCLIENTE
	oClone:cFILIAL              := ::cFILIAL
	oClone:cLOJA                := ::cLOJA
	oClone:cNATUREZ             := ::cNATUREZ
	oClone:cNUMERO              := ::cNUMERO
	oClone:cPARCELA             := ::cPARCELA
	oClone:cPREFIXO             := ::cPREFIXO
	oClone:nVALOR               := ::nVALOR
	oClone:dVECNTO              := ::dVECNTO
Return oClone

WSMETHOD SOAPSEND WSCLIENT SHBOLETO_SPEDIDO
	Local cSoap := ""
	cSoap += WSSoapValue("CLIENTE", ::cCLIENTE, ::cCLIENTE , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("FILIAL", ::cFILIAL, ::cFILIAL , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("LOJA", ::cLOJA, ::cLOJA , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NATUREZ", ::cNATUREZ, ::cNATUREZ , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NUMERO", ::cNUMERO, ::cNUMERO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PARCELA", ::cPARCELA, ::cPARCELA , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PREFIXO", ::cPREFIXO, ::cPREFIXO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("VALOR", ::nVALOR, ::nVALOR , "float", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("VECNTO", ::dVECNTO, ::dVECNTO , "date", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure ARRAYOFSCCONF

WSSTRUCT SHBOLETO_ARRAYOFSCCONF
	WSDATA   oWSSCCONF                 AS SHBOLETO_SCCONF OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_ARRAYOFSCCONF
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_ARRAYOFSCCONF
	::oWSSCCONF            := {} // Array Of  SHBOLETO_SCCONF():New()
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_ARRAYOFSCCONF
	Local oClone := SHBOLETO_ARRAYOFSCCONF():NEW()
	oClone:oWSSCCONF := NIL
	If ::oWSSCCONF <> NIL 
		oClone:oWSSCCONF := {}
		aEval( ::oWSSCCONF , { |x| aadd( oClone:oWSSCCONF , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHBOLETO_ARRAYOFSCCONF
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_SCCONF","SCCONF",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSSCCONF , SHBOLETO_SCCONF():New() )
			::oWSSCCONF[len(::oWSSCCONF)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure SBOLETO

WSSTRUCT SHBOLETO_SBOLETO
	WSDATA   cANO                      AS string OPTIONAL
	WSDATA   cBASE                     AS string OPTIONAL
	WSDATA   cCGC                      AS string OPTIONAL
	WSDATA   cE1NUM                    AS string OPTIONAL
	WSDATA   dEMISSAO                  AS date OPTIONAL
	WSDATA   cNATUREZ                  AS string OPTIONAL
	WSDATA   cNUMERO                   AS string OPTIONAL
	WSDATA   cPARCELA                  AS string OPTIONAL
	WSDATA   cSINDIC                   AS string OPTIONAL
	WSDATA   nVALOR                    AS float OPTIONAL
	WSDATA   dVENCTO                   AS date OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_SBOLETO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_SBOLETO
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_SBOLETO
	Local oClone := SHBOLETO_SBOLETO():NEW()
	oClone:cANO                 := ::cANO
	oClone:cBASE                := ::cBASE
	oClone:cCGC                 := ::cCGC
	oClone:cE1NUM               := ::cE1NUM
	oClone:dEMISSAO             := ::dEMISSAO
	oClone:cNATUREZ             := ::cNATUREZ
	oClone:cNUMERO              := ::cNUMERO
	oClone:cPARCELA             := ::cPARCELA
	oClone:cSINDIC              := ::cSINDIC
	oClone:nVALOR               := ::nVALOR
	oClone:dVENCTO              := ::dVENCTO
Return oClone

WSMETHOD SOAPSEND WSCLIENT SHBOLETO_SBOLETO
	Local cSoap := ""
	cSoap += WSSoapValue("ANO", ::cANO, ::cANO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("BASE", ::cBASE, ::cBASE , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CGC", ::cCGC, ::cCGC , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("E1NUM", ::cE1NUM, ::cE1NUM , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("EMISSAO", ::dEMISSAO, ::dEMISSAO , "date", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NATUREZ", ::cNATUREZ, ::cNATUREZ , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NUMERO", ::cNUMERO, ::cNUMERO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("PARCELA", ::cPARCELA, ::cPARCELA , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("SINDIC", ::cSINDIC, ::cSINDIC , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("VALOR", ::nVALOR, ::nVALOR , "float", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("VENCTO", ::dVENCTO, ::dVENCTO , "date", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure SANO

WSSTRUCT SHBOLETO_SANO
	WSDATA   cANO                      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_SANO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_SANO
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_SANO
	Local oClone := SHBOLETO_SANO():NEW()
	oClone:cANO                 := ::cANO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHBOLETO_SANO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cANO               :=  WSAdvValue( oResponse,"_ANO","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure SCASSO

WSSTRUCT SHBOLETO_SCASSO
	WSDATA   cANO                      AS string OPTIONAL
	WSDATA   dDVENORIG                 AS date OPTIONAL
	WSDATA   cFILIAL                   AS string OPTIONAL
	WSDATA   cMES                      AS string OPTIONAL
	WSDATA   cNATUREZ                  AS string OPTIONAL
	WSDATA   cNUMERO                   AS string OPTIONAL
	WSDATA   cPARCELA                  AS string OPTIONAL
	WSDATA   cPREFIXO                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_SCASSO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_SCASSO
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_SCASSO
	Local oClone := SHBOLETO_SCASSO():NEW()
	oClone:cANO                 := ::cANO
	oClone:dDVENORIG            := ::dDVENORIG
	oClone:cFILIAL              := ::cFILIAL
	oClone:cMES                 := ::cMES
	oClone:cNATUREZ             := ::cNATUREZ
	oClone:cNUMERO              := ::cNUMERO
	oClone:cPARCELA             := ::cPARCELA
	oClone:cPREFIXO             := ::cPREFIXO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHBOLETO_SCASSO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cANO               :=  WSAdvValue( oResponse,"_ANO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dDVENORIG          :=  WSAdvValue( oResponse,"_DVENORIG","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cFILIAL            :=  WSAdvValue( oResponse,"_FILIAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMES               :=  WSAdvValue( oResponse,"_MES","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cNATUREZ           :=  WSAdvValue( oResponse,"_NATUREZ","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cNUMERO            :=  WSAdvValue( oResponse,"_NUMERO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cPARCELA           :=  WSAdvValue( oResponse,"_PARCELA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cPREFIXO           :=  WSAdvValue( oResponse,"_PREFIXO","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure SCLCASSI

WSSTRUCT SHBOLETO_SCLCASSI
	WSDATA   cAPLACR                   AS string OPTIONAL
	WSDATA   cCODIGO                   AS string OPTIONAL
	WSDATA   nDESCONT                  AS float OPTIONAL
	WSDATA   dDTPAGTO                  AS date OPTIONAL
	WSDATA   cFILIAL                   AS string OPTIONAL
	WSDATA   nJUROS                    AS float OPTIONAL
	WSDATA   cMESANO                   AS string OPTIONAL
	WSDATA   cMSG1                     AS string OPTIONAL
	WSDATA   cMSG2                     AS string OPTIONAL
	WSDATA   cMSG3                     AS string OPTIONAL
	WSDATA   cMSG4                     AS string OPTIONAL
	WSDATA   cMSG5                     AS string OPTIONAL
	WSDATA   cMSG6                     AS string OPTIONAL
	WSDATA   cMSG7                     AS string OPTIONAL
	WSDATA   nMULTA                    AS float OPTIONAL
	WSDATA   cPARCELA                  AS string OPTIONAL
	WSDATA   lPGTO                     AS boolean OPTIONAL
	WSDATA   dVENCORI                  AS date OPTIONAL
	WSDATA   cVLFOLHA                  AS string OPTIONAL
	WSDATA   nVLMIN                    AS float OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_SCLCASSI
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_SCLCASSI
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_SCLCASSI
	Local oClone := SHBOLETO_SCLCASSI():NEW()
	oClone:cAPLACR              := ::cAPLACR
	oClone:cCODIGO              := ::cCODIGO
	oClone:nDESCONT             := ::nDESCONT
	oClone:dDTPAGTO             := ::dDTPAGTO
	oClone:cFILIAL              := ::cFILIAL
	oClone:nJUROS               := ::nJUROS
	oClone:cMESANO              := ::cMESANO
	oClone:cMSG1                := ::cMSG1
	oClone:cMSG2                := ::cMSG2
	oClone:cMSG3                := ::cMSG3
	oClone:cMSG4                := ::cMSG4
	oClone:cMSG5                := ::cMSG5
	oClone:cMSG6                := ::cMSG6
	oClone:cMSG7                := ::cMSG7
	oClone:nMULTA               := ::nMULTA
	oClone:cPARCELA             := ::cPARCELA
	oClone:lPGTO                := ::lPGTO
	oClone:dVENCORI             := ::dVENCORI
	oClone:cVLFOLHA             := ::cVLFOLHA
	oClone:nVLMIN               := ::nVLMIN
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHBOLETO_SCLCASSI
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cAPLACR            :=  WSAdvValue( oResponse,"_APLACR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCODIGO            :=  WSAdvValue( oResponse,"_CODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nDESCONT           :=  WSAdvValue( oResponse,"_DESCONT","float",NIL,NIL,NIL,"N",NIL,NIL) 
	::dDTPAGTO           :=  WSAdvValue( oResponse,"_DTPAGTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cFILIAL            :=  WSAdvValue( oResponse,"_FILIAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nJUROS             :=  WSAdvValue( oResponse,"_JUROS","float",NIL,NIL,NIL,"N",NIL,NIL) 
	::cMESANO            :=  WSAdvValue( oResponse,"_MESANO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG1              :=  WSAdvValue( oResponse,"_MSG1","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG2              :=  WSAdvValue( oResponse,"_MSG2","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG3              :=  WSAdvValue( oResponse,"_MSG3","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG4              :=  WSAdvValue( oResponse,"_MSG4","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG5              :=  WSAdvValue( oResponse,"_MSG5","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG6              :=  WSAdvValue( oResponse,"_MSG6","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG7              :=  WSAdvValue( oResponse,"_MSG7","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nMULTA             :=  WSAdvValue( oResponse,"_MULTA","float",NIL,NIL,NIL,"N",NIL,NIL) 
	::cPARCELA           :=  WSAdvValue( oResponse,"_PARCELA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::lPGTO              :=  WSAdvValue( oResponse,"_PGTO","boolean",NIL,NIL,NIL,"L",NIL,NIL) 
	::dVENCORI           :=  WSAdvValue( oResponse,"_VENCORI","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cVLFOLHA           :=  WSAdvValue( oResponse,"_VLFOLHA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nVLMIN             :=  WSAdvValue( oResponse,"_VLMIN","float",NIL,NIL,NIL,"N",NIL,NIL) 
Return

// WSDL Data Structure SCCONF

WSSTRUCT SHBOLETO_SCCONF
	WSDATA   cANO                      AS string OPTIONAL
	WSDATA   lAPLACR                   AS boolean OPTIONAL
	WSDATA   cCODIGO                   AS string OPTIONAL
	WSDATA   dDTPAGTO                  AS date OPTIONAL
	WSDATA   cFILIAL                   AS string OPTIONAL
	WSDATA   cITEM                     AS string OPTIONAL
	WSDATA   nJUROMES                  AS float OPTIONAL
	WSDATA   cMESFOLHA                 AS string OPTIONAL
	WSDATA   cMSG1                     AS string OPTIONAL
	WSDATA   cMSG2                     AS string OPTIONAL
	WSDATA   cMSG3                     AS string OPTIONAL
	WSDATA   cMSG4                     AS string OPTIONAL
	WSDATA   cMSG5                     AS string OPTIONAL
	WSDATA   cMSG6                     AS string OPTIONAL
	WSDATA   cMSG7                     AS string OPTIONAL
	WSDATA   nMULTA                    AS float OPTIONAL
	WSDATA   lPAGTO                    AS boolean OPTIONAL
	WSDATA   cPARCELA                  AS string OPTIONAL
	WSDATA   nPORCENT                  AS float OPTIONAL
	WSDATA   cSINDICA                  AS string OPTIONAL
	WSDATA   cTIT                      AS string OPTIONAL
	WSDATA   dVENORIG                  AS date OPTIONAL
	WSDATA   cVLMIN                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHBOLETO_SCCONF
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHBOLETO_SCCONF
Return

WSMETHOD CLONE WSCLIENT SHBOLETO_SCCONF
	Local oClone := SHBOLETO_SCCONF():NEW()
	oClone:cANO                 := ::cANO
	oClone:lAPLACR              := ::lAPLACR
	oClone:cCODIGO              := ::cCODIGO
	oClone:dDTPAGTO             := ::dDTPAGTO
	oClone:cFILIAL              := ::cFILIAL
	oClone:cITEM                := ::cITEM
	oClone:nJUROMES             := ::nJUROMES
	oClone:cMESFOLHA            := ::cMESFOLHA
	oClone:cMSG1                := ::cMSG1
	oClone:cMSG2                := ::cMSG2
	oClone:cMSG3                := ::cMSG3
	oClone:cMSG4                := ::cMSG4
	oClone:cMSG5                := ::cMSG5
	oClone:cMSG6                := ::cMSG6
	oClone:cMSG7                := ::cMSG7
	oClone:nMULTA               := ::nMULTA
	oClone:lPAGTO               := ::lPAGTO
	oClone:cPARCELA             := ::cPARCELA
	oClone:nPORCENT             := ::nPORCENT
	oClone:cSINDICA             := ::cSINDICA
	oClone:cTIT                 := ::cTIT
	oClone:dVENORIG             := ::dVENORIG
	oClone:cVLMIN               := ::cVLMIN
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHBOLETO_SCCONF
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cANO               :=  WSAdvValue( oResponse,"_ANO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::lAPLACR            :=  WSAdvValue( oResponse,"_APLACR","boolean",NIL,NIL,NIL,"L",NIL,NIL) 
	::cCODIGO            :=  WSAdvValue( oResponse,"_CODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dDTPAGTO           :=  WSAdvValue( oResponse,"_DTPAGTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cFILIAL            :=  WSAdvValue( oResponse,"_FILIAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cITEM              :=  WSAdvValue( oResponse,"_ITEM","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nJUROMES           :=  WSAdvValue( oResponse,"_JUROMES","float",NIL,NIL,NIL,"N",NIL,NIL) 
	::cMESFOLHA          :=  WSAdvValue( oResponse,"_MESFOLHA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG1              :=  WSAdvValue( oResponse,"_MSG1","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG2              :=  WSAdvValue( oResponse,"_MSG2","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG3              :=  WSAdvValue( oResponse,"_MSG3","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG4              :=  WSAdvValue( oResponse,"_MSG4","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG5              :=  WSAdvValue( oResponse,"_MSG5","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG6              :=  WSAdvValue( oResponse,"_MSG6","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMSG7              :=  WSAdvValue( oResponse,"_MSG7","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nMULTA             :=  WSAdvValue( oResponse,"_MULTA","float",NIL,NIL,NIL,"N",NIL,NIL) 
	::lPAGTO             :=  WSAdvValue( oResponse,"_PAGTO","boolean",NIL,NIL,NIL,"L",NIL,NIL) 
	::cPARCELA           :=  WSAdvValue( oResponse,"_PARCELA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nPORCENT           :=  WSAdvValue( oResponse,"_PORCENT","float",NIL,NIL,NIL,"N",NIL,NIL) 
	::cSINDICA           :=  WSAdvValue( oResponse,"_SINDICA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cTIT               :=  WSAdvValue( oResponse,"_TIT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dVENORIG           :=  WSAdvValue( oResponse,"_VENORIG","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cVLMIN             :=  WSAdvValue( oResponse,"_VLMIN","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return


