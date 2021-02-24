#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

#DEFINE cCRLF CHR(13)+CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RFATR08  º Autor ³ Montes - Oficina1         ³  15/05/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rel.Pedidos Pendentes x Estoque                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ellfas                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function RFATR08()

Local oReport

AjustaSX1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport	:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Montes                ³ Data ³15/05/2017³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport,oSection1,oSection2
Local cReport := "RFATR08"
Local cTitulo := OemToAnsi("Relatorio de Pedidos Pendentes x Estoque.")
Local cDescri := OemToAnsi("Emite o Relatorio de Pedidos Pendentes x Estoque.")
Local cPerg   := PADR("FATR08",LEN(SX1->X1_GRUPO))

AjustaSX1()
Pergunte( cPerg , .F. )

oReport  := TReport():New( cReport, cTitulo, cPerg , { |oReport| ReportPrint( oReport, "QRYTMP" ) }, cDescri )
oReport:SetLandScape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport,"Pedidos" , {"QRYTMP"},{"Pedidos Pendentes"},/*Campos do SX3*/,/*Campos do SIX*/)                      
             
             
TRCell():New( oSection1, "EMPRESA"   ,"QRYTMP" ,"Empresa" /*X3Titulo*/          ,/*Picture*/                            ,20                       ,/*lPixel*/,) 
TRCell():New( oSection1, "C6_NUM" 	 ,"QRYTMP" ,"Pedido" /*X3Titulo*/           ,/*Picture*/                            ,TamSx3("C6_NUM")[1]+2    ,/*lPixel*/,) 
TRCell():New( oSection1, "C5_CLIENTE","QRYTMP" ,"Cliente" /*X3Titulo*/          ,/*Picture*/                            ,TamSx3("C5_CLIENTE")[1]+2,/*lPixel*/,) 
TRCell():New( oSection1, "C5_LOJACLI","QRYTMP" ,"Loja" /*X3Titulo*/             ,/*Picture*/                            ,TamSx3("C5_LOJACLI")[1]+2,/*lPixel*/,) 
TRCell():New( oSection1, "A1_NOME"   ,"QRYTMP" ,"Nome" /*X3Titulo*/             ,/*Picture*/                            ,TamSx3("A1_NOME")[1]     ,/*lPixel*/,) 
TRCell():New( oSection1, "C5_EMISSAO","QRYTMP" ,"Emissão" /*X3Titulo*/          ,/*Picture*/                            ,TamSx3("C5_EMISSAO")[1]  ,/*lPixel*/,{||STOD(QRYTMP->C5_EMISSAO)}) 
TRCell():New( oSection1, "C5_TRANSP" ,"QRYTMP" ,"Transportadora" /*X3Titulo*/   ,/*Picture*/                            ,TamSx3("C5_TRANSP")[1]+2 ,/*lPixel*/,) 
TRCell():New( oSection1, "C5_VEND1"  ,"QRYTMP" ,"Vendedor (ES)" /*X3Titulo*/    ,/*Picture*/                            ,TamSx3("C5_VEND1")[1]+2  ,/*lPixel*/,) 
TRCell():New( oSection1, "E4_DESCRI" ,"QRYTMP" ,"Cond.Pgto" /*X3Titulo*/        ,/*Picture*/                            ,TamSx3("E4_DESCRI")[1]+2,/*lPixel*/,) 
TRCell():New( oSection1, "C6_ITEM"   ,"QRYTMP" ,"IT" /*X3Titulo*/               ,/*Picture*/                            ,TamSx3("C6_ITEM")[1]+2   ,/*lPixel*/,) 
TRCell():New( oSection1, "C6_PRODUTO","QRYTMP" ,"Produto" /*X3Titulo*/          ,/*Picture*/                            ,TamSx3("C6_PRODUTO")[1]+2,/*lPixel*/,) 
TRCell():New( oSection1, "B1_DESC"   ,"QRYTMP" ,"Descrição" /*X3Titulo*/        ,/*Picture*/                            ,TamSx3("B1_DESC")[1]     ,/*lPixel*/,) 
TRCell():New( oSection1, "C6_QTDVEN" ,"QRYTMP" ,"Vendido" /*X3Titulo*/          ,PesqPict("SC6","C6_QTDVEN")/*Picture*/ ,TamSx3("C6_QTDVEN")[1]   ,/*lPixel*/,) 
TRCell():New( oSection1, "B1_PESO"   ,"QRYTMP" ,"Peso" /*X3Titulo*/             ,PesqPict("SB1","B1_PESO")/*Picture*/   ,TamSx3("B1_PESO")[1]   ,/*lPixel*/,) 
TRCell():New( oSection1, "SALDO"     ,"QRYTMP" ,"Saldo" /*X3Titulo*/            ,PesqPict("SC6","C6_QTDVEN")/*Picture*/ ,TamSx3("C6_QTDVEN")[1]   ,/*lPixel*/,) 
TRCell():New( oSection1, "VALOR"     ,"QRYTMP" ,"Valor" /*X3Titulo*/            ,PesqPict("SC6","C6_VALOR")/*Picture*/  ,TamSx3("C6_VALOR")[1]   ,/*lPixel*/,) 
TRCell():New( oSection1, "TOTAL"     ,"QRYTMP" ,"Total" /*X3Titulo*/            ,PesqPict("SC6","C6_QTDVEN")/*Picture*/ ,TamSx3("C6_QTDVEN")[1]   ,/*lPixel*/,) 
TRCell():New( oSection1, "MIL_X_CX"  ,"QRYTMP" ,"Mil X CX" /*X3Titulo*/         ,PesqPict("SB1","B1_CONV")/*Picture*/   ,TamSx3("B1_CONV")[1]+2   ,/*lPixel*/,) 
TRCell():New( oSection1, "CX"        ,"QRYTMP" ,"CX" /*X3Titulo*/               ,PesqPict("SC6","C6_UNSVEN")/*Picture*/ ,TamSx3("C6_UNSVEN")[1]   ,/*lPixel*/,) 
TRCell():New( oSection1, "ESTOQUE"   ,"QRYTMP" ,"Estoque" /*X3Titulo*/          ,PesqPict("SB2","B2_QATU")/*Picture*/   ,TamSx3("B2_QATU")[1]     ,/*lPixel*/,) 
TRCell():New( oSection1, "PRODUCAO"  ,"QRYTMP" ,"Produção" /*X3Titulo*/         ,PesqPict("SB2","B2_SALPEDI")/*Picture*/,TamSx3("B2_SALPEDI")[1]  ,/*lPixel*/,) 
//TRCell():New( oSection1, "LAMINADO"  ,"QRYTMP" ,"Laminado" /*X3Titulo*/         ,PesqPict("SB2","B2_QATU")/*Picture*/   ,TamSx3("B2_QATU")[1]     ,/*lPixel*/,) 
//TRCell():New( oSection1, "LISO"      ,"QRYTMP" ,"Liso" /*X3Titulo*/             ,PesqPict("SB2","B2_QATU")/*Picture*/   ,TamSx3("B2_QATU")[1]     ,/*lPixel*/,) 
TRCell():New( oSection1, "FATURADA"  ,"QRYTMP" ,"Faturada" /*X3Titulo*/         ,PesqPict("SC6","C6_QTDENT")/*Picture*/ ,TamSx3("C6_QTDENT")[1]   ,/*lPixel*/,) 
TRCell():New( oSection1, "MEDIDA"    ,"QRYTMP" ,"Medida" /*X3Titulo*/           ,PesqPict("SB1","B1_XMEDIDA")/*Picture*/,TamSx3("B1_XMEDIDA")[1]  ,/*lPixel*/,) 
TRCell():New( oSection1, "C6_ENTREG" ,"QRYTMP" ,"Entrega" /*X3Titulo*/          ,PesqPict("SC6","C6_ENTREG")/*Picture*/ ,TamSx3("C6_ENTREG")[1]   ,/*lPixel*/,{||STOD(QRYTMP->C6_ENTREG)}) 
TRCell():New( oSection1, "C6_XOBSPED","QRYTMP" ,"Obs.Pedido" /*X3Titulo*/       ,PesqPict("SC6","C6_XOBSPED")/*Picture*/ ,TamSx3("C6_XOBSPED")[1]   ,/*lPixel*/,)

