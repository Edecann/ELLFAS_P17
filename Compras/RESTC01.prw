#Include 'Protheus.ch'
//#INCLUDE "COMXFUN.CH"
#Include 'FWMVCDEF.ch'

//Alterado Edecan
//Alterado por Kurts

#DEFINE POS_QATU		1
#DEFINE POS_QPEDVEN		2
#DEFINE POS_QEMP		3
#DEFINE POS_SALPEDI		4
#DEFINE POS_QEMPSA		5
#DEFINE POS_RESERVA		6
#DEFINE POS_QTNP		7
#DEFINE POS_QNPT		8
#DEFINE POS_QTER		9
#DEFINE POS_QEMPN		10
#DEFINE POS_QACLASS		11
#DEFINE POS_QEMPPRJ		12
#DEFINE POS_QEMPPRE		13

#DEFINE STR0014 "Atencao"
#DEFINE STR0016 "Voltar"
#DEFINE STR0047 "Qtd.Disponivel"
#DEFINE STR0048 "Sld.Atual"
#DEFINE STR0049 "Qtd.Pedido de Vendas"
#DEFINE STR0053 "Qtd. Reservada"
#DEFINE STR0054 "TOTAL "
#DEFINE STR0062 "Nao registro de estoques para este produto."
#DEFINE STR0100 "Especifico"
		
/*
=====================================================================================
|Programa:             |Autor: Wanderley R. Neto                   |Data: 04/09/2018|
=====================================================================================
|Descri��o: Consulta de saldo multiempresas. Considera o saldo do produto na Ellfas |
| e o de seus produtos alternativos na ARL e MARLIN                                 |
=====================================================================================
|CONTROLE DE ALTERA��ES:                                                            |
=====================================================================================
|Programador          |Data       |Descri��o                                        |
=====================================================================================
|                     |           |                                                 |
=====================================================================================
*/
User Function RESTC01(cAlmox)

Local aArea		:= GetArea()
Local aAreaSB1	:= SB1->(GetArea())
Local aAreaSB2	:= SB2->(GetArea())
Local aAreaSM0	:= SM0->(GetArea())
Local aViewB2	:= {}
Local aStruSB2  := {}
Local aNewSaldo := {}
Local oCursor	:= LoadBitMap(GetResources(),"LBNO")
Local nTotDisp	:= 0
Local nTotExecDisp:=0
Local nSaldo	:= 0
Local nQtPV		:= 0
Local nQemp		:= 0
Local nSalpedi	:= 0
Local nReserva	:= 0
Local nQempSA	:= 0
Local nSaldoSB2:=0
Local nQtdTerc :=0
Local nQtdNEmTerc:=0
Local nSldTerc :=0
Local nQEmpN :=0
Local nQAClass :=0
Local nQEmpPrj  := 0
Local nQEmpPre  := 0
Local nX        := 0
Local nB2_QATU  := 0,nB2_QPEDVEN := 0,nB2_QEMP := 0,nB2_SALPEDI := 0,nB2_QEMPSA := 0,nB2_RESERVA :=0
Local nB2_QTNP  := 0,nB2_QNPT := 0,	nB2_QTER := 0,nB2_QEMPN := 0,nB2_QACLASS := 0,nB2_QPRJ := 0, nB2_QPRE := 0
Local nSldSegUM := 0,nB2_QTSEGUM := 0,nB2_QPEVE2 := 0,nB2_QEMP2 := 0,nB2_SALPED2 := 0,nB2_RESER2 := 0,nB2_QEMPN2 := 0
Local nQtdSegUM :=0,nPedSegUM :=0,nResSegUM :=0,nTot2UM := 0

Local cFilialSB2:= xFilial("SB2")
Local cFilialSB1:= xFilial("SB1")
Local cQuery	:= ''
// Local lViewSB2  := .T.
Local lRetPEAux := .T.
Local lMTVIEWFIL:= ExistBlock("MTVIEWFIL")
Local nAtIni    := 1
Local oListBox, oDlg, oBold

