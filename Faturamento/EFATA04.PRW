#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EFATA04   � Autor � Montes / Oficina1         �  04/11/2011 ���
�������������������������������������������������������������������������͹��
���Descricao � Rotina chamada da tela de orcamento para mudanca de Status ���
���          � para Baixa por Recibo                                      ���
�������������������������������������������������������������������������͹��
���Uso       � P10-Ellfas                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function EFATA04()

If SCJ->CJ_STATUS $ "A;" //Somente se tiver em aberto
                         
   If MsgYesNo("Deseja mudar o status para Aprovado RC ?")
      RecLock("SCJ",.F.)
       SCJ->CJ_STATUS := "R"
      MsUnLock()
   EndIf
                
ElseIf SCJ->CJ_STATUS $ "R;" //Somente se tiver com Status de "Aprovado RC"

   If MsgYesNo("Deseja retornar o status para em aberto ?")
      RecLock("SCJ",.F.)
       SCJ->CJ_STATUS := "A"
      MsUnLock()
   EndIf

EndIf

Return Nil