TRCell():New( oSection1, "A1_PRIOR"  ,"QRYTMP" ,"Prioridade" /*X3Titulo*/      ,PesqPict("SA1","A1_PRIOR")/*Picture*/  ,TamSx3("A1_PRIOR")[1]    ,/*lPixel*/,) 

TRCell():New( oSection1, "B1_ALTER"  ,"QRYTMP" ,"Alternativo" /*X3Titulo*/     ,/*Picture*/                            ,TamSx3("B1_ALTER")[1]+2  ,/*lPixel*/,) 
TRCell():New( oSection1, "B1_DESCALT","QRYTMP" ,"Descrição PA Alt" /*X3Titulo*/,/*Picture*/                            ,TamSx3("B1_DESC")[1]     ,/*lPixel*/,) 
TRCell():New( oSection1, "ESTOQUEALT","QRYTMP" ,"Estoque PA Alt" /*X3Titulo*/  ,PesqPict("SB2","B2_QATU")/*Picture*/   ,TamSx3("B2_QATU")[1]     ,/*lPixel*/,)
        
TRCell():New( oSection1, "G1_COMPLAM","QRYTMP" ,"PI Laminado" /*X3Titulo*/     ,/*Picture*/                            ,TamSx3("B1_ALTER")[1]+2  ,/*lPixel*/,) 
TRCell():New( oSection1, "B1_DESCLAM","QRYTMP" ,"Descrição PI Lam" /*X3Titulo*/,/*Picture*/                            ,TamSx3("B1_DESC")[1]     ,/*lPixel*/,) 
TRCell():New( oSection1, "ESTOQUELAM","QRYTMP" ,"Estoque PI Lam" /*X3Titulo*/  ,PesqPict("SB2","B2_QATU")/*Picture*/   ,TamSx3("B2_QATU")[1]     ,/*lPixel*/,)

