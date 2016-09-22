#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://192.168.0.2:8502/ws/SHEXTRATO.apw?WSDL
Gerado em        06/22/15 16:37:32
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _SKNEHIL ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSSHEXTRATO
------------------------------------------------------------------------------- */

WSCLIENT WSSHEXTRATO

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD LSTABT
	WSMETHOD LSTPAG

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   oWSAEMPRESA               AS SHEXTRATO__EMPRESA
	WSDATA   lLSIND                    AS boolean
	WSDATA   lLCONFNEG                 AS boolean
	WSDATA   lLASSOC                   AS boolean
	WSDATA   cCCONFNEG                 AS string
	WSDATA   oWSLSTABTRESULT           AS SHEXTRATO_ARRAYOFSTITABT
	WSDATA   oWSLSTPAGRESULT           AS SHEXTRATO_ARRAYOFSTITPAG

	// Estruturas mantidas por compatibilidade - NÃO USAR
	WSDATA   oWS_EMPRESA               AS SHEXTRATO__EMPRESA

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSSHEXTRATO
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20141125] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSSHEXTRATO
	::oWSAEMPRESA        := SHEXTRATO__EMPRESA():New()
	::oWSLSTABTRESULT    := SHEXTRATO_ARRAYOFSTITABT():New()
	::oWSLSTPAGRESULT    := SHEXTRATO_ARRAYOFSTITPAG():New()

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWS_EMPRESA        := ::oWSAEMPRESA
Return

WSMETHOD RESET WSCLIENT WSSHEXTRATO
	::oWSAEMPRESA        := NIL 
	::lLSIND             := NIL 
	::lLCONFNEG          := NIL 
	::lLASSOC            := NIL 
	::cCCONFNEG          := NIL 
	::oWSLSTABTRESULT    := NIL 
	::oWSLSTPAGRESULT    := NIL 

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWS_EMPRESA        := NIL
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSSHEXTRATO
Local oClone := WSSHEXTRATO():New()
	oClone:_URL          := ::_URL 
	oClone:oWSAEMPRESA   :=  IIF(::oWSAEMPRESA = NIL , NIL ,::oWSAEMPRESA:Clone() )
	oClone:lLSIND        := ::lLSIND
	oClone:lLCONFNEG     := ::lLCONFNEG
	oClone:lLASSOC       := ::lLASSOC
	oClone:cCCONFNEG     := ::cCCONFNEG
	oClone:oWSLSTABTRESULT :=  IIF(::oWSLSTABTRESULT = NIL , NIL ,::oWSLSTABTRESULT:Clone() )
	oClone:oWSLSTPAGRESULT :=  IIF(::oWSLSTPAGRESULT = NIL , NIL ,::oWSLSTPAGRESULT:Clone() )

	// Estruturas mantidas por compatibilidade - NÃO USAR
	oClone:oWS_EMPRESA   := oClone:oWSAEMPRESA
Return oClone

// WSDL Method LSTABT of Service WSSHEXTRATO