Local cProduto		:= SB1->B1_COD
Local cArmPA		:= SuperGetMv('WS_ARMPA',,'03')	// Armazem do PA

DEFAULT cAlmox := ""



// --------------------------------------------------------------------------
// Posiciona o cadastro de produtos
// --------------------------------------------------------------------------
dbSelectArea('SB1')
dbSetOrder(1)

If MsSeek(cFilialSB1+cProduto) 

    cArmPA   := SB1->B1_LOCPAD //Montes - 26/06/2019 - Considera o Armazem padr�o do produto

	cCursor  := "MAVIEWSB2"
	lQuery   := .T.
	aStruSB2 := SB2->(dbStruct())		
	
	// --------------------------------------------------------------------------
	// Aglutina Saldos do produto na Ellfas com os alternativos na ARL e MARLIN
	// --------------------------------------------------------------------------
	cQuery += CRLF + " Select EMP,SUM(B2_QATU) B2_QATU,sum(B2_QPEDVEN) B2_QPEDVEN,Sum(B2_QEMP) B2_QEMP,Sum(B2_SALPEDI) B2_SALPEDI,Sum(B2_RESERVA) B2_RESERVA,Sum(B2_QEMPSA)B2_QEMPSA,Sum(B2_QTNP)B2_QTNP,Sum(B2_QNPT)B2_QNPT,Sum(B2_QTER)B2_QTER,Sum(B2_QEMPN)B2_QEMPN,Sum(B2_QACLASS)B2_QACLASS, '' B2_STATUS, '"+ cArmPA +"' B2_LOCAL, 0 B2_QEMPPRJ,  0 B2_QEMPPRE"
	cQuery += CRLF + "       ,sum(B2_QTSEGUM) B2_QTSEGUM,sum(B2_QPEDVE2) B2_QPEDVE2,sum(B2_QEMP2) B2_QEMP2,sum(B2_SALPED2) B2_SALPED2,sum(B2_RESERV2) B2_RESERV2,sum(B2_QEMPN2) B2_QEMPN2,max(B1_CONV) B1_CONV,max( B1_TIPCONV) B1_TIPCONV   from "
	cQuery += CRLF + " (SELECT 'ELLFAS' EMP,B2_QATU,B2_QPEDVEN,B2_QEMP,B2_SALPEDI,B2_RESERVA,B2_QEMPSA,B2_QTNP,B2_QNPT,B2_QTER,B2_QEMPN,B2_QACLASS "
    cQuery += CRLF + "         ,B2_QTSEGUM,B2_QPEDVE2,B2_QEMP2,B2_SALPED2,B2_RESERV2,B2_QEMPN2,B1_CONV,B1_TIPCONV   "
	cQuery += CRLF + "   FROM "+ RetSqlName('SB2') +" SB2"
	cQuery += CRLF + "   inner join "+ RetSqlName('SB1') +" SB1 "
	cQuery += CRLF + "      on B2_COD = B1_COD"
	cQuery += CRLF + "  WHERE SB1.D_E_L_E_T_ <> '*'" 																									
	cQuery += CRLF + "    and SB2.D_E_L_E_T_ <> '*'	"
	cQuery += CRLF + "    AND B1_FILIAL='"+ cFilialSB1 +"' "
	cQuery += CRLF + "    AND B2_FILIAL='"+ cFilialSB2 +"' "
	cQuery += CRLF + "    and B2_LOCAL = '"+ cArmPA +"'	"
	cQuery += CRLF + "    AND B2_STATUS <> '2' "
	cQuery += CRLF + "    and (B1_COD = '"+ cProduto +"'"
    cQuery += CRLF + "     or B1_COD IN (select B1_COD from SB1010 SB1SUB where SB1SUB.D_E_L_E_T_ = '' and B1_ALTER='"+ cProduto +"' ))"
	cQuery += CRLF + " Union All"
	cQuery += CRLF + " SELECT 'ARL',B2_QATU,B2_QPEDVEN,B2_QEMP,B2_SALPEDI,B2_RESERVA,B2_QEMPSA,B2_QTNP,B2_QNPT,B2_QTER,B2_QEMPN,B2_QACLASS "
	cQuery += CRLF + "         ,B2_QTSEGUM,B2_QPEDVE2,B2_QEMP2,B2_SALPED2,B2_RESERV2,B2_QEMPN2,'',''  "
	cQuery += CRLF + "   FROM SB2020 SB2"
	cQuery += CRLF + "   inner join "+ RetSqlName('SB1') +" SB1	"
	cQuery += CRLF + "      on B2_COD = B1_COD"
	cQuery += CRLF + "  WHERE SB1.D_E_L_E_T_ <> '*' 	"
	cQuery += CRLF + "    and SB2.D_E_L_E_T_ <> '*'"
	cQuery += CRLF + "    AND B1_FILIAL='"+ cFilialSB1 +"' "
	cQuery += CRLF + "    AND B2_FILIAL='"+ cFilialSB2 +"' "
	cQuery += CRLF + "    and B2_LOCAL = '"+ cArmPA +"'	"
	cQuery += CRLF + "    AND B2_STATUS <> '2' "
	cQuery += CRLF + "    and B1_COD IN (select B1_COD from SB1010 SB1SUB where SB1SUB.D_E_L_E_T_ = '' and B1_ALTER='"+ cProduto +"' )"
	//cQuery += CRLF + "    and B1_COD <> '"+ cProduto +"'"
	cQuery += CRLF + " Union All"
	cQuery += CRLF + " SELECT 'MARLIN',B2_QATU,B2_QPEDVEN,B2_QEMP,B2_SALPEDI,B2_RESERVA,B2_QEMPSA,B2_QTNP,B2_QNPT,B2_QTER,B2_QEMPN,B2_QACLASS" 
	cQuery += CRLF + "         ,B2_QTSEGUM,B2_QPEDVE2,B2_QEMP2,B2_SALPED2,B2_RESERV2,B2_QEMPN2,'',''  "
	cQuery += CRLF + "   FROM SB2030 SB2"
	cQuery += CRLF + "   inner join "+ RetSqlName('SB1') +" SB1	"
	cQuery += CRLF + "      on B2_COD = B1_COD"
	cQuery += CRLF + "  WHERE SB1.D_E_L_E_T_ <> '*' "
	cQuery += CRLF + "    and SB2.D_E_L_E_T_ <> '*'"
	cQuery += CRLF + "    AND B1_FILIAL='"+ cFilialSB1 +"' "
	cQuery += CRLF + "    AND B2_FILIAL='"+ cFilialSB2 +"' "
	cQuery += CRLF + "    and B2_LOCAL = '"+ cArmPA +"'	"
	cQuery += CRLF + "    AND B2_STATUS <> '2' "
	cQuery += CRLF + "    and B1_COD IN (select B1_COD from SB1010 SB1SUB where SB1SUB.D_E_L_E_T_ = '' and B1_ALTER='"+ cProduto +"' )"
	//cQuery += CRLF + "    and B1_COD <> '"+ cProduto +"'"
	cQuery += CRLF + "    ) as Q1"
	cQuery += CRLF + " Group By EMP "
	
	cQuery := ChangeQuery(cQuery)
	
	SB2->(dbCommit())			
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cCursor,.T.,.T.)
	
	For nX := 1 To Len(aStruSB2)
		If aStruSB2[nX][2]<>"C"
			TcSetField(cCursor,aStruSB2[nX][1],aStruSB2[nX][2],aStruSB2[nX][3],aStruSB2[nX][4])
		EndIf
	Next nX
	
	dbSelectArea(cCursor)
	While ( !Eof() )

		nSaldoSB2 := SaldoSB2(,,,,,cCursor)			
		nSldSegUM := iif(SB1->B1_TIPCONV=='D',nSaldoSB2/SB1->B1_CONV,nSaldoSB2*SB1->B1_CONV) //nSldSegUM := iif((cCursor)->B1_TIPCONV=='D',nSaldoSB2/(cCursor)->B1_CONV,nSaldoSB2*(cCursor)->B1_CONV)

		nB2_QATU    := (cCursor)->B2_QATU
		nB2_QPEDVEN := (cCursor)->B2_QPEDVEN
		// nB2_QEMP    := (cCursor)->B2_QEMP
		// nB2_SALPEDI := (cCursor)->B2_SALPEDI
		// nB2_QEMPSA  := (cCursor)->B2_QEMPSA
		nB2_RESERVA := (cCursor)->B2_RESERVA
		// nB2_QTNP    := (cCursor)->B2_QTNP
		// nB2_QNPT    := (cCursor)->B2_QNPT
		// nB2_QTER    := (cCursor)->B2_QTER
		// nB2_QEMPN   := (cCursor)->B2_QEMPN
		// nB2_QACLASS := (cCursor)->B2_QACLASS
		nB2_QTSEGUM := (cCursor)->B2_QTSEGUM 
		nB2_QPEVE2  := (cCursor)->B2_QPEDVE2 
		nB2_RESER2  := (cCursor)->B2_RESERV2 

		aAdd(aViewB2,{AllTrim((cCursor)->EMP),;
			TransForm(nSaldoSB2,PesqPict("SB2","B2_QATU")),;
			TransForm(nSldSegUM,PesqPict("SB2","B2_QATU")),;
			TransForm(nB2_QATU,PesqPict("SB2","B2_QATU")),;
			TransForm(nB2_QTSEGUM,PesqPict("SB2","B2_QTSEGUM")),;
			TransForm(nB2_QPEDVEN,PesqPict("SB2","B2_QPEDVEN")),;
			TransForm(nB2_QPEVE2,PesqPict("SB2","B2_QPEDVE2")),;
			TransForm(nB2_RESERVA,PesqPict("SB2","B2_RESERVA")),;
			TransForm(nB2_RESER2,PesqPict("SB2","B2_RESERV2"))})
			
		    /*TransForm(nB2_QNPT,PesqPict("SB2","B2_QNPT")),;
			TransForm(nB2_QTER,PesqPict("SB2","B2_QTER")),;
			TransForm(nB2_QEMPN,PesqPict("SB2","B2_QEMPN")),;
			TransForm(nB2_QACLASS,PesqPict("SB2","B2_QACLASS"))})*/
			
		If !Empty(cAlmox) .And. cAlmox == (cCursor)->B2_LOCAL
			nAtIni := Len(aViewB2)
		EndIf

		nTotDisp	+= nSaldoSB2
		nSaldo		+= nB2_QATU
		nQtPV		+= nB2_QPEDVEN
		// nQemp		+= nB2_QEMP
		// nSalpedi	+= nB2_SALPEDI
		nReserva	+= nB2_RESERVA
		// nQempSA		+= nB2_QEMPSA
		// nQtdTerc	+= nB2_QTNP
		// nQtdNEmTerc	+= nB2_QNPT
		// nSldTerc	+= nB2_QTER
		// nQEmpN		+= nB2_QEMPN
		// nQAClass	+= nB2_QACLASS
		nTot2UM   += nSldSegUM 
		nQtdSegUM += (cCursor)->B2_QTSEGUM 
		nPedSegUM += (cCursor)->B2_QPEDVE2 
		nResSegUM += (cCursor)->B2_RESERV2 
		
		dbSelectArea(cCursor)
		dbSkip()
	EndDo
	If lQuery
		dbSelectArea(cCursor)
		dbCloseArea()
		dbSelectArea("SB2")
	EndIf


	If !Empty(aViewB2)
		
		DEFINE FONT oBold NAME "Arial" SIZE 0, -12 BOLD
		DEFINE MSDIALOG oDlg FROM 000,000  TO 500,600 TITLE "Saldos em Estoque - ARMAZ�M "+cArmPA Of oMainWnd PIXEL 
		@ 023,004 To 24,296 Label "" of oDlg PIXEL
		@ 113,004 To 114,296 Label "" of oDlg PIXEL
		//"Local"###"Qtd.Disponivel"###"Sld.Atual"###"Qtd.Pedido de Vendas"###"Qtd. Reservada"   
		oListBox := TWBrowse():New( 30,2,297,69,,{'Emp',STR0047,'Disponivel 2� UM',STR0048,'Saldo 2� UM',STR0049,'Qtd Ped. 2� UM',STR0053,'Reserva 2� UM'},{17,55,55,55,55,55,55,55},oDlg,,,,,,,,,,,,.F.,,.T.,,.F.,,,)  
		oListBox:SetArray(aViewB2)
		oListBox:bLine := { || aViewB2[oListBox:nAT]}
		oListBox:nAt   := Max(1,nAtIni)
		@ 004,010 SAY SM0->M0_CODIGO+"/"+FWCodFil()+" - "+SM0->M0_FILIAL+"/"+SM0->M0_NOME  Of oDlg PIXEL SIZE 245,009
		@ 014,010 SAY Alltrim(cProduto)+ " - "+SB1->B1_DESC Of oDlg PIXEL SIZE 245,009 FONT oBold
		@ 104,010 SAY STR0054 Of oDlg PIXEL SIZE 30 ,9 FONT oBold  //"TOTAL "
		
		@ 120,007 SAY "Quantidade Disponivel    " of oDlg PIXEL //
		@ 119,075 MsGet nTotDisp Picture PesqPict("SB2","B2_QATU") of oDlg PIXEL SIZE 070,009 When .F.
		
		@ 120,155 SAY "Quantidade Dispo 2� UM " of oDlg PIXEL //
		@ 119,223 MsGet nQtdSegUM Picture PesqPict("SB2","B2_QEMP") of oDlg PIXEL SIZE 070,009 When .F.
		
		@ 135,007 SAY "Saldo Atual   " of oDlg PIXEL //
		@ 134,075 MsGet nSaldo Picture PesqPict("SB2","B2_QATU") of oDlg PIXEL SIZE 070,009 When .F.
		
		@ 135,155 SAY "Saldo 2� UM" of oDlg PIXEL //
		@ 134,223 MsGet nTot2UM Picture PesqPict("SB2","B2_SALPEDI") of oDlg PIXEL SIZE 070,009 When .F.
		
		@ 150,007 SAY "Qtd. Pedido de Vendas  " of oDlg PIXEL //
		@ 149,075 MsGet nQtPv Picture PesqPict("SB2","B2_QPEDVEN") of oDlg PIXEL SIZE 070,009 When .F.
		
		@ 150,155 SAY "Qtd. Pedido 2� UM  " of oDlg PIXEL //
		@ 149,223 MsGet nPedSegUM Picture PesqPict("SB2","B2_RESERVA") of oDlg PIXEL SIZE 070,009 When .F.
		
		@ 165,007 SAY "Qtd. Reservada" of oDlg PIXEL //
		@ 164,075 MsGet nReserva Picture PesqPict("SB2","B2_QEMPSA") of oDlg PIXEL SIZE 070,009 When .F.
		
		@ 165,155 SAY 'Qtd. Reserva 2� UM' of oDlg PIXEL
		@ 164,223 MsGet nResSegUM Picture PesqPict("SB2","B2_QTNP") of oDlg PIXEL SIZE 070,009 When .F.
		
		// @ 180,007 SAY RetTitle("B2_QNPT") of oDlg PIXEL
		// @ 179,075 MsGet nQtdNEmTerc Picture PesqPict("SB2","B2_QNPT") of oDlg PIXEL SIZE 070,009 When .F.
		
		// @ 180,155 SAY RetTitle("B2_QTER") of oDlg PIXEL 
		// @ 179,223 MsGet nSldTerc Picture PesqPict("SB2","B2_QTER") of oDlg PIXEL SIZE 070,009 When .F.

		// @ 195,007 SAY RetTitle("B2_QEMPN") of oDlg PIXEL 
		// @ 194,075 MsGet nQEmpN Picture PesqPict("SB2","B2_QEMPN") of oDlg PIXEL SIZE 070,009 When .F.

		// @ 195,155 SAY RetTitle("B2_QACLASS") of oDlg PIXEL 
		// @ 194,223 MsGet nQAClass Picture PesqPict("SB2","B2_QACLASS") of oDlg PIXEL SIZE 070,009 When .F.

   
		//��������������������������������������������������������������������������������������Ŀ
		//� Ponto de entrada para incluir campos na grid  e edits na tela de Consulta ao estoque �
		//����������������������������������������������������������������������������������������
		If ExistBlock("MTGRDVW")                                   
			ExecBlock("MTGRDVW",.F.,.F.,{@aViewB2,@oListBox,@oDlg})
		Endif 
		
		//������������������������������������������������������������������������Ŀ
		//� Ponto de entrada para incluir Botao do Usuario na Dialog Saldos do SB2 �
		//��������������������������������������������������������������������������
		If ExistBlock("BVIEWSB2") 
			@ 230,190 BUTTON STR0100 SIZE 045,010  FONT oDlg:oFont ACTION (ExecBlock("BVIEWSB2",.F.,.F.)) Of oDlg PIXEL //"Especifico"
		Endif

		@ 230,244  BUTTON STR0016 SIZE 045,010  FONT oDlg:oFont ACTION (oDlg:End())  OF oDlg PIXEL  //"Voltar"

		ACTIVATE MSDIALOG oDlg CENTERED
	Else
		Aviso(STR0014,STR0062,{STR0016},2) //"Atencao"###"Nao registro de estoques para este produto."###"Voltar"
	EndIf	