TRCell():New( oSection1, "G1_COMPEST","QRYTMP" ,"LI Estampado" /*X3Titulo*/    ,/*Picture*/                            ,TamSx3("B1_ALTER")[1]+2  ,/*lPixel*/,) 
TRCell():New( oSection1, "B1_DESCEST","QRYTMP" ,"Descrição PI Est" /*X3Titulo*/,/*Picture*/                            ,TamSx3("B1_DESC")[1]     ,/*lPixel*/,) 
TRCell():New( oSection1, "ESTOQUEEST","QRYTMP" ,"Estoque PI Est" /*X3Titulo*/  ,PesqPict("SB2","B2_QATU")/*Picture*/   ,TamSx3("B2_QATU")[1]     ,/*lPixel*/,)

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportPrint ³ Autor ³ Montes - Oficina1  ³ Data ³ 15.05.17 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Pedidos Pendentes                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ReportPrint( oReport )                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport - Objeto do Relatorio                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
Local oSection1 := oReport:Section(1)

Local aCompLan, aCompEst
Local nEstAtu := nEstAlt := nSalPedi := 0

Private nEmpresa	:= 0
Private aEmpresas	:= {}                             
Private aTabSB2     := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo := OemToAnsi("Relatorio de Pedidos Pendentes x Estoque.")

If Empty(MV_PAR07)
   aEmpresas := { "01","02","03" }
Else
   aEmpresas := Separa(AllTrim(MV_PAR07), ",", .F.)
EndIf           

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa query para retornar os dados solicitados             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery := "SELECT * FROM "+cCRLF

cQuery += "( "+cCRLF

