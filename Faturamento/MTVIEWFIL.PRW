#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ MTVIEWFIL บ Autor ณ Montes / Wikitec         ณ  14/08/2019 บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ PE no Consulta de estoque padrแo via <F4>                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ellfas                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function MTVIEWFIL() 
                                                                         
Local lNaoMostra := .F.
Local cVendedor  := Posicione("SA3",7,xFilial("SA3")+RetCodUsr(),"A3_COD") 
Local cProduto   := PARAMIXB[1]
Local cLocal     := PARAMIXB[2]

If !EMPTY(cVendedor) .AND. RetCodUsr() <> "000000" //Nใo aplicar filtro para Administrador
	If cLocal <> SB1->B1_LOCPAD //Nใo apresenta estoque de outros armazens - somente armazen padrใo
	   lNaoMostra := .T.
	EndIf
EndIf

Return lNaoMostra