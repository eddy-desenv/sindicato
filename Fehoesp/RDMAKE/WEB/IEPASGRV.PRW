#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH" 
#include "TbiConn.ch" 
#include "TbiCode.ch" 
#INCLUDE "TOTVS.CH" 
#INCLUDE "PROTHEUS.CH" 
#INCLUDE "FONT.CH"  
#INCLUDE "FILEIO.CH" 
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"

USER FUNCTION IEPASGRV(zCGC,zXRETORNO,zXNUMTITASSO,zXNUMTITCONF)
   PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"
   		dbselectaREA("SZX")
		RECLOCK("SZX",.T.)
		SZX->ZX_FILIAL:= XFILIAL("szx")
		szx->zx_datA  := date()
		szx->zx_hora  := time()
		szx->zx_cgc   := zCGC
		szx->zx_status:= zxretorno
		szx->zx_assoc := zxnumtitasso
		szx->zx_conf  := zxnumtitconf
		msunlock()			      
RETURN