For nEmpresa := 1 to Len(aEmpresas)

    If nEmpresa > 1
       cQuery += " UNION ALL "+cCRLF
    EndIf

	cQuery += "SELECT '" + aEmpresas[nEmpresa] + "' CCODEMP, '" + FWEmpName(aEmpresas[nEmpresa]) + "' EMPRESA, C6_NUM, C5_CLIENTE, C5_LOJACLI, A1_NOME, C5_EMISSAO, C5_TRANSP, C5_VEND1, E4_DESCRI, C6_ITEM, C6_PRODUTO, B1_DESC, C6_LOCAL, C6_QTDVEN, B1_PESO, ROUND((C6_QTDVEN-C6_QTDENT)*B1_PESO,2) TOTAL ,(CASE WHEN C6_SEGUM = 'CX' THEN B1_CONV ELSE 0 END) 'MIL_X_CX', (CASE WHEN C6_SEGUM = 'CX' THEN (C6_UNSVEN-C6_QTDENT2) ELSE 0 END)'CX', B2_QATU 'ESTOQUE', B2_SALPEDI 'PRODUCAO', 0 'LAMINADO', 0 'LISO', C6_QTDENT 'FATURADA', (C6_QTDVEN-C6_QTDENT) 'SALDO', B1_XMEDIDA 'MEDIDA', C6_ENTREG, C6_XOBSPED, A1_PRIOR, B1_ALTER, C6_VALOR VALOR "+cCRLF
	cQuery += "FROM " + U_RetMySqlTab("SC6", AllTrim(aEmpresas[nEmpresa]), .T.)[1] + cCRLF
	cQuery += "INNER JOIN " + U_RetMySqlTab("SC5", AllTrim(aEmpresas[nEmpresa]), .T.)[1] + " ON C5_FILIAL = C6_FILIAL AND C5_NUM = C6_NUM AND SC5.D_E_L_E_T_ = ' ' "+cCRLF
	cQuery += "INNER JOIN " + U_RetMySqlTab("SA1", AllTrim(aEmpresas[nEmpresa]), .T.)[1] + " ON A1_FILIAL = '  ' AND A1_COD = C5_CLIENTE AND A1_LOJA = C5_LOJACLI AND SA1.D_E_L_E_T_ = ' ' "+cCRLF
	cQuery += "INNER JOIN " + U_RetMySqlTab("SB1", AllTrim(aEmpresas[nEmpresa]), .T.)[1] + " ON B1_FILIAL = '  ' AND B1_COD = C6_PRODUTO AND SB1.D_E_L_E_T_ = ' ' "+cCRLF
	cQuery += "INNER JOIN " + U_RetMySqlTab("SB2", AllTrim(aEmpresas[nEmpresa]), .T.)[1] + " ON B2_FILIAL = '01' AND B2_COD = C6_PRODUTO AND B2_LOCAL = C6_LOCAL AND SB2.D_E_L_E_T_ = ' ' "+cCRLF
	cQuery += "INNER JOIN " + U_RetMySqlTab("SE4", AllTrim(aEmpresas[nEmpresa]), .T.)[1] + " ON E4_FILIAL = '  ' AND E4_CODIGO = C5_CONDPAG AND SE4.D_E_L_E_T_ = ' ' "+cCRLF
	cQuery += "WHERE SC6.D_E_L_E_T_ = ' ' "+cCRLF
	cQuery += "AND SC6.C6_QTDVEN > SC6.C6_QTDENT "+cCRLF
	cQuery += "AND SC6.C6_BLQ <> 'R' "+cCRLF
	cQuery += "AND SC5.C5_TIPO = 'N' "+cCRLF
	cQuery += "AND C6_ENTREG BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "+cCRLF
	cQuery += "AND C6_PRODUTO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+cCRLF
	cQuery += "AND B1_TIPO BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+cCRLF

    AADD(aTabSB2,U_RetMySqlTab("SB2", aEmpresas[nEmpresa], .T.)[1])

Next nEmpresa
cQuery += ") QRYTMP "+cCRLF
cQuery += "ORDER BY C6_PRODUTO,C6_LOCAL,C6_NUM "+cCRLF
            
TcQuery cQuery New Alias 'QRYTMP'                      

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia rotina de impressao                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QRYTMP")
dbGoTop()

oSection1:SetTotalInLine(.T.)
oReport:SetTotalInLine(.F.)

oReport:SetTitle(titulo)
oReport:SetMeter(RecCount())

dbSelectArea("QRYTMP")
dbGoTop()

oSection1:Init()

