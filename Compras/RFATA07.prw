#INCLUDE "TOTVS.CH"
#INCLUDE "PARMTYPE.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FWMBROWSE.CH"
#INCLUDE "FWMVCDEF.CH"


/*/{Protheus.doc} RFATA07
// Cria um cadastro modelo 2 para o relacionamento
// do Cliente x tabela de preço
@author vinicius Alcantara
@since 12/03/2019
@version 1.0
@return ${return}, ${return_description}
@type function
/*/User Function RFATA07()
Local cFiltro		:= ''
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de Variaveis locais.                     	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private oBrowse		:= Nil
Private cTabela		:= "PA2" // Defina aqui a Tabela para edicao
Private cCadastro 	:= Capital(FwX2Nome(cTabela))
Private aRotina		:= MenuDef()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria objeto FWBROWSE.                               	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oBrowse := FWMBrowse():New()
oBrowse:SetAlias(cTabela)
oBrowse:SetDescription(cCadastro)
oBrowse:Activate()

Return Nil


/*/{Protheus.doc} RFATA07A
//Cria a rotina que manipiula a inclusão, alteração e exclusão do cadastro
@author vinic
@since 12/03/2019
@version 1.0
@return ${return}, ${return_description}
@param cAlias, characters, description
@param nRec, numeric, description
@param nOpcx, numeric, description
@type function
/*/User Function RFATA07A(cAlias,nRec,nOpcx)
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

Private nUsado	:= 0
Private aHeader	:= {}
Private aCols	:= {}
Private aRecNo	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona a filial corrente ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private _cCodFil := xFilial("PA2")
Private cCliente := ""
Private cLojaCli
Private cVldNomeCli := ''
Private nQ
Private cTitulo
Private aC
Private aR
Private aCoord
Private CLINHAOK
Private CTUDOOK
Private lRetMod2
Private N

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(cTabela)
While !Eof() .And. (X3_ARQUIVO == cTabela)
	If X3USO(X3_USADO) .And. cNivel >= X3_NIVEL
		If ! AllTrim(X3_CAMPO) $ "PA2_FILIAL;PA2_CLIENT;PA2_LOJA"
			nUsado:=nUsado+1
			Aadd(aHeader,{ AllTrim(X3_TITULO),;
			X3_CAMPO	, X3_PICTURE,;
			X3_TAMANHO	, X3_DECIMAL,;
			X3_VALID 	, X3_USADO	,;
			X3_TIPO		, X3_ARQUIVO,X3_CONTEXT } )
		EndIf
	EndIf
	dbSkip()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona o Cabecalho da Tabela a ser editada (cTabela) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cTabela)
dbSetOrder(2)
dbSeek(_cCodFil + PA2->( PA2_CLIENTE + PA2_LOJA))
dbSetOrder(1)

RegToMemory(cTabela,nOpcx = 3)

cCliente := PA2->PA2_CLIENTE
cLojaCli := PA2->PA2_LOJA

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols - Posiciona os itens da tabela conforme a filial corrente ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nOpcx = 3
	Aadd(aCols ,Array(Len(aHeader) + 1))

	For nQ:=1 To Len(aHeader)
		aCols[Len(aCols),nQ] := CriaVar( FieldName(FieldPos(aHeader[nQ,2])))
	Next nQ

	Aadd(aCols[1],.F.)

Else
	While !Eof() .And. PA2->PA2_FILIAL == _cCodFil ;
	.And. PA2->PA2_CLIENTE == cCliente .And. PA2->PA2_LOJA == cLojaCli
		Aadd(aCols ,Array(Len(aHeader) + 1))
		Aadd(aRecNo,Array(Len(aHeader) + 1))
		For nQ:=1 to nUsado
			aCols[Len(aCols),nQ]  := FieldGet(FieldPos(aHeader[nQ,2]))
			aRecNo[Len(aCols),nQ] := FieldGet(FieldPos(aHeader[nQ,2]))
		Next
		aRecNo[Len(aCols),nUsado+1] := RecNo()
		aCols[Len(aCols),nUsado+1]  := .F.
		dbSelectArea("PA2")
		dbSkip()
	EndDo

EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Rodape do Modelo 2 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLinGetD:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo da Janela ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpcx == 3
	cNomeCli := SPACE(TamSx3("A1_NREDUZ")[1])
Else
	cNomeCli := Capital(Posicione("SA1",1,xFilial("SA1") + cCliente + cLojaCli,"A1_NREDUZ"))
EndIf

cTitulo := cNomeCli
cVldNomeCli := "(IIF(ExistCpo('SA1',cCliente+cLojaCli),(cNomeCli := POSICIONE('SA1',1,xFilial('SA1')+cCliente+cLojaCli,'A1_NREDUZ'),.T.),(cNomeCli := SPACE(TamSx3('A1_NREDUZ')[1]),.F.)))"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aC:={}