WSMETHOD LSTABT WSSEND oWSAEMPRESA,lLSIND,lLCONFNEG,lLASSOC,cCCONFNEG WSRECEIVE oWSLSTABTRESULT WSCLIENT WSSHEXTRATO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<LSTABT xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("AEMPRESA", ::oWSAEMPRESA, oWSAEMPRESA , "_EMPRESA", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("LSIND", ::lLSIND, lLSIND , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("LCONFNEG", ::lLCONFNEG, lLCONFNEG , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("LASSOC", ::lLASSOC, lLASSOC , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("CCONFNEG", ::cCCONFNEG, cCCONFNEG , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</LSTABT>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/LSTABT",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHEXTRATO.apw")

::Init()
::oWSLSTABTRESULT:SoapRecv( WSAdvValue( oXmlRet,"_LSTABTRESPONSE:_LSTABTRESULT","ARRAYOFSTITABT",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method LSTPAG of Service WSSHEXTRATO

WSMETHOD LSTPAG WSSEND oWSAEMPRESA,lLSIND,lLCONFNEG,lLASSOC WSRECEIVE oWSLSTPAGRESULT WSCLIENT WSSHEXTRATO
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<LSTPAG xmlns="http://192.168.0.2:8502/">'
cSoap += WSSoapValue("AEMPRESA", ::oWSAEMPRESA, oWSAEMPRESA , "_EMPRESA", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("LSIND", ::lLSIND, lLSIND , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("LCONFNEG", ::lLCONFNEG, lLCONFNEG , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("LASSOC", ::lLASSOC, lLASSOC , "boolean", .T. , .F., 0 , NIL, .F.) 
cSoap += "</LSTPAG>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://192.168.0.2:8502/LSTPAG",; 
	"DOCUMENT","http://192.168.0.2:8502/",,"1.031217",; 
	"http://192.168.0.2:8502/ws/SHEXTRATO.apw")

::Init()
::oWSLSTPAGRESULT:SoapRecv( WSAdvValue( oXmlRet,"_LSTPAGRESPONSE:_LSTPAGRESULT","ARRAYOFSTITPAG",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure _EMPRESA

WSSTRUCT SHEXTRATO__EMPRESA
	WSDATA   cCBASE                    AS string OPTIONAL
	WSDATA   cCCAPCENT                 AS string OPTIONAL
	WSDATA   cCCGC                     AS string OPTIONAL
	WSDATA   cCCODIGO                  AS string OPTIONAL
	WSDATA   cCFILANTR                 AS string OPTIONAL
	WSDATA   cCFILIAL                  AS string OPTIONAL
	WSDATA   cCFOLCENT                 AS string OPTIONAL
	WSDATA   cCLOJA                    AS string OPTIONAL
	WSDATA   cCNATUREZ                 AS string OPTIONAL
	WSDATA   dDDTNASC                  AS date OPTIONAL
	WSDATA   dDINIATV                  AS date OPTIONAL
	WSDATA   cINISIND                  AS string OPTIONAL
	WSDATA   nNCATEGOR                 AS integer OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHEXTRATO__EMPRESA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHEXTRATO__EMPRESA
Return

WSMETHOD CLONE WSCLIENT SHEXTRATO__EMPRESA
	Local oClone := SHEXTRATO__EMPRESA():NEW()
	oClone:cCBASE               := ::cCBASE
	oClone:cCCAPCENT            := ::cCCAPCENT
	oClone:cCCGC                := ::cCCGC
	oClone:cCCODIGO             := ::cCCODIGO
	oClone:cCFILANTR            := ::cCFILANTR
	oClone:cCFILIAL             := ::cCFILIAL
	oClone:cCFOLCENT            := ::cCFOLCENT
	oClone:cCLOJA               := ::cCLOJA
	oClone:cCNATUREZ            := ::cCNATUREZ
	oClone:dDDTNASC             := ::dDDTNASC
	oClone:dDINIATV             := ::dDINIATV
	oClone:cINISIND             := ::cINISIND
	oClone:nNCATEGOR            := ::nNCATEGOR
Return oClone

WSMETHOD SOAPSEND WSCLIENT SHEXTRATO__EMPRESA
	Local cSoap := ""
	cSoap += WSSoapValue("CBASE", ::cCBASE, ::cCBASE , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCAPCENT", ::cCCAPCENT, ::cCCAPCENT , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCGC", ::cCCGC, ::cCCGC , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CCODIGO", ::cCCODIGO, ::cCCODIGO , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CFILANTR", ::cCFILANTR, ::cCFILANTR , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CFILIAL", ::cCFILIAL, ::cCFILIAL , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CFOLCENT", ::cCFOLCENT, ::cCFOLCENT , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CLOJA", ::cCLOJA, ::cCLOJA , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("CNATUREZ", ::cCNATUREZ, ::cCNATUREZ , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DDTNASC", ::dDDTNASC, ::dDDTNASC , "date", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("DINIATV", ::dDINIATV, ::dDINIATV , "date", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("INISIND", ::cINISIND, ::cINISIND , "string", .F. , .F., 0 , NIL, .F.) 
	cSoap += WSSoapValue("NCATEGOR", ::nNCATEGOR, ::nNCATEGOR , "integer", .F. , .F., 0 , NIL, .F.) 
Return cSoap

// WSDL Data Structure ARRAYOFSTITABT

WSSTRUCT SHEXTRATO_ARRAYOFSTITABT
	WSDATA   oWSSTITABT                AS SHEXTRATO_STITABT OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHEXTRATO_ARRAYOFSTITABT
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHEXTRATO_ARRAYOFSTITABT
	::oWSSTITABT           := {} // Array Of  SHEXTRATO_STITABT():New()
Return

WSMETHOD CLONE WSCLIENT SHEXTRATO_ARRAYOFSTITABT
	Local oClone := SHEXTRATO_ARRAYOFSTITABT():NEW()
	oClone:oWSSTITABT := NIL
	If ::oWSSTITABT <> NIL 
		oClone:oWSSTITABT := {}
		aEval( ::oWSSTITABT , { |x| aadd( oClone:oWSSTITABT , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHEXTRATO_ARRAYOFSTITABT
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_STITABT","STITABT",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSSTITABT , SHEXTRATO_STITABT():New() )
			::oWSSTITABT[len(::oWSSTITABT)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ARRAYOFSTITPAG

WSSTRUCT SHEXTRATO_ARRAYOFSTITPAG
	WSDATA   oWSSTITPAG                AS SHEXTRATO_STITPAG OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHEXTRATO_ARRAYOFSTITPAG
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHEXTRATO_ARRAYOFSTITPAG
	::oWSSTITPAG           := {} // Array Of  SHEXTRATO_STITPAG():New()
Return

WSMETHOD CLONE WSCLIENT SHEXTRATO_ARRAYOFSTITPAG
	Local oClone := SHEXTRATO_ARRAYOFSTITPAG():NEW()
	oClone:oWSSTITPAG := NIL
	If ::oWSSTITPAG <> NIL 
		oClone:oWSSTITPAG := {}
		aEval( ::oWSSTITPAG , { |x| aadd( oClone:oWSSTITPAG , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHEXTRATO_ARRAYOFSTITPAG
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_STITPAG","STITPAG",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSSTITPAG , SHEXTRATO_STITPAG():New() )
			::oWSSTITPAG[len(::oWSSTITPAG)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure STITABT

WSSTRUCT SHEXTRATO_STITABT
	WSDATA   cCANO                     AS string OPTIONAL
	WSDATA   cCCHAVE                   AS string OPTIONAL
	WSDATA   cCMES                     AS string OPTIONAL
	WSDATA   cCNAT                     AS string OPTIONAL
	WSDATA   cCPARCELA                 AS string OPTIONAL
	WSDATA   cCTIPO                    AS string OPTIONAL
	WSDATA   dDPAGTO                   AS date OPTIONAL
	WSDATA   dDVENCTO                  AS date OPTIONAL
	WSDATA   cNVALOR                   AS string OPTIONAL
	WSDATA   cOPCOES                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHEXTRATO_STITABT
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHEXTRATO_STITABT
Return

WSMETHOD CLONE WSCLIENT SHEXTRATO_STITABT
	Local oClone := SHEXTRATO_STITABT():NEW()
	oClone:cCANO                := ::cCANO
	oClone:cCCHAVE              := ::cCCHAVE
	oClone:cCMES                := ::cCMES
	oClone:cCNAT                := ::cCNAT
	oClone:cCPARCELA            := ::cCPARCELA
	oClone:cCTIPO               := ::cCTIPO
	oClone:dDPAGTO              := ::dDPAGTO
	oClone:dDVENCTO             := ::dDVENCTO
	oClone:cNVALOR              := ::cNVALOR
	oClone:cOPCOES              := ::cOPCOES
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHEXTRATO_STITABT
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCANO              :=  WSAdvValue( oResponse,"_CANO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCCHAVE            :=  WSAdvValue( oResponse,"_CCHAVE","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCMES              :=  WSAdvValue( oResponse,"_CMES","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNAT              :=  WSAdvValue( oResponse,"_CNAT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCPARCELA          :=  WSAdvValue( oResponse,"_CPARCELA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCTIPO             :=  WSAdvValue( oResponse,"_CTIPO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dDPAGTO            :=  WSAdvValue( oResponse,"_DPAGTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDVENCTO           :=  WSAdvValue( oResponse,"_DVENCTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cNVALOR            :=  WSAdvValue( oResponse,"_NVALOR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cOPCOES            :=  WSAdvValue( oResponse,"_OPCOES","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure STITPAG

WSSTRUCT SHEXTRATO_STITPAG
	WSDATA   cCANO                     AS string OPTIONAL
	WSDATA   cCMES                     AS string OPTIONAL
	WSDATA   cCNAT                     AS string OPTIONAL
	WSDATA   cCPARCELA                 AS string OPTIONAL
	WSDATA   cCTIPO                    AS string OPTIONAL
	WSDATA   dDPAGTO                   AS date OPTIONAL
	WSDATA   dDVENCTO                  AS date OPTIONAL
	WSDATA   cNVALOR                   AS string OPTIONAL
	WSDATA   cNVLPAGTO                 AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT SHEXTRATO_STITPAG
	::Init()
Return Self

WSMETHOD INIT WSCLIENT SHEXTRATO_STITPAG
Return

WSMETHOD CLONE WSCLIENT SHEXTRATO_STITPAG
	Local oClone := SHEXTRATO_STITPAG():NEW()
	oClone:cCANO                := ::cCANO
	oClone:cCMES                := ::cCMES
	oClone:cCNAT                := ::cCNAT
	oClone:cCPARCELA            := ::cCPARCELA
	oClone:cCTIPO               := ::cCTIPO
	oClone:dDPAGTO              := ::dDPAGTO
	oClone:dDVENCTO             := ::dDVENCTO
	oClone:cNVALOR              := ::cNVALOR
	oClone:cNVLPAGTO            := ::cNVLPAGTO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT SHEXTRATO_STITPAG
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCANO              :=  WSAdvValue( oResponse,"_CANO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCMES              :=  WSAdvValue( oResponse,"_CMES","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNAT              :=  WSAdvValue( oResponse,"_CNAT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCPARCELA          :=  WSAdvValue( oResponse,"_CPARCELA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCTIPO             :=  WSAdvValue( oResponse,"_CTIPO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dDPAGTO            :=  WSAdvValue( oResponse,"_DPAGTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDVENCTO           :=  WSAdvValue( oResponse,"_DVENCTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cNVALOR            :=  WSAdvValue( oResponse,"_NVALOR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cNVLPAGTO          :=  WSAdvValue( oResponse,"_NVLPAGTO","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return