While !QRYTMP->(EOF())

   nEstAtu  := SldAglut(QRYTMP->C6_PRODUTO,QRYTMP->C6_LOCAL,"B2_QATU") //QRYTMP->B2_QATU
   oSection1:Cell("ESTOQUE"):SetBlock( {|| nEstAtu } )
   
   nSalPedi := SldAglut(QRYTMP->C6_PRODUTO,QRYTMP->C6_LOCAL,"B2_SALPEDI") //QRYTMP->B2_SALPEDI
   oSection1:Cell("PRODUCAO"):SetBlock( {|| nSalPedi } )

   cB1ALTER := IIF(EMPTY(QRYTMP->B1_ALTER),QRYTMP->C6_PRODUTO,QRYTMP->B1_ALTER)
   nEstAlt  := SldAglut(cB1ALTER,QRYTMP->C6_LOCAL,"B2_QTSEGUM") //POSICIONE("SB2",1,xFilial("SB2")+cB1ALTER+QRYTMP->C6_LOCAL,"B2_QTSEGUM")
   
   oSection1:Cell("B1_ALTER"):SetBlock( {|| cB1ALTER } )
   oSection1:Cell("B1_DESCALT"):SetBlock( {|| POSICIONE("SB1",1,xFilial("SB1")+cB1ALTER,"B1_DESC") } )
   oSection1:Cell("ESTOQUEALT"):SetBlock( {|| nEstAlT } )
                                                   
   aCompLam := VerEstru('01'/*QRYTMP->CCODEMP*/,cB1ALTER/*QRYTMP->C6_PRODUTO*/,"LAM")
   oSection1:Cell("G1_COMPLAM"):SetBlock( {|| aCompLam[1] } )
   oSection1:Cell("B1_DESCLAM"):SetBlock( {|| aCompLam[2] } )
   oSection1:Cell("ESTOQUELAM"):SetBlock( {|| aCompLam[3] } )

   aCompEst := VerEstru('01'/*QRYTMP->CCODEMP*/,cB1ALTER/*QRYTMP->C6_PRODUTO*/,"EST")
   oSection1:Cell("G1_COMPEST"):SetBlock( {|| aCompEst[1] } )
   oSection1:Cell("B1_DESCEST"):SetBlock( {|| aCompEst[2] } )
   oSection1:Cell("ESTOQUEEST"):SetBlock( {|| aCompEst[3] } )
   
   oSection1:PrintLine()

   dbSelectArea("QRYTMP")
   dbSkip()
EndDo
                  
oSection1:Finish()

dbSelectArea("QRYTMP")
dbCloseArea()

Return .T.     

//////////////////////////////////////////////////////////
Static Function VerEstru(cEmpresa,cProduto,cTipoPI)
     
Local cGrupo    := ""
Local cComponen := ""
Local cQuery    := ""
Local aCamp     := {"","",0}
Local aArea     := GETAREA()
Local cGrupo    := ""   
Local nEstAtu   := 0

If cTipoPI == "LAM" // LAMINADO
   cGrupo := "402 "
ElseIf cTipoPI == "EST" // ESTAMPADO
   cGrupo := "400 "                                         
EndIf
            
While !EMPTY(cProduto)
   
   cComponen := ""

   cQuery := "SELECT G1_COMP,B1_DESC,B1_TIPO,B1_GRUPO,B1_LOCPAD " //,ISNULL(B2_QATU,0) B2_QATU " 
   cQuery += "FROM " + U_RetMySqlTab("SG1", cEmpresa, .T.)[1] + " "
   cQuery += "INNER JOIN " + U_RetMySqlTab("SB1", cEmpresa, .T.)[1] + " ON B1_FILIAL = '"+xFilial("SB1")+"' AND B1_COD = G1_COMP AND SB1.D_E_L_E_T_ = ' ' "
   //cQuery += "LEFT OUTER JOIN " + U_RetMySqlTab("SB2", cEmpresa, .T.)[1] + " ON B2_FILIAL = '01' AND B2_COD = G1_COMP AND B2_LOCAL = B1_LOCPAD AND SB2.D_E_L_E_T_ = ' ' "
   cQuery += "WHERE G1_FILIAL = '"+xFilial("SG1")+"' AND G1_COD = '"+cProduto+"' AND B1_TIPO = 'PI' AND SG1.D_E_L_E_T_ = ' ' "                                                      
                     
   TcQuery cQuery New Alias "SG1TMP"                      

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Inicia rotina de impressao                                   ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   dbSelectArea("SG1TMP")
   dbGoTop()
   While !EOF() 
                            
      If SG1TMP->B1_GRUPO $ cGrupo
         nEstAtu  := SldAglut(SG1TMP->G1_COMP,SG1TMP->B1_LOCPAD,"B2_QATU") //SG1TMP->B2_QATU 

         aCamp := {SG1TMP->G1_COMP,SG1TMP->B1_DESC,nEstAtu}
         Exit
      EndIf
   
      cComponen := SG1TMP->G1_COMP
      
      dbSelectArea("SG1TMP")
      dbSkip()
   EndDo
   dbSelectArea("SG1TMP")
   dbCloseArea()

   cProduto := cComponen
