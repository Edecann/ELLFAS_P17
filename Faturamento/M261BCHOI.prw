#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ M261BCHOI³ Autor ³ Montes                ³ Data ³ 26/06/19 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Inclusao de Botao na Transferencia Mod 2                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M261BCHOI

Local aBut261 := {}

If RetCodUsr() = "000000" //Administrador
  aAdd(aBut261, {'EDIT'	   	,{ || U_M261ADDACOLS() }  	, "Adicionar aCols        " 	,"ADD Acols" } )
EndIf

Return(aBut261)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³M261ADDACOLS³ Autor ³ Montes              ³ Data ³ 26/06/19 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Adiciona acols a partir de array                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M261ADDACOLS

Local cCodPro := Space(15)
Local oDlg
Local nOpca


If nOpca <> 0
	Processa({||AddAcols()},"Selecionando produtos...")
EndIf

Return

/*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ADDACOLS  ³ Autor ³ Montes                ³ Data ³ 26/06/19 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³Adiciona Acols                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AddAcols(lGerLinBD)

Local aArea := GetArea()
Local aAreaSB2 := SB2->(GetArea())
Local cQuery
Local nLoop
Local nProc

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui valores as variaveis de Posicao utilizado no Siga Pyme   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nPosCODOri := 1  //Codigo do Produto Origem
Local nPosDOri	 := 2  //Descricao do Produto Origem
Local nPosUMOri  := 3  //Unidade de Medida Origem
Local nPosLOCOri := 4  //Armazem Origem
Local nPosLcZOri := 5  //Localizacao Origem

Local nPosCODDes := 6  //Codigo do Produto Destino
Local nPosDDes	 := 7  //Descricao do Produto Destino
Local nPosUMDes  := 8  //Unidade de Medida Destino
Local nPosLOCDes := 9  //Armazem Destino
Local nPosLcZDes := 10 //Localizacao Destino

Local nPosNSer   := 11	//Numero de Serie
Local nPosLoTCTL := 12	//Lote de Controle
Local nPosNLOTE  := 13	//Numero do Lote
Local nPosDTVAL  := 14	//Data Valida
Local nPosPotenc := 15	//Potencia
Local nPosQUANT  := 16	//Quantidade
Local nPosQTSEG  := 17	//Quantidade na 2a. Unidade de Medida
Local nPosEstor  := 18	//Estornado
Local nPosNumSeq := 19	//Sequencia
Local nPosLotDes := 20  //Lote Destino
Local nPosDtVldD := 21  //Data Valida de Destino
Local cQuery
Local aDadosOk
Local cLocOri := "04"
Local cLocDes := "06"                        
Local aProds := {}                           

Default lGerLinBD	:= .F.

/*
SELECT 'AADD( APRODS, { '''+B2_COD+''','+CAST(B2_QATU AS VARCHAR(10))+' } )' FROM SB2010 WHERE B2_FILIAL = '01' AND B2_LOCAL = '04' AND B2_QATU <> 0
AND B2_COD IN ( SELECT B7_COD FROM SB7010 WHERE B7_DOC = '20190626I' AND D_E_L_E_T_ = ' ' )
*/