Aadd(aC,{"cCliente" ,{C(15), C(010)}	,RetTitle("PA2_CLIENTE"),"@!","","SA1",.T.})
Aadd(aC,{"cLojaCli"	,{C(15), C(060)}	,RetTitle("PA2_LOJA")	,"@!",cVldNomeCli,"",.T.})
Aadd(aC,{"cNomeCli"	,{C(15), C(090)} 	,OemToAnsi("Cliente")	,"@!"," ","",.F.})

/*Array para get no rodape da Tela estilo modelo2. Parametros:
aR[n,1] =  Nome da Variavel Ex.:"cCliente"
aR[n,2] =  Array com coordenadas do Get [x,y], em Windows estao em PIXEL
aR[n,3] =  Titulo do Campo
aR[n,4] =  Picture
aR[n,5] =  Nome da funcao para validacao do campo
aR[n,6] =  F3
aR[n,7] =  Se campo e' editavel .t. se nao .f.
Ex: AADD(aR,{"nTotal",{120,10},OemToAnsi("Total"),"@E 999,999,999.99",,,.F.})*/

aR:={}

/* Array com coordenadas do modelo2*/
aCoord := { C(053), C(005), C(118), C(315) }
aTamWnd:= { C(100), C(100), C(400), C(750) }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinhaOk:= "AllwaysTrue()"//"(!Empty(aCols[n,2]) .Or. aCols[n,3])"
cTudoOk := "AllwaysTrue()"

/*Sintaxe
Modelo2(cTitulo, aCabec, aRodape, aGD, nOp, cLineOk, cAllOk, aGetsGD, bF4, cIniCpos, nMax, aCordW, lDelGetD, lMaximized, aButtons)
Parâmetros
cTítulo:	Título da janela
aCabec:		Array com os campos do cabeçalho
aRodapé:	Array com os campos do rodapé
aGd:		Array com as posições para edição dos itens (GETDADOS)
nOp:		Modo de operação (3 ou 4 altera e inclui itens, 6 altera mas não inclui itens, qualquer outro número só visualiza os itens)
cLineOk:	Função para validação da linha
cAllOk:		Função para validação de todos os dados (na confirmação)
aGetsGD:	Array Gets editáveis (GetDados). (Default: Todos)
bF4:		Codeblock a ser atribuído a tecla F4. (Default: Nenhum)
cIniCpos:	String com o nome dos campos que devem ser inicializados ao teclar seta para baixo (GetDados).
nMax:		Limita o número de linhas (GetDados). (Default: 99)
aCordW:		Array com quatro elementos numéricos, correspondendo às coordenadas linha superior, coluna esquerda, linha interior e coluna direita, definindo a área de tela a ser usada. (Default: Área de dados livre)
lDelGetD:	Determina se as linhas podem ser deletadas ou não (GetDados) (Default: .T.)
lMaximized:	Indica se a janela será maximizada.
aButtons:	Array com os botões a serem adicionados à EnchoiceBar.*/

lRetMod2 := .F.
n        := 1
lRetMod2 := Modelo2(cTitulo,aC,aR,aCoord,nOpcx,cLinhaOk,cTudoOk,,,,999,aTamWnd,,.T. )

If lRetMod2

	Begin Transaction

		dbSelectArea("PA2")
		dbSetOrder(2) //PA2_FILIAL+PA2_CLIENT+PA2_LOJA+PA2_TABPRV

		For n := 1 to Len(aCols)
			If   nOpcx == 5
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Filial e Chave e a chave indepEndente da descricao		 ³
				//³ que pode ter sido alterada               					 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If dbSeek(_cCodFil + cCliente + cLojaCli + aCols[n,1])
					RecLock("PA2",.F.,.T.)
					dbDelete()
					MsUnlock()
				EndIf
			Elseif  nOpcx == 3
				If ! dbSeek(_cCodFil + cCliente + cLojaCli + aCols[n,1])
					//If aCols[n,2] != SX5->X5_DESCRI
					RecLock("PA2",.T.)
					PA2->PA2_FILIAL 	:= xFilial("PA2")
					PA2->PA2_CLIENTE	:= cCliente
					PA2->PA2_LOJA 		:= cLojaCli
					PA2->PA2_TABPRV		:= aCols[n,1]
					MsUnlock()
				EndIf
			ElseIf nOpcx == 4
				If aCols[n,Len(aHeader)+1] .And. dbSeek(_cCodFil + cCliente + cLojaCli + aCols[n,1])
					RecLock("PA2",.F.,.T.)
					dbDelete()
					MsUnlock()
				Else
					RecLock("PA2",.T.)
					PA2->PA2_FILIAL 	:= xFilial("PA2")
					PA2->PA2_CLIENTE	:= cCliente
					PA2->PA2_LOJA 		:= cLojaCli
					PA2->PA2_TABPRV		:= aCols[n,1]
					MsUnlock()
				EndIf
			EndIf
		Next n

	End Transaction
EndIf

Return


