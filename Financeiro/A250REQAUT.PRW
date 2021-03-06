#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A250REQAUT�Autor  �Montes              � Data �  01/08/2019 ���
�������������������������������������������������������������������������͹��
���Desc.     � PE para manipular parametro MV_REQAUT                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Ellfas                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
User Function A250REQAUT()

	//��������������������������������������������������������������Ŀ
	//� Declaracao de variaveis                                      �
	//����������������������������������������������������������������
	Local aArea     := GetArea()
	Local cReqAut   := PARAMIXB[1]

	//Tratamento para n�o requisitar itens automaticamente na entrada de nota fiscal de beneficiamento - esta gerando duplicidade - Montes - 01/08/2019
	If IsInCallStack("MATA103") .And. cReqAut == "A"

		//A -> Gera automatico, D -> Digita requisicoes.  
		cReqAut := "D"
		
	EndIf

	RestArea(aArea)

Return cReqAut