If lGerLinBD
	AADD( APRODS, { '714501710      ',1 } )
	AADD( APRODS, { '714504510      ',1 } )
	AADD( APRODS, { '714504610      ',1 } )
	AADD( APRODS, { '714505510      ',1 } )
	AADD( APRODS, { '716500310      ',3 } )
	AADD( APRODS, { '716500710      ',3 } )
	AADD( APRODS, { '716500810      ',5 } )
	AADD( APRODS, { '716500910      ',2 } )
	AADD( APRODS, { '716501010      ',8 } )
	AADD( APRODS, { '716501110      ',8 } )
	AADD( APRODS, { '716501210      ',3 } )
	AADD( APRODS, { '716501310      ',31 } )
	AADD( APRODS, { '716501510      ',26 } )
	AADD( APRODS, { '716501610      ',1 } )
	AADD( APRODS, { '716501710      ',4 } )
	AADD( APRODS, { '716501810      ',3 } )
	AADD( APRODS, { '716502010      ',11 } )
	AADD( APRODS, { '716502110      ',7 } )
	AADD( APRODS, { '716502210      ',3 } )
	AADD( APRODS, { '716502310      ',7 } )
	AADD( APRODS, { '716502610      ',10 } )
	AADD( APRODS, { '716502710      ',8 } )
	AADD( APRODS, { '716502810      ',3 } )
	AADD( APRODS, { '716502910      ',7 } )
	AADD( APRODS, { '716503010      ',2 } )
	AADD( APRODS, { '716503110      ',8 } )
	AADD( APRODS, { '716503210      ',21 } )
	AADD( APRODS, { '716503310      ',8 } )
	AADD( APRODS, { '716503410      ',6 } )
	AADD( APRODS, { '716503510      ',12 } )
	AADD( APRODS, { '716503610      ',1 } )
	AADD( APRODS, { '716503710      ',5 } )
	AADD( APRODS, { '716503810      ',4 } )
	AADD( APRODS, { '716503910      ',14 } )
	AADD( APRODS, { '716504110      ',11 } )
	AADD( APRODS, { '716504410      ',5 } )
	AADD( APRODS, { '716504610      ',1 } )
	AADD( APRODS, { '716505010      ',3 } )
	AADD( APRODS, { '716505110      ',6 } )
	AADD( APRODS, { '716505310      ',3 } )
	AADD( APRODS, { '716505410      ',11 } )
	AADD( APRODS, { '716505510      ',4 } )
	AADD( APRODS, { '716505610      ',4 } )
	AADD( APRODS, { '716505710      ',5 } )
	AADD( APRODS, { '716505810      ',2 } )
	AADD( APRODS, { '716505910      ',5 } )
	AADD( APRODS, { '716506010      ',3 } )
	AADD( APRODS, { '716506110      ',4 } )
	AADD( APRODS, { '716506310      ',2 } )
	AADD( APRODS, { '716506610      ',5 } )
	AADD( APRODS, { '716506710      ',3 } )
	AADD( APRODS, { '716506810      ',161 } )
	AADD( APRODS, { '716506910      ',3 } )
	AADD( APRODS, { '716507010      ',1 } )
	AADD( APRODS, { '716507110      ',5 } )
	AADD( APRODS, { '716507210      ',3 } )
	AADD( APRODS, { '716507310      ',5 } )
	AADD( APRODS, { '716507410      ',2 } )
	AADD( APRODS, { '716507510      ',4 } )
	AADD( APRODS, { '7570342        ',1 } )
	AADD( APRODS, { '7570410        ',150 } )
	AADD( APRODS, { '7570542        ',2 } )
	AADD( APRODS, { '7570642        ',2 } )
	AADD( APRODS, { '7570710        ',7 } )
	AADD( APRODS, { '7570942        ',3 } )
	AADD( APRODS, { '7571240        ',21 } )
	AADD( APRODS, { '7571340        ',2 } )
	AADD( APRODS, { '7571440        ',11 } )
	AADD( APRODS, { '7571842        ',1 } )
	AADD( APRODS, { '7572610        ',6 } )
	AADD( APRODS, { '7572840        ',22 } )
	AADD( APRODS, { '7574840        ',2 } )
	AADD( APRODS, { '7575340        ',5 } )
	AADD( APRODS, { '7575540        ',6 } )
	AADD( APRODS, { '7575742        ',2 } )
	AADD( APRODS, { '7576140        ',1 } )
	AADD( APRODS, { '7576240        ',420 } )
	AADD( APRODS, { '7577110        ',64 } )
	AADD( APRODS, { '7577240        ',3 } )
	AADD( APRODS, { '7577542        ',2 } )
	AADD( APRODS, { '7578442        ',1 } )
	AADD( APRODS, { '7700640        ',2 } )
	AADD( APRODS, { '7700742        ',2 } )
	AADD( APRODS, { '7700810        ',4 } )
	AADD( APRODS, { '7700940        ',11 } )
	AADD( APRODS, { '7701040        ',2 } )
	AADD( APRODS, { '7701140        ',15 } )
	AADD( APRODS, { '7701310        ',1 } )
	AADD( APRODS, { '7701910        ',1 } )
	AADD( APRODS, { '7702440        ',1 } )
	AADD( APRODS, { '7704040        ',1 } )
	AADD( APRODS, { '7704410        ',7 } )
	AADD( APRODS, { '7704510        ',8 } )
	AADD( APRODS, { '7705040        ',3 } )
	AADD( APRODS, { '7705142        ',1 } )
	AADD( APRODS, { '7705310        ',21 } )
	AADD( APRODS, { '7706942        ',2 } )
	AADD( APRODS, { '7707310        ',4 } )
	AADD( APRODS, { '7707710        ',4 } )
	AADD( APRODS, { '7801420110     ',3 } )
	AADD( APRODS, { '7801420210     ',20 } )
	AADD( APRODS, { '7801420310     ',8 } )
	AADD( APRODS, { '78014203110    ',1 } )
	AADD( APRODS, { '7801420610     ',6 } )
	AADD( APRODS, { '7801420710     ',6 } )
	AADD( APRODS, { '7801420810     ',1 } )
	AADD( APRODS, { '7801420910     ',6 } )
	AADD( APRODS, { '7801421010     ',4 } )
	AADD( APRODS, { '7801421110     ',10 } )
	AADD( APRODS, { '7801421210     ',3 } )
	AADD( APRODS, { '7801421310     ',3 } )
	AADD( APRODS, { '7801421410     ',3 } )
	AADD( APRODS, { '7801421610     ',6 } )
	AADD( APRODS, { '7801421810     ',2 } )
	AADD( APRODS, { '7801422310     ',3 } )
	AADD( APRODS, { '7801422410     ',1 } )
	AADD( APRODS, { '7801422510     ',4 } )
	AADD( APRODS, { '7801422610     ',2 } )
	AADD( APRODS, { '7801423110     ',2 } )
	AADD( APRODS, { '7801423510     ',4 } )
	AADD( APRODS, { '7801423810     ',7 } )
	AADD( APRODS, { '7801423910     ',7 } )
	AADD( APRODS, { '7801424010     ',10 } )
	AADD( APRODS, { '7801424110     ',4 } )
	AADD( APRODS, { '7801426110     ',7 } )
	AADD( APRODS, { '7801426210     ',7 } )
	AADD( APRODS, { '7801427310     ',3 } )
	AADD( APRODS, { '7801427510     ',4 } )
	AADD( APRODS, { '7801427610     ',1 } )
	AADD( APRODS, { '7801427810     ',9 } )
	AADD( APRODS, { '7801427910     ',3 } )
	AADD( APRODS, { '7801428110     ',2 } )
	AADD( APRODS, { '7801428210     ',22 } )
	AADD( APRODS, { '7801428310     ',2 } )
	AADD( APRODS, { '7801428410     ',2 } )
	AADD( APRODS, { '7801428510     ',3 } )
	AADD( APRODS, { '780160210      ',12 } )
	AADD( APRODS, { '780160310      ',11 } )
	AADD( APRODS, { '780160410      ',78 } )
	AADD( APRODS, { '780160610      ',2 } )
	AADD( APRODS, { '780160710      ',6 } )
	AADD( APRODS, { '780160810      ',10 } )
	AADD( APRODS, { '780160910      ',3 } )
	AADD( APRODS, { '780161110      ',11 } )
	AADD( APRODS, { '7801612.10     ',4 } )
	AADD( APRODS, { '780161310      ',7 } )
	AADD( APRODS, { '780161510      ',2 } )
	AADD( APRODS, { '780161610      ',5 } )
	AADD( APRODS, { '780161710      ',13 } )
	AADD( APRODS, { '780161810      ',4 } )
	AADD( APRODS, { '780161910      ',2 } )
	AADD( APRODS, { '780162310      ',1 } )
	AADD( APRODS, { '780162610      ',4 } )
	AADD( APRODS, { '780162710      ',3 } )
	AADD( APRODS, { '780162910      ',6 } )
	AADD( APRODS, { '780163010      ',6 } )
	AADD( APRODS, { '780163110      ',14 } )
	AADD( APRODS, { '780163210      ',10 } )
	AADD( APRODS, { '780163310      ',2 } )
	AADD( APRODS, { '780163510      ',7 } )
	AADD( APRODS, { '780163610      ',2 } )
	AADD( APRODS, { '792300210      ',3 } )
	AADD( APRODS, { '792300610      ',13 } )
	AADD( APRODS, { '792300710      ',4 } )
	AADD( APRODS, { '792300810      ',8 } )
	AADD( APRODS, { '792301010      ',14 } )
	AADD( APRODS, { '792301110      ',12 } )
	AADD( APRODS, { '792301310      ',8 } )
	AADD( APRODS, { '792301610      ',4 } )
	AADD( APRODS, { '792301710      ',15 } )
	AADD( APRODS, { '792301810      ',2 } )
	AADD( APRODS, { '792302210      ',5 } )
	AADD( APRODS, { '792302510      ',8 } )
	AADD( APRODS, { '792302610      ',1 } )
	AADD( APRODS, { '792302710      ',3 } )
	AADD( APRODS, { '792303110      ',7 } )
	AADD( APRODS, { '792303210      ',2 } )
	AADD( APRODS, { '792303310      ',134 } )
	AADD( APRODS, { '792303410      ',2 } )
	AADD( APRODS, { '792303610      ',13 } )
	AADD( APRODS, { '792303810      ',5 } )
	AADD( APRODS, { '792303910      ',1 } )
	AADD( APRODS, { '792304010      ',3 } )
	AADD( APRODS, { '792304110      ',4 } )
	AADD( APRODS, { '792304410      ',12 } )
	AADD( APRODS, { '792304510      ',15 } )
	AADD( APRODS, { '792304810      ',1 } )
	AADD( APRODS, { '7F70110        ',42 } )
	AADD( APRODS, { '7F70210        ',5 } )
	AADD( APRODS, { '7F70310        ',3 } )
	AADD( APRODS, { '7F70410        ',1 } )
	AADD( APRODS, { '7F70510        ',1 } )
	AADD( APRODS, { '7F70710        ',21 } )
	AADD( APRODS, { '7F71110        ',11 } )
	AADD( APRODS, { '7F71210        ',16 } )
	AADD( APRODS, { '7F71310        ',9 } )
	AADD( APRODS, { '7F71410        ',12 } )
	AADD( APRODS, { '7F71510        ',4 } )
	AADD( APRODS, { '7F71610        ',16 } )
	AADD( APRODS, { '7F71710        ',8 } )
	AADD( APRODS, { '7F71810        ',4 } )
	AADD( APRODS, { '7F71910        ',4 } )
	AADD( APRODS, { '7F72010        ',5 } )
	AADD( APRODS, { '7F72110        ',9 } )
	AADD( APRODS, { '7F72210        ',12 } )
	AADD( APRODS, { '7F72310        ',7 } )
	AADD( APRODS, { '7F72610        ',9 } )
	AADD( APRODS, { '7F72710        ',15 } )
	AADD( APRODS, { '7F72810        ',5 } )
	AADD( APRODS, { '7F72910        ',2 } )
	AADD( APRODS, { '7F73010        ',2 } )
	AADD( APRODS, { '7F73110        ',3 } )
	AADD( APRODS, { '7F73210        ',9 } )
	AADD( APRODS, { '7F73310        ',66 } )
	AADD( APRODS, { '7F73410        ',29 } )
	AADD( APRODS, { '7F73510        ',6 } )
	AADD( APRODS, { '7F73610        ',26 } )
	AADD( APRODS, { '7F73710        ',9 } )
	AADD( APRODS, { '7F73810        ',2 } )
	AADD( APRODS, { '7F73910        ',6 } )
	AADD( APRODS, { '7F74010        ',2 } )
	AADD( APRODS, { '7F74210        ',7 } )
	AADD( APRODS, { '7F74310        ',13 } )
	AADD( APRODS, { '7F74410        ',30 } )
	AADD( APRODS, { '7F74510        ',50 } )
	AADD( APRODS, { '7F74610        ',5 } )
	AADD( APRODS, { '7F75010        ',7 } )
	AADD( APRODS, { '7F75110        ',23 } )
	AADD( APRODS, { '7F75210        ',3 } )
	AADD( APRODS, { '7F75310        ',96 } )
	AADD( APRODS, { '910010290      ',24 } )
	AADD( APRODS, { '910010390      ',160 } )
	AADD( APRODS, { '910010590      ',47 } )
	AADD( APRODS, { '910010690      ',58 } )
	AADD( APRODS, { '910010790      ',65 } )
	AADD( APRODS, { '910010890      ',66 } )
	AADD( APRODS, { '910011090      ',62 } )
	AADD( APRODS, { '910011190      ',30 } )
	AADD( APRODS, { '910011290      ',360 } )
	AADD( APRODS, { '910011390      ',326 } )
	AADD( APRODS, { '910011590      ',146 } )
	AADD( APRODS, { '910011690      ',11 } )
	AADD( APRODS, { '910011790      ',75 } )
	AADD( APRODS, { '910011890      ',343 } )
	AADD( APRODS, { '910011990      ',347 } )
	AADD( APRODS, { '910012090      ',69 } )
	AADD( APRODS, { '910012190      ',69 } )
	AADD( APRODS, { '910012290      ',24 } )
	AADD( APRODS, { '910012390      ',33 } )
	AADD( APRODS, { '910012490      ',75 } )
	AADD( APRODS, { '910030190      ',7 } )
	AADD( APRODS, { '910040190      ',106 } )
	AADD( APRODS, { '910040290      ',16 } )
	AADD( APRODS, { '910040390      ',14 } )
	AADD( APRODS, { '910040490      ',227 } )
	AADD( APRODS, { '910041290      ',1405 } )
	AADD( APRODS, { '910041490      ',33 } )
	AADD( APRODS, { '910041590      ',128 } )
	AADD( APRODS, { '910041690      ',29 } )
	AADD( APRODS, { '910041890      ',40 } )
	AADD( APRODS, { '910042190      ',85 } )
	AADD( APRODS, { '910042290      ',61 } )
	AADD( APRODS, { '910042390      ',33 } )
	AADD( APRODS, { '910042490      ',65 } )
	AADD( APRODS, { '910042690      ',12 } )
	AADD( APRODS, { '910042790      ',25 } )
	AADD( APRODS, { '910043090      ',12 } )
	AADD( APRODS, { '910043390      ',14 } )
	AADD( APRODS, { '910043590      ',37 } )
	AADD( APRODS, { '910043990      ',17 } )
	AADD( APRODS, { '910044190      ',43 } )
	AADD( APRODS, { '910044990      ',22 } )
	AADD( APRODS, { '913010190      ',4 } )
	AADD( APRODS, { '913010290      ',2 } )
	AADD( APRODS, { '913011490      ',3 } )
	AADD( APRODS, { '913011690      ',6 } )
	AADD( APRODS, { '913011790      ',1 } )
	AADD( APRODS, { '913012590      ',4 } )
	AADD( APRODS, { '913021790      ',2 } )
	AADD( APRODS, { '913022090      ',7 } )
	AADD( APRODS, { '913040290      ',11 } )
	AADD( APRODS, { '913041690      ',2 } )
	AADD( APRODS, { '913042390      ',4 } )
	AADD( APRODS, { '913042690      ',4 } )
	AADD( APRODS, { '913042790      ',3 } )
	AADD( APRODS, { '913043090      ',4 } )
	AADD( APRODS, { '913043290      ',6 } )
	AADD( APRODS, { '913043390      ',9 } )
	AADD( APRODS, { '913043590      ',1 } )
	AADD( APRODS, { '913043990      ',1 } )
	AADD( APRODS, { '913044490      ',6 } )
	AADD( APRODS, { '913044790      ',14 } )
	AADD( APRODS, { '920190         ',1089 } )
	AADD( APRODS, { '920390         ',837 } )
	AADD( APRODS, { '920490         ',1005 } )
	AADD( APRODS, { '920590         ',141 } )
	AADD( APRODS, { '920690         ',1066 } )
	AADD( APRODS, { '920790         ',1562 } )
	AADD( APRODS, { '920890         ',439 } )
	AADD( APRODS, { '920990         ',589 } )
	AADD( APRODS, { '921090         ',300 } )
	AADD( APRODS, { '921190         ',2 } )
	AADD( APRODS, { '921290         ',885 } )
	AADD( APRODS, { '921390         ',1024 } )
	AADD( APRODS, { '921490         ',1061 } )
	AADD( APRODS, { '921590         ',947 } )
	AADD( APRODS, { '921690         ',307 } )
	AADD( APRODS, { '921790         ',254 } )
	AADD( APRODS, { '9217C90        ',2 } )
	AADD( APRODS, { '921890         ',1786 } )
	AADD( APRODS, { '921990         ',1620 } )
	AADD( APRODS, { '922090         ',299 } )
	AADD( APRODS, { '940590         ',2325 } )
	AADD( APRODS, { '943590         ',475 } )
	AADD( APRODS, { '943790         ',56 } )
	AADD( APRODS, { '945090         ',5 } )
	AADD( APRODS, { '95510190       ',113 } )
	AADD( APRODS, { '95510290       ',9 } )
	AADD( APRODS, { '95510390       ',90 } )
	AADD( APRODS, { '95510490       ',3 } )
	AADD( APRODS, { '95510590       ',16 } )
	AADD( APRODS, { '95510690       ',83 } )
	AADD( APRODS, { '95510790       ',587 } )
	AADD( APRODS, { '95510890       ',730 } )
	AADD( APRODS, { '95510990       ',42 } )
	AADD( APRODS, { '95511090       ',58 } )
	AADD( APRODS, { '95511190       ',221 } )
	AADD( APRODS, { '95511290       ',5 } )
	AADD( APRODS, { '95511390       ',2 } )
	AADD( APRODS, { '95511490       ',45 } )
	AADD( APRODS, { '95511590       ',37 } )
	AADD( APRODS, { '95511690       ',11 } )
	AADD( APRODS, { '95511890       ',210 } )
	AADD( APRODS, { '95511990       ',35 } )
	AADD( APRODS, { '95512090       ',11 } )
	AADD( APRODS, { '955120B90      ',6 } )
	AADD( APRODS, { '95512190       ',11 } )
	AADD( APRODS, { '95512290       ',1 } )
	AADD( APRODS, { '95512390       ',40 } )
	AADD( APRODS, { '95512490       ',167 } )
	AADD( APRODS, { '95512590       ',5 } )
	AADD( APRODS, { '95512690       ',365 } )
	AADD( APRODS, { '95530290       ',301 } )
	AADD( APRODS, { '95530390       ',5 } )
	AADD( APRODS, { '95540190       ',226 } )
	AADD( APRODS, { '95540290       ',7 } )
	AADD( APRODS, { '95540490       ',451 } )
	AADD( APRODS, { '95540690       ',24 } )
	AADD( APRODS, { '95540790       ',1487 } )
	AADD( APRODS, { '95540890       ',1139 } )
	AADD( APRODS, { '95540990       ',558 } )
	AADD( APRODS, { '95541090       ',1774 } )
	AADD( APRODS, { '95541190       ',163 } )
	AADD( APRODS, { '95541290       ',670 } )
	AADD( APRODS, { '95541390       ',628 } )
	AADD( APRODS, { '95541590       ',2234 } )
	AADD( APRODS, { '95541690       ',6 } )
	AADD( APRODS, { '95541790       ',297 } )
	AADD( APRODS, { '95541890       ',813 } )
	AADD( APRODS, { '95541990       ',1400 } )
	AADD( APRODS, { '95542090       ',87 } )
	AADD( APRODS, { '95542190       ',14 } )
	AADD( APRODS, { '95542290       ',89 } )
	AADD( APRODS, { '95542390       ',240 } )
	AADD( APRODS, { '95542490       ',5 } )
	AADD( APRODS, { '95542590       ',932 } )
	AADD( APRODS, { '95542690       ',579 } )
	AADD( APRODS, { '95542790       ',10 } )
	AADD( APRODS, { '95542890       ',14 } )
	AADD( APRODS, { '95542990       ',952 } )
	AADD( APRODS, { '95543090       ',1302 } )
	AADD( APRODS, { '95543190       ',6 } )
	AADD( APRODS, { '95543290       ',808 } )
	AADD( APRODS, { '95543390       ',383 } )
	AADD( APRODS, { '95543490       ',52 } )
	AADD( APRODS, { '95543690       ',5 } )
	AADD( APRODS, { '95543890       ',734 } )
	AADD( APRODS, { '95543990       ',167 } )
	AADD( APRODS, { '95544090       ',446 } )
	AADD( APRODS, { '95544190       ',4 } )
	AADD( APRODS, { '95544290       ',291 } )
	AADD( APRODS, { '95544390       ',947 } )
	AADD( APRODS, { '95544490       ',577 } )
	AADD( APRODS, { '97010590       ',49 } )
	AADD( APRODS, { '97010690       ',185 } )
	AADD( APRODS, { '97010790       ',36 } )
	AADD( APRODS, { '97010890       ',240 } )
	AADD( APRODS, { '97010990       ',185 } )
	AADD( APRODS, { '97011090       ',203 } )
	AADD( APRODS, { '97011190       ',2 } )
	AADD( APRODS, { '97011290       ',51 } )
	AADD( APRODS, { '97011390       ',20 } )
	AADD( APRODS, { '97011490       ',4 } )
	AADD( APRODS, { '970114B90      ',4 } )
	AADD( APRODS, { '97011590       ',9 } )
	AADD( APRODS, { '97011690       ',5 } )
	AADD( APRODS, { '97011790       ',27 } )
	AADD( APRODS, { '97011890       ',47 } )
	AADD( APRODS, { '97011990       ',536 } )
	AADD( APRODS, { '97012090       ',714 } )
	AADD( APRODS, { '97012190       ',15 } )
	AADD( APRODS, { '97012290       ',16 } )
	AADD( APRODS, { '97012390       ',1280 } )
	AADD( APRODS, { '97012490       ',411 } )
	AADD( APRODS, { '97030190       ',8 } )
	AADD( APRODS, { '97030290       ',182 } )
	AADD( APRODS, { '97030390       ',54 } )
	AADD( APRODS, { '97040190       ',475 } )
	AADD( APRODS, { '97040390       ',2 } )
	AADD( APRODS, { '97040490       ',1180 } )
	AADD( APRODS, { '97040690       ',67 } )
	AADD( APRODS, { '97040890       ',797 } )
	AADD( APRODS, { '97040990       ',416 } )
	AADD( APRODS, { '97041090       ',203 } )
	AADD( APRODS, { '97041290       ',485 } )
	AADD( APRODS, { '97041590       ',36 } )
	AADD( APRODS, { '97041990       ',67 } )
	AADD( APRODS, { '97042090       ',215 } )
	AADD( APRODS, { '97042190       ',36 } )
	AADD( APRODS, { '97042490       ',701 } )
	AADD( APRODS, { '97042590       ',211 } )
	AADD( APRODS, { '97042690       ',73 } )
	AADD( APRODS, { '97042790       ',11 } )
	AADD( APRODS, { '97042890       ',419 } )
	AADD( APRODS, { '97043090       ',58 } )
	AADD( APRODS, { '97043190       ',40 } )
	AADD( APRODS, { '97043490       ',86 } )
	AADD( APRODS, { '97043690       ',9 } )
	AADD( APRODS, { '97043890       ',469 } )
	AADD( APRODS, { '97044190       ',198 } )
	AADD( APRODS, { '98310790       ',21 } )
	AADD( APRODS, { '98310990       ',550 } )
	AADD( APRODS, { '98311290       ',98 } )
	AADD( APRODS, { '98311690       ',33 } )
	AADD( APRODS, { '98311990       ',9 } )
	AADD( APRODS, { '98312190       ',22 } )
	AADD( APRODS, { '98330390       ',51 } )
	AADD( APRODS, { '98340690       ',170 } )
	AADD( APRODS, { '98340790       ',868 } )
	AADD( APRODS, { '98340890       ',600 } )
	AADD( APRODS, { '98340990       ',436 } )
	AADD( APRODS, { '98341090       ',619 } )
	AADD( APRODS, { '98341190       ',281 } )
	AADD( APRODS, { '98341690       ',34 } )
	AADD( APRODS, { '98341990       ',1376 } )
	AADD( APRODS, { '98342290       ',51 } )
	AADD( APRODS, { '98342590       ',48 } )
	AADD( APRODS, { '98342990       ',16 } )
	AADD( APRODS, { '98343190       ',332 } )
	AADD( APRODS, { '98343290       ',95 } )
	AADD( APRODS, { '98343490       ',61 } )
	AADD( APRODS, { '98343590       ',58 } )
	AADD( APRODS, { '98343690       ',803 } )
	AADD( APRODS, { '98343890       ',248 } )
	AADD( APRODS, { '98344190       ',318 } )
	AADD( APRODS, { '99010790       ',1 } )
	AADD( APRODS, { '99011490       ',6 } )
	AADD( APRODS, { '99011590       ',8 } )
	AADD( APRODS, { '99011690       ',8 } )
	AADD( APRODS, { '99011790       ',2 } )
	AADD( APRODS, { '99011890       ',4 } )
	AADD( APRODS, { '99012090       ',15 } )
	AADD( APRODS, { '99012190       ',3 } )
	AADD( APRODS, { '99012290       ',3 } )
	AADD( APRODS, { '99012490       ',6 } )
	AADD( APRODS, { '99012990       ',17 } )
	AADD( APRODS, { '99013090       ',2 } )
	AADD( APRODS, { '99013190       ',17 } )
	AADD( APRODS, { '99013490       ',12 } )
	AADD( APRODS, { '99040890       ',1 } )
	AADD( APRODS, { '99040990       ',1 } )
	AADD( APRODS, { '99041090       ',2 } )
	AADD( APRODS, { '99041190       ',2 } )
	AADD( APRODS, { '99043290       ',3 } )
	AADD( APRODS, { '99043590       ',2 } )
	AADD( APRODS, { '99043690       ',10 } )
