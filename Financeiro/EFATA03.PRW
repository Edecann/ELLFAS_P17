#INCLUDE "rwmake.ch"                                    
#Include "TbiConn.ch"
#INCLUDE "topconn.ch"   

// Ajuste Kurts 11:11 de 25/02/21                             

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EFATA03   º Autor ³ Montes / Oficina1         ³  17/09/2010 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Validação do Preco Minimo na digitação do Pedido de Venda  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ P10-Ellfas                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function EFATA03(cTabela)
Local aArea     := GetArea()
Local lRetorno  := .T.
Local cProduto  := ""                                        
Local nPrcVen   := 0                                         
Local cUPrcMin  := GetNewPar("EL_UPRCMIN","Administrador;Gilberto;")
Local nPrcMin   := 0

If .F. //AllTrim(cUserName) $ Alltrim(cUPrcMin)
   lRetorno := .T.
ElseIf cTabela == "SC6"
   If M->C5_TIPO == "N" //Valida somente quando saida para cliente
      cProduto := aCols[n][ASCAN(aHeader,{|x|x[2]="C6_PRODUTO"})]
      nPrcVen  := M->C6_PRCVEN //aCols[n][ASCAN(aHeader,{|x|x[2]="C6_PRCVEN"})]    
   
      If SB1->B1_FILIAL+SB1->B1_COD <> xFilial("SB1")+cProduto
         SB1->(dbSetOrder(1))
         SB1->(dbSeek(xFilial("SB1")+cProduto))
      EndIf
      
      /*
      nPrcMin   := SB1->B1_XPRCMIN
      If !EMPTY(M->C5_TABELA) //Verifica se possui tabela definida e considera o preço minimo da Tabela - Montes - Oficina1 em 04/12/2012                               
         DA1->(dbSetOrder(1))
         If DA1->(dbSeek(xFilial("DA1")+M->C5_TABELA+cProduto)) .And. DA1->DA1_ATIVO == '1'
            nPrcMin := DA1->DA1_PRCVEN
         EndIf
      EndIf
      */                              
      nPrcMin := aCols[n][ASCAN(aHeader,{|x|x[2]="C6_PRUNIT"})] //Considera o preço minimo da tabela do cliente
                          
      If EMPTY(nPrcMin) .And. !(RetCodUsr() $ GETMV("EL_USPRMIN",,"000000;"))
         MsgStop("Produto sem preço de tabela definido, venda não permitida!")
         lRetorno := .F.
      EndIf

      cBloquei := SPACE(LEN(SC6->C6_BLOQUEI))
      If !EMPTY(nPrcMin) .And. nPrcVen < nPrcMin
         //MsgStop("Preco de Venda inferior ao minimo, venda não permitida!")
         //lRetorno := .F.
         MsgStop("Preco de Venda inferior ao minimo, pedido será bloqueado para posterior liberação pelo Reponsavel!")
         lRetorno := .T.              
         cBloquei := StrZero(1, Len(SC6->C6_BLOQUEI))
   
         GDFIELDPUT("C6_BLOQUEI",cBloquei,n)
         For nX := 1 To Len(aCols)
            GDFIELDPUT("C6_QTDLIB",0,nX)
         Next
      EndIf

   EndIf
EndIf

RestArea(aArea)
                                           
Return lRetorno