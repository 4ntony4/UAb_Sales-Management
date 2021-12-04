% File: smallSalesManagement.pl
%
% Linguagens de Programação
% e-folio B
% 
% by Diogo Antão
% 10/05/2021



% Consultar ficheiro que contém os factos
:- [db].



% ----- PREDICADOS -----


write_list([]) :- nl.
write_list([X|Y]) :-
    write(X), nl, write_list(Y).


% ----- listar_cliente
lc :-
    findall( (X,Y,Z), cliente(X,Y,Z), List),
    write_list(List).


% ----- listar_cliente_bom
lcb :-
    findall( (X,Y), cliente(X,Y,aaa), List),
    write_list(List).


% ----- total_cliente_cidade
tcc(Cidade) :-
  findall(X, cliente(X,Cidade,_), List),
  length(List, Total),
  format('~w tem ~w cliente(s).', [Cidade, Total]).


% ----- listar_cliente_vendas
lcv :-
    findall((X,Y,Z), vendas(X,Y,Z), List),
    write_list(List).


% ----- inventario_quantidade_stock
iqs(Ref) :-
    findall( (X,Y), inventario(X,Y), List),

    % caso a referência do artigo exista 
    once(member((Ref,Y), List)) ->
    inventario(Ref, Total),
    format('Esta ref tem ~w artigo(s).', [Total]);
    
    % caso a referência do artigo não exista
    write('Esta ref ainda nao existe.'), nl,
    write('Insira o nome do artigo: '), nl,
    read(Nome),
    write('Insira a quantidade de stock: '), nl,
    read(Qtd),
    
    % caso a quantidade inserida seja um inteiro
    integer(Qtd) ->
    assertz(inventario(Ref, Qtd)),
    assertz(artigo(Ref, Nome, 10)),
    write('Ref inserida com sucesso!');

    % caso a quantidade inserida não seja um inteiro
    write('Quantidade invalida.'), nl,
    write('Artigo nao inserido.').


% ----- artigo_verificar_abaixo_min_alerta
avama(Ref) :-
    artigo(Ref,_,QtdMin),!,
    inventario(Ref, Qtd),
    sub_avama(Qtd, QtdMin).

avama(_) :-
    write('Artigo nao encontrado.').

sub_avama(Qtd, QtdMin) :-
    Qtd < QtdMin ->
    write('ALERTA! Este artigo tem o stock em baixo!');

    Qtd >= QtdMin ->
    write('Este artigo nao tem falta de stock.').


% ----- venda_validar_artigo_cliente
vvac(Cliente, Art, QtdVenda) :-
    inventario(Art, QtdStock),
    QtdStock - QtdVenda >= 0,
    once(cliente(Cliente,_,aaa)).


% ----- inventario_atualiza_artigo
iaa(Ref, NovaQtd) :-
    inventario(Ref, QtdStock) ->
    sub_iaa(Ref, QtdStock, NovaQtd);

    write('O artigo nao foi encontrado.').

sub_iaa(Ref, QtdStock, NovaQtd) :-
    QtdStock =:= NovaQtd ->
    write('A quantidade nao foi alterada.');

    retract(inventario(Ref, QtdStock)),
    assertz(inventario(Ref, NovaQtd)) ->
    write('Artigo atualizado.').


% ----- venda_artigo_cliente
vac :-
    write('Insira o nome do cliente: '), nl,
    read(Cliente),
    write('Insira a ref do artigo: '), nl,
    read(Ref), 
    write('Insira a quantidade: '), nl,
    read(QtdVenda),
    integer(QtdVenda) ->
    sub_vac(Cliente, Ref, QtdVenda);
    
    % caso a quantidade inserida não seja um inteiro
    write('Quantidade invalida.').

sub_vac(Cliente, Ref, QtdVenda) :-
    vvac(Cliente, Ref, QtdVenda) ->
    inventario(Ref, QtdStock),
    QtdFinal is QtdStock - QtdVenda,
    retract(inventario(Ref, QtdStock)),
    assertz(inventario(Ref, QtdFinal)),
    assertz(vendas(Cliente, Ref, QtdVenda)),
    write('Venda validada.');

    % caso não tenha havido validacao
    write('Nao houve validacao para esta venda.').


% ----- inventario_relatorio
ir :-
    findall( (X,Y), inventario(X,Y), List),
    sort(List,Sorted),
    write_list(Sorted).


% ----- listar_artigos
la :-
    findall( (X,Y,Z), artigo(X,Y,Z), List),
    write_list(List).


% ----- listar_inventario
li :- ir.
