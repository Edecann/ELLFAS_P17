#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � MTVIEWFIL � Autor � Montes / Wikitec         �  14/08/2019 ���
�������������������������������������������������������������������������͹��
���Descricao � PE no Consulta de estoque padr�o via <F4>                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Ellfas                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function MTVIEWFIL() 
                                                                         
Local lNaoMostra := .F.
Local cVendedor  := Posicione("SA3",7,xFilial("SA3")+RetCodUsr(),"A3_COD") 
Local cProduto   := PARAMIXB[1]
Local cLocal     := PARAMIXB[2]

If !EMPTY(cVendedor) .AND. RetCodUsr() <> "000000" //N�o aplicar filtro para Administrador
	If cLocal <> SB1->B1_LOCPAD //N�o apresenta estoque de outros armazens - somente armazen padr�o
	   lNaoMostra := .T.
	EndIf
EndIf

Return lNaoMostra