EndIf
RestArea(aAreaSM0)
RestArea(aAreaSB2)
RestArea(aAreaSB1)
RestArea(aArea)

Return(.T.)

/*
=====================================================================================
|Programa:             |Autor: Wanderley R. Neto                   |Data: 04/09/2018|
=====================================================================================
|Descri��o: Rotina que informa o saldo dos produtos alternativos                    |
|                                                                                   |
=====================================================================================
*/
Static Function SB2Alter(cProduto, cArmPA)

Local aSB2				:= {}
Local aSaldo			:= {}
Local cQuery			:= ''
Local cFilSB2			:= xFilial('SB2')
Local cAliasAlt			:= GetNextAlias()

// -------------------------------------------------------------------
// ARL
// -------------------------------------------------------------------
cQuery += CRLF + "SELECT B2_COD, B1_COD,B1_ALTER,* "
cQuery += CRLF + "  FROM SB2020 SB2 "	//ARL
cQuery += CRLF + " inner join "+ RetSqlName('SB1') +" SB1 "
cQuery += CRLF + "     on B2_COD = B1_COD "
cQuery += CRLF + " WHERE SB1.D_E_L_E_T_ <> '*'  "
cQuery += CRLF + "   and SB2.D_E_L_E_T_ <> '*' "
cQuery += CRLF + "   AND B2_FILIAL='" + cFilSB2 + "'  "
cQuery += CRLF + "   and B2_LOCAL = '"+ cArmPA +"' "	// Armazem de PA
cQuery += CRLF + "   AND B2_STATUS <> '2'  "
cQuery += CRLF + "   and B1_COD IN (select B1_COD from SB1010 SB1SUB where SB1SUB.D_E_L_E_T_ = '' and B1_ALTER='" +cProduto+ "' ) "
cQuery += CRLF + "   and B1_COD <> '" +cProduto+ "' "