Else
	aProds := GetProdInv(cLocOri)
EndIf

ProcRegua(LEN(aProds))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inclui Itens no Acols. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nProc := 1 To Len(aProds)


   aProds[nProc,1] := PADR(aProds[nProc,1],LEN(SB2->B2_COD))


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o ultimo item esta em branco e utiliza. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(Acols[Len(aCols),nPosCODOri])
		aAdd( aCols, Array( Len(aHeader) + 1) )
		For _ni := 1 To Len(aHeader)
		    If ALLTRIM(aHeader[_ni,2]) == "D3_ALI_WT"
		       aCols[Len(aCols),_ni] := "SD3"
		    ElseIf ALLTRIM(aHeader[_ni,2]) == "D3_REC_WT"
		       aCols[Len(aCols),_ni] := 0
		    Else
   			   aCols[Len(aCols),_ni] := CriaVar(aHeader[_ni,2])
   			EndIf
		Next
		aCols[Len(aCols),Len(aHeader)+1] := .F.
	EndIf

	//aCols[Len(aCols),Len(aHeader)+1] := .T. //Deletado
	
	//Origem
	aCols[Len(aCols),nPosCODOri] := aProds[nProc,1]
	aCols[Len(aCols),nPosDOri]   := Posicione("SB1",1,xFilial("SB1") + aProds[nProc,1], "B1_DESC")
	aCols[Len(aCols),nPosUMOri]  := Posicione("SB1",1,xFilial("SB1") + aProds[nProc,1], "B1_UM")
	aCols[Len(aCols),nPosLOCOri] := cLocOri
	
	//Destino
	aCols[Len(aCols),nPosCODDes] := aProds[nProc,1]
	aCols[Len(aCols),nPosDDes]   := Posicione("SB1",1,xFilial("SB1") + aProds[nProc,1], "B1_DESC")
	aCols[Len(aCols),nPosUMDes]  := Posicione("SB1",1,xFilial("SB1") + aProds[nProc,1], "B1_UM")
	aCols[Len(aCols),nPosLOCDes] := cLocDes
	
	//aCols[Len(aCols),nPosLoTCTL] := 
	//aCols[Len(aCols),nPosNLOTE]  := 
	
	//aCols[Len(aCols),nPosNSer ]  := 
	
	//aCols[Len(aCols),nPosDTVAL]  := 
	
	aCols[Len(aCols),nPosQUANT]  := aProds[nProc,2]
	aCols[Len(aCols),nPosEstor]  := "N"
	
	//aCols[Len(aCols),nPosLcZOri] := 
	 //aCols[Len(aCols),nPosLcZDes] := 
                                                        

    If  !SB2->(dbSeek(xFilial("SB2")+aProds[nProc,1]+cLocDes)  )
       CriaSB2(aProds[nProc,1],cLocDes)
    
    EndIf
	
