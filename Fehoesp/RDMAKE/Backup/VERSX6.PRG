** Compara estrutura SX6 do AP5 x AP6

SELECT 1
USE SX6AP5 ALIAS AP5
INDEX on x6_var to ap51

SELECT 2
USE SX6AP6 ALIAS AP6

SELECT 3
USE SX6010 ALIAS SX6
ZAP

AP6->(DBGOTOP())

Do while ! (AP6->(eof()))


   SX6->(DBAPPEND())

   AP5->(DBSEEK(AP6->x6_var))

   if AP5->(found())

      replace SX6->X6_FIL      with AP5->X6_FIL
      replace SX6->X6_VAR      with AP5->X6_VAR
      replace SX6->X6_TIPO     with AP5->X6_TIPO
      replace SX6->X6_DESCRIC  with AP5->X6_DESCRIC
      replace SX6->X6_DESC1    with AP5->X6_DESC1
      replace SX6->X6_DESC2    with AP5->X6_DESC2
      replace SX6->X6_CONTEUD  with AP5->X6_CONTEUD
      replace SX6->X6_PROPRI   with "S"

   else

      replace SX6->X6_FIL      with AP6->X6_FIL
      replace SX6->X6_VAR      with AP6->X6_VAR
      replace SX6->X6_TIPO     with AP6->X6_TIPO
      replace SX6->X6_DESCRIC  with AP6->X6_DESCRIC
      replace SX6->X6_DESC1    with AP6->X6_DESC1
      replace SX6->X6_DESC2    with AP6->X6_DESC2
      replace SX6->X6_CONTEUD  with AP6->X6_CONTEUD
      replace SX6->X6_PYME     with AP6->X6_PYME
      replace SX6->X6_PROPRI   with AP6->X6_PROPRI

   EndIf

   AP6->(DBSKIP())

EndDo




      



