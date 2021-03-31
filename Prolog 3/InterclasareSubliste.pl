% Prolog 2
%
% Problema 4.
% b) Se da o lista eterogena, formata din numere intregi si liste de numere
% sortate. Sa se interclaseze fara pastrarea dublurilor toate sublistele.
% De exemplu:
% [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8] =>
% [1, 2, 3, 4, 6, 7, 9, 10, 11].
%
% Rezolvare 4.b)
%
% Model matematic:
% interclasareListaEterogena(l1,...,ln) = { [], daca l este vida
%					    interclasareListe(l1,interclasareListaEterogena(l2,...,ln)),
%					    daca l1 este lista
%					    interclasareListaEterogena(l2,...,ln),daca
%					    l1 este numar }
%
% interclasareListe(l1,...,ln,p1,...,pm) = {p, daca n = 0
%				            l, daca m = 0
%					    interclasareListe(l2,...ln,p1,...pm, daca l1 < p1
%					    interclasareListe(lx+1,...ln, daca x < n
%					    interclasareListe(py+1,...pm, daca y < m}
%
% duplicate(l1,...,ln) = { null, daca n = 0
%			   duplicate(l1,...,ln), daca l1 nu mai apare in l
%			   duplicate(l2,...,ln), altfel}

% Implementare in Prolog
%
% duplicate(L: List, R: List)
% model de flux: (i, o) determinist
% L - Lista de intregi din care se elimina elementele duplicate
% R - Lista rezultata
%
duplicate([], []).
duplicate([H|T1], R) :-
	member(H, T1),
	!,
	duplicate(T1, R).
duplicate([H|T1],[H|T2]) :-
	duplicate(T1, T2).
%
% interclasareListe(L1: List, L2: List, R: List)
% model de flux: (i, i, o)  determinist
% L1 - Prima lista
% L2 - A doua lista
% R - Lista rezultata prin interclasarea lui L1 cu L2
%
interclasareListe([], L, R):-
	duplicate(L, R).
interclasareListe(L, [], R):-
	duplicate(L, R).
interclasareListe([H1|T1], [H2|T2], [H1|T3]) :-
	H1 < H2,
	!,
	interclasareListe(T1, [H2|T2], T3).
interclasareListe([H1|T1], [H1|T2], [H1|T3]) :-
	interclasareListe(T1, T2, T3),
	!.
interclasareListe([H1|T1], [H2|T2], [H2|T3]) :-

	interclasareListe([H1|T1], T2, T3).
%
% interclasareListaEterogena(L : List, R: List)
% model de flux: (i, o) determinist
% L - Lista eterogena
% R - Lista de intregi
%
interclasareListaEterogena([], []).
interclasareListaEterogena([H|T], R) :-
	is_list(H),
	!,
	interclasareListaEterogena(T, Aux),
	interclasareListe(H, Aux, R).
interclasareListaEterogena([_|T], R):-
	interclasareListaEterogena(T, R).
