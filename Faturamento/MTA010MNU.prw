#Include 'Protheus.ch'

/*
=====================================================================================
|Programa:             |Autor: Wanderley R. Neto                   |Data: 04/09/2018|
=====================================================================================
|Descri��o: PE para adicionar rotinas no menu do cadastro de produtos               |
|                                                                                   |
=====================================================================================
|CONTROLE DE ALTERA��ES:                                                            |
=====================================================================================
|Programador          |Data       |Descri��o                                        |
=====================================================================================
|                     |           |                                                 |
=====================================================================================
*/
User Function MTA010MNU

aAdd(aRotina, { 'Estoque Emp' ,"u_RESTC01"		, 0 , 2} )	//Consulta de estoque multiempresas

Return Nil