cQuery += CRLF + "	 UNION "
// -------------------------------------------------------------------
// MARLIN
// -------------------------------------------------------------------
cQuery += CRLF + "SELECT B2_COD, B1_COD,B1_ALTER,* "
cQuery += CRLF + "  FROM SB2030 SB2 "
cQuery += CRLF + " inner join "+ RetSqlName('SB1') +" SB1 "
cQuery += CRLF + "     on B2_COD = B1_COD "
cQuery += CRLF + " WHERE SB1.D_E_L_E_T_ <> '*'  "
cQuery += CRLF + "   and SB2.D_E_L_E_T_ <> '*' "
cQuery += CRLF + "   AND B2_FILIAL='" + cFilSB2 + "'  "
cQuery += CRLF + "   and B2_LOCAL = '"+ cArmPA +"' "	// Armazem de PA
cQuery += CRLF + "   AND B2_STATUS <> '2'  "
cQuery += CRLF + "   and B1_COD IN (select B1_COD from SB1010 SB1SUB where SB1SUB.D_E_L_E_T_ = '' and B1_ALTER='" +cProduto+ "' ) "
cQuery += CRLF + "   and B1_COD <> '" +cProduto+ "' "


dbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasAlt,.F., .F.)

While (cAliasAlt)->( ! Eof() )

		AAdd(aSaldo,(cAliasAlt)->B2_QATU)		// POS_QATU	
		AAdd(aSaldo,(cAliasAlt)->B2_QPEDVEN)	// POS_QPEDVEN
		AAdd(aSaldo,(cAliasAlt)->B2_QEMP)		// POS_QEMP	
		AAdd(aSaldo,(cAliasAlt)->B2_SALPEDI)	// POS_SALPEDI
		AAdd(aSaldo,(cAliasAlt)->B2_QEMPSA)	// POS_QEMPSA
		AAdd(aSaldo,(cAliasAlt)->B2_RESERVA)	// POS_RESERVA
		AAdd(aSaldo,(cAliasAlt)->B2_QTNP)		// POS_QTNP	
		AAdd(aSaldo,(cAliasAlt)->B2_QNPT)		// POS_QNPT	
		AAdd(aSaldo,(cAliasAlt)->B2_QTER)		// POS_QTER	
		AAdd(aSaldo,(cAliasAlt)->B2_QEMPN)	// POS_QEMPN
		AAdd(aSaldo,(cAliasAlt)->B2_QACLASS)	// POS_QACLASS

		AAdd(aSB2, aSaldo)

	(cAliasAlt)->( DbSkip() )
End

(cAliasAlt)->(dbCloseArea())

Return aSB2


/*
=====================================================================================
|Programa:             |Autor: Wanderley R. Neto                   |Data: 10/09/2018 |
=====================================================================================
|Descri��o: Rotina que monta uma browse com os produtos para acesso dos vendedores  |
|  que n�o possuem acesso ao cadastro dos produtos.                                 |
=====================================================================================
*/
User Function RESTC01V()

Local oBrowse		:= Nil
Private aRotina		:= MenuDef()

dbSelectArea('SB1')
SB1->(DBSetOrder(1))

// Instancia Browse
oBrowse := FWMBrowse():New()
oBrowse:SetAlias("SB1")
oBrowse:SetDescription("Consulta de Estoque - Multiempresas") 

oBrowse:Activate()

Return

/*
=====================================================================================
|Programa: Menudef    |Autor: Wanderley R. Neto                   |Data: 10/09/2018 |
=====================================================================================
|Descri��o: Define menu da rotina                                                   |
|                                                                                   |
=====================================================================================
*/

Static Function MenuDef()

Local aRotina		:= {}

ADD OPTION aRotina Title 'Consultar'	Action 'U_RESTC01' OPERATION 4 ACCESS 0

Return aRotina