#include 'rwmake.ch'

User Function Wiepas(__aCookies,__aPostParms,__nProcID,__aProcParms,__cHTTPPage)
 cHTML := ''
i := 0

// Coloca uma mensagem em HTML
//cHTML += '<p><h1 align='center'>Hello World!!!</h1></p>'
                              
// Coloca um separador de linha em HTML
cHTML += '<hr>'
        
If Len(__aProcParms) = 0
  cHTML += '<p>Nenhum par�metro informado na linha de URL.'
Else
  For i := 1 To Len(__aProcParms)	

    cHTML += '<p>Par�metro: ' + __aProcParms[i,1] + '    -      Valor: ' +    __aProcParms[i,2] + '</p>'

  Next i
Endif

Return(cHTML)