Next

RestArea(aAreaSB2)
RestArea(aArea)

Return

Static Function GetProdInv(cLocOri, cDocInvent)

Local cQuery	:= ""
Local cAlias	:= GetNextAlias()

Local aProds	:= {}

Default cLocOri		:= "04"
Default cDocInvent	:= "20190716I"

cQuery := "SELECT * FROM " + RetSqlTab("SB2") + CRLF
cQuery += " WHERE B2_FILIAL = '" + xFilial("SB2") + "' " + CRLF
cQuery += "   AND B2_LOCAL = '" + cLocOri + "' " + CRLF
cQuery += "   AND B2_QATU <> 0 " + CRLF
cQuery += "   AND B2_COD IN ( SELECT B7_COD FROM " + RetSqlTab("SB7") + CRLF
cQuery += "                    WHERE B7_DOC = '" + cDocInvent + "' " + CRLF
cQuery += "                      AND D_E_L_E_T_ = ' ' )" + CRLF
cQuery += "   AND D_E_L_E_T_ <> '*' "

//Finaliza a area do arquivo de execucao da query
If Select(cAlias) > 0
	DbSelectArea(cAlias)
	DbCloseArea()
EndIf

//Executa a query para retornar a quantidade de registros
MsAguarde({|| DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),cAlias, .F., .T.)}, "Analisando produtos...")

While (cAlias)->(!EOF())
	aAdd(aProds, {(cAlias)->B2_COD, (cAlias)->B2_QATU})
	(cAlias)->(DbSkip())
EndDo

Return aProds