EndDo

RESTAREA(aArea)

Return aCamp

///////////////////////////////////////////////////////////
// Saldo Aglutinado das 3 empresas - Montes - 08/07/2019 //
///////////////////////////////////////////////////////////
Static Function SldAglut(cProduto,cLocal,cCampo)
              
Local aArea   := GETAREA()
Local nSldAtu := 0
Local cQuery  := ""

cQuery := "SELECT SUM(QATU) QATU FROM ("+cCRLF
For nEmpresa := 1 to Len(aEmpresas)

    If nEmpresa > 1
       cQuery += " UNION ALL "+cCRLF
    EndIf

    cQuery += "SELECT SUM("+cCampo+") QATU "+cCRLF
    cQuery += "FROM " + aTabSB2[nEmpresa] + " "+cCRLF
    cQuery += "INNER JOIN "+ RetSqlName('SB1') +" SB1 ON B1_FILIAL = '  ' AND B1_COD = B2_COD AND SB1.D_E_L_E_T_ = ' ' "+cCRLF
    cQuery += "WHERE B2_FILIAL = '01' "+cCRLF
    If aEmpresas[nEmpresa] = "01"
       cQuery += "AND B2_COD = '"+cProduto+"' "+cCRLF
    Else
       cQuery += "AND B2_COD <> '"+cProduto+"' "+cCRLF
       cQuery += "AND B1_ALTER = '"+cProduto+"' "+cCRLF
    EndIf
    cQuery += "AND B2_LOCAL = '"+cLocal+"' "+cCRLF
    cQuery += "AND B2_STATUS <> '2' "+cCRLF
    cQuery += "AND SB2.D_E_L_E_T_ = ' ' "+cCRLF
Next nEmpresa
cQuery += ") AS SB2TMP "

TcQuery cQuery New Alias "SB2TMP"                      

dbSelectArea("SB2TMP")
dbGoTop()
If !EOF()     
   nSldAtu := SB2TMP->QATU
EndIf
dbSelectArea("SB2TMP")
dbCloseArea()

RESTAREA(aArea)

Return nSldAtu

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ AjustaSx1    ³ Autor ³ Montes              	³ Data ³ 15/05/17 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica/cria SX1 a partir de matriz para verificacao          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Siga                                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AjustaSX1()

Local _sAlias	:= Alias()
Local aCposSX1	:= {}
Local nX 		:= 0
Local lAltera	:= .F.
Local nCondicao
Local nJ
Local cKey		:= ""
Local aPergs:={}
Local cPerg := PADR("FATR08",LEN(SX1->X1_GRUPO))