/*/{Protheus.doc} MenuDef
//Cria as opções de menu
@author vinic
@since 12/03/2019
@version 1.0
@return ${return}, ${return_description}

@type function
/*/Static Function MenuDef()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Variaveis locais.                                  	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aRotina := {} //Array utilizado para controlar opcao selecionada

ADD OPTION aRotina TITLE "Pesquisar" 	ACTION 'PesqBrw'         OPERATION 1 ACCESS 0 //'Pesquisar'
ADD OPTION aRotina TITLE "Visualizar" 	ACTION 'U_RFATA07A' OPERATION 2 ACCESS 0 //'Visualizar'
ADD OPTION aRotina TITLE "Incluir" 		ACTION 'U_RFATA07A' OPERATION 3 ACCESS 0 //'Incluir'
ADD OPTION aRotina TITLE "Alterar" 		ACTION 'U_RFATA07A' OPERATION 4 ACCESS 0 //'Alterar'
ADD OPTION aRotina TITLE "Excluir" 		ACTION 'U_RFATA07A' OPERATION 5 ACCESS 0 //'Excluir'

Return aRotina


/*/{Protheus.doc} RFATA07B
//
@author vinic
@since 12/03/2019
@version 1.0
@return ${return}, ${return_description}
@param cFilAux, characters, description
@param cCli, characters, description
@param cLoja, characters, description
@type function
/*/User Function RFATA07B(cFilAux,cCli,cLoja)
Local nOpcA  	:= 0
Local oDlg		:= Nil
Local oList		:= Nil
Local cList		:= ""
Local aList		:= {}
Local oBold		:= Nil
Local cCadastro := Capital(FwX2Nome("PA2"))
Local cRet		:= ''

Default cFilAux := xFilial("SA1")

DbSelectArea("SA1")
SA1->(DbSetOrder(1))

If SA1->(DbSeek(xFilial("SA1")+cCli+cLoja))
	cRet := SA1->A1_TABELA
EndIf

If MsgYesNo(OemToAnsi("Tabela padrão do cliente selecionada ("+AllTrim(cRet)+"), gostaria de alterar?"),OemToAnsi("Alterar tabela de preço"))
	dbSelectArea("PA2")
	PA2->(DbSetOrder(2))

	dbSelectArea("DA0")
	dbSetOrder(1)
	
	If ! PA2->(dbSeek( xFilial("PA2") + cCli + cLoja ))
		Help( ,, 'RFATA07B',, OemToAnsi( "Cliente não possui outras tabelas amarradas, será mantida a tabela padrão do cliente."), 1, 0 )
		Return(cRet)
	EndIf

	/*Populando a lista*/
	While 	!Eof() ; 
			.And. 	PA2->PA2_FILIAL 	== xFilial("PA2") ;
			.And. 	PA2->PA2_CLIENTE	== cCli;
			.And. 	PA2->PA2_LOJA		== cLoja
		
		If DA0->(dbSeek(xFilial("DA0") + PA2->PA2_TABPRV))
			AADD( 	aList,;
					{ 	AllTrim(DA0->DA0_CODTAB),;
						Capital(AllTrim(DA0->DA0_DESCRI)),;
						DtoC(DA0->DA0_DATDE),;
						DtoC(DA0->DA0_DATATE),;
						DA0->DA0_ATIVO})
		EndIf
		
		PA2->(dbSkip())
	EndDo
	
	/*Montagem da tela de exibição*/
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM 0,0 TO 290,550 OF oMainWnd PIXEL
	DEFINE FONT oBold NAME "Arial" SIZE 0, -13 BOLD
	
	@ 14, 10 TO 16 ,272 LABEL '' OF oDlg PIXEL
	@ 03, 10 SAY Capital(Posicione("SA1",1,xFilial("SA1") + cCli + cLoja,"A1_NREDUZ")) FONT oBold PIXEL
	
	@ 020,010 LISTBOX oList VAR cList ;
	FIELDS HEADER ;
	OemToAnsi(RetTitle("DA0_CODTAB"))	,;
	OemToAnsi(RetTitle("DA0_DESCRI"))	,;
	OemToAnsi(RetTitle("DA0_DATDE"))	,;
	OemToAnsi(RetTitle("DA0_DATATE"))	,;
	OemToAnsi(RetTitle("DA0_ATIVO"))	;
	SIZE 260,100 ;
	ON DBLCLICK ( cRet := aList[oList:nAT,1] ,oDlg:End() ) NOSCROLL PIXEL
	
	oList:SetArray(aList)
	oList:bLine := { || { aList[oList:nAT,1],aList[oList:nAT,2],aList[oList:nAT,3]}}
	
	DEFINE SBUTTON FROM 127,210 TYPE 1 ACTION (nOpcA := aList[oList:nAT,1] ,oDlg:End()) ENABLE OF oDlg PIXEL
	DEFINE SBUTTON FROM 127,243 TYPE 2 ACTION (oDlg:End()) ENABLE OF oDlg PIXEL
	
	ACTIVATE MSDIALOG oDlg CENTERED
EndIf

Return(cRet)