% File: db.pl
%
% Linguagens de Programação
% e-folio B
% 
% by Diogo Antão
% 10/05/2021



% ----- FACTOS -----


% Factos dinâmicos
:- dynamic
    cliente/3,
    artigo/3,
    inventario/2,
    vendas/3.


% --- Cliente ---
% cliente(nome, cidade, risco_credito)

cliente('Daniel', 'Funchal', xxx).
cliente('David', 'Aveiro', aaa).
cliente('Rui', 'Aveiro', bbb).
cliente('Julia', 'Leiria', aaa).
cliente('Jose', 'Caldas da Rainha', aaa).
cliente('Tomas', 'Coimbra', ccc).
cliente('Americo', 'Sintra', bbb).


% --- Artigo ---
% artigo(referencia, nome, quantidade_min_alerta)

artigo(a1, rato_otico, 10).
artigo(a2, teclado_s_fios, 10).
artigo(a3, lcd_15, 10).
artigo(a4, portatil_zen_5013, 10).
artigo(a5, portatil_zen_5050, 10).
artigo(a6, pen_512mb_blue, 10).
artigo(a7, disco_externo_2gb, 10).


% --- Inventario ---
% inventario(referencia, quantidade)

inventario(a1, 10).
inventario(a2, 10).
inventario(a3, 10).
inventario(a4, 78).
inventario(a5, 23).
inventario(a6, 14).
inventario(a7, 8).


% --- Vendas ---
% vendas(cliente, artigo, quantidade)

vendas('Daniel', a1, 12).
vendas('Americo', a4, 1).