Aadd(aPergs,{"De data de entrega ?"   ,"¿De Fecha de Entrega ?" ,"From Deliver Date ?","mv_ch1","D",08,0,0,"G","","mv_par01", "         "   ,"             ","            ","","","               ","               ","               ","","","       ","","","","","","","","","","","","","    ","   ","   ","S",""})
Aadd(aPergs,{"Ate data de entrega ?"  ,"¿A Fecha de Entrega ?"  ,"To Deliver Date ?"  ,"mv_ch2","D",08,0,0,"G","","mv_par02", "         "   ,"             ","            ","","","               ","               ","               ","","","       ","","","","","","","","","","","","","    ","   ","   ","S",""})
Aadd(aPergs,{"Produto De ?"           ,"¿De Produto ?"          ,"From Product ?"     ,"mv_ch3","C",15,0,0,"G","","mv_par03", "         "   ,"             ","            ","","","               ","               ","               ","","","       ","","","","","","","","","","","","","    ","SB1","   ","S",""})
Aadd(aPergs,{"Produto Ate ?"          ,"¿A Produto ?"           ,"To Product ?"       ,"mv_ch4","C",15,0,0,"G","","mv_par04", "         "   ,"             ","            ","","","               ","               ","               ","","","       ","","","","","","","","","","","","","    ","SB1","   ","S",""})
Aadd(aPergs,{"Tipo De ?"              ,"¿De Tipo ?"             ,"From Tipo ?"        ,"mv_ch5","C",02,0,0,"G","","mv_par05", "         "   ,"             ","            ","","","               ","               ","               ","","","       ","","","","","","","","","","","","","    ","SAH","   ","S",""})
Aadd(aPergs,{"Tipo Ate ?"             ,"¿A Tipo ?"              ,"To Tipo ?"          ,"mv_ch6","C",02,0,0,"G","","mv_par06", "         "   ,"             ","            ","","","               ","               ","               ","","","       ","","","","","","","","","","","","","    ","SAH","   ","S",""})
Aadd(aPergs,{"Emps.sep.virg.?"		,"¿Emps.sep.comas?"			,"Co.sep.commas?"	,"mv_ch7","C",50,0,0,"G","","mv_par07", "         "		,"             ","            ","","","                ","               ","               ","","","       "  ,"","","","","","","","","","","","","    ","   ","   ","S",""})

aCposSX1:={"X1_PERGUNT","X1_PERSPA","X1_PERENG","X1_VARIAVL","X1_TIPO","X1_TAMANHO",;
"X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID",;
"X1_VAR01","X1_DEF01","X1_DEFSPA1","X1_DEFENG1","X1_CNT01",;
"X1_VAR02","X1_DEF02","X1_DEFSPA2","X1_DEFENG2","X1_CNT02",;
"X1_VAR03","X1_DEF03","X1_DEFSPA3","X1_DEFENG3","X1_CNT03",;
"X1_VAR04","X1_DEF04","X1_DEFSPA4","X1_DEFENG4","X1_CNT04",;
"X1_VAR05","X1_DEF05","X1_DEFSPA5","X1_DEFENG5","X1_CNT05",;
"X1_F3", "X1_GRPSXG", "X1_PYME","X1_HELP" }

dbSelectArea("SX1")
dbSetOrder(1)
For nX:=1 to Len(aPergs)
	lAltera := .F.
	If MsSeek(Padr(cPerg,Len(SX1->X1_GRUPO))+Right(aPergs[nX][11], 2))
		If Alltrim(aPergs[nX][1]) != Alltrim(SX1->X1_PERGUNT)
			lAltera := .T.
		EndIf
	EndIf
	
	If ! lAltera .And. Found() .And. X1_TIPO <> aPergs[nX][5]
		lAltera := .T.		// Garanto que o tipo da pergunta esteja correto
	EndIf
	
	If ! Found() .Or. lAltera
		RecLock("SX1",If(lAltera, .F., .T.))
		Replace X1_GRUPO with cPerg
		Replace X1_ORDEM with Right(aPergs[nX][11], 2)
		For nj:=1 to Len(aCposSX1)
			If 	Len(aPergs[nX]) >= nJ .And. aPergs[nX][nJ] <> Nil .And.;
				FieldPos(AllTrim(aCposSX1[nJ])) > 0
				Replace &(AllTrim(aCposSX1[nJ])) With aPergs[nx][nj]
			Endif
		Next nj
		MsUnlock()
		cKey := "P."+AllTrim(X1_GRUPO)+AllTrim(X1_ORDEM)+"."
		
		If ValType(aPergs[nx][Len(aPergs[nx])]) = "A"
			aHelpSpa := aPergs[nx][Len(aPergs[nx])]
		Else
			aHelpSpa := {}
		EndIf
		
		If ValType(aPergs[nx][Len(aPergs[nx])-1]) = "A"
			aHelpEng := aPergs[nx][Len(aPergs[nx])-1]
		Else
			aHelpEng := {}
		EndIf
		
		If ValType(aPergs[nx][Len(aPergs[nx])-2]) = "A"
			aHelpPor := aPergs[nx][Len(aPergs[nx])-2]
		Else
			aHelpPor := {}
		EndIf
		
		PutSX1Help(cKey,aHelpPor,aHelpEng,aHelpSpa)
	EndIf
Next

Return()