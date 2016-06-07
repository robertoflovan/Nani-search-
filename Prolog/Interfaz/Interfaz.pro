:- dynamic
	do/1,
	posición/1,
	oración/1.

:- discontiguous command/2.

%command_loop(comenzar).


command_loop(ComandoEntrada):-
  %repeat,
  write('se ejecutó command_loop'),
  get_command(X,ComandoEntrada),
  do(X).
  %,fail.
  
  

asd :-
	write(asd).

churros(asd).
asd(X) :-
	churros(X),
	write('se escribió desde "asd(X)"').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newSentence(Oración) :-
			retractall(posición(_)),
			retractall(oración(_)),
			asserta(posición(-1)),
			asserta(oración(Oración)).
			
nextSentenceChar(SalidaChar) :-
	posición(N),
	Next is N+1,
	oración(Oración),
	sub_atom(Oración, Next, 1, _, X),
	char_code(X, SalidaChar),
	retractall(posición(_)),
	asserta(posición(Next)).

readlist(L,Oración):-
	concat(Oración,'\n',Formateada),
	newSentence(Formateada),
  %write('> '),
  read_word_list(L).

read_word_list([W|Ws]) :-
  nextSentenceChar(C),
  readword(C, W, C1),       % Read word starting with C, C1 is first new
  restsent(C1, Ws), !.      % character - use it to get rest of sentence

restsent(C,[]) :- lastword(C), !. % Nothing left if hit last-word marker
restsent(C,[W1|Ws]) :-
  readword(C,W1,C1),        % Else read next word and rest of sentence
  restsent(C1,Ws).

readword(C,W,C1) :-         % Some words are single characters
  single_char(C),           % i.e. punctuation
  !, 
  name(W, [C]),             % get as an atom
  nextSentenceChar(C1).
%readword(C, W, C1) :-
%  is_num(C),                % if we have a number --
%  !,
%  number_word(C, W, C1, _). % convert it to a genuine number
readword(C,W,C2) :-         % otherwise if character does not
  in_word(C, NewC),         % delineate end of word - keep
  nextSentenceChar(C1),                 % accumulating them until 
  restword(C1,Cs,C2),       % we have all the word     
  name(W, [NewC|Cs]).       % then make it an atom
readword(C,W,C2) :-         % otherwise
  nextSentenceChar(C1),       
  readword(C1,W,C2).        % start a new word

restword(C, [NewC|Cs], C2) :-
  in_word(C, NewC),
  nextSentenceChar(C1),
  restword(C1, Cs, C2).
restword(C, [], C).


single_char(0',).
single_char(0';).
single_char(0':).
single_char(0'?).
single_char(0'!).
single_char(0'.).


in_word(C, C) :- C >= 0'a, C =< 0'z.
in_word(C, C) :- C == 0'_.
in_word(C, C) :- C =< 0'9, C >= 0'0.
in_word(C, L) :- C >= 0'A, C =< 0'Z, L is C + 32.
in_word(0'',0'').
in_word(0'-,0'-).

% Have character C (known integer) - keep reading integers and build
% up the number until we hit a non-integer. Return this in C1,
% and return the computed number in W.

number_word(C, W, C1, Pow10) :- 
  is_num(C),
  !,
  nextSentenceChar(C2),
  number_word(C2, W1, C1, P10),
  Pow10 is P10 * 10,
  W is integer(((C - 0'0) * Pow10) + W1).
number_word(C, 0, C, 0.1).


is_num(C) :-
  C =< 0'9,
  C >= 0'0.
  
  % These symbols delineate end of sentence

lastword(10).   % end if new line entered
lastword(0'.).
lastword(0'!).
lastword(0'?).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Comprobar comando: command(X,[recoger]).
%Comprobar comando compuesto: command(X,[tomar,el,objeto1]).

%command([Comando], SinonimoDeComando):-  verbo(Comando, SinonimoDeComando-[]).

%Los comandos más simples con los representados por un solo verbo
	%command(OutputList, InputList).
	command([Comando], EnLista):- 
							verbo(Comando, EnLista-[]).
							%verbo(ver, [ver|X]-X).
%comandos compuestos de un verbo y un objeto.
	command([Comando,Objeto], EnLista) :-
 							verbo(Tipo_Objeto, Comando, EnLista-S1),
 							objeto(Tipo_Objeto, Objeto, S1-[]).
 							


							
%	Falta object/3 puede ser precedido 
%	opcionalmente por un artículo (determiner):

	objeto(Tipo, Cosa, S1-S3) :- %Método muy manco para ver numero y genero
	 						determinante(Genero,Numero,S1-S2),
	 						sustantivo(Tipo,Genero,Numero,Cosa,S2-S3).
	  
	objeto(Tipo, Cosa, S1-S2) :-
	 						sustantivo(Tipo,_,_,Cosa, S1-S2).
	 						
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

get_command(C,ComandoEntrada):-
  readlist(L,ComandoEntrada),        % reads a sentence and puts [it,in,list,form]
  command(X,L),    % call the grammar for command
  C =.. X,!.          % make the command list a structure
get_command(_,ComandoEntrada):-
	newWrite,
	appendWrite('Consola&I don''t understand.'), nl, fail.



	do(respuesta_pacto) :- respuesta_pacto.
	do(ayuda) :- ayuda.
	do(ver) :- ver.
	do(inventario) :- inventario.
	do(apagar_luz) :- apagar_luz.
	do(encender_luz) :- encender_luz.
	do(abrir(X)) :- abrir(X).
	do(cerrar(X)) :- cerrar(X).
	do(ir_a(X)) :- ir_a(X).
	do(tomar(X)) :- tomar(X).
	do(soltar(X)) :- soltar(X).
	do(comer(X)) :- comer(X).
	do(colocar_en_mano(X)) :- colocar_en_mano(X) .
	do(guardar_en_mochila(X)) :- guardar_en_mochila(X).
	do(empezar_juego) :- empezar_juego.
	do(respuesta_ver) :- respuesta_ver.
	do(soltar(X, Y)) :- soltar_en(X, Y).
	do(dar(X,Y)) :- dar(X,Y).
	 	
	 	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Prueba dos parámetros %%%%%%%%%%%%%%%%%%%%%%%%%%
%comandos compuestos de un verbo y dos objetos

	command([Comando,Objeto1,Objeto2], EnLista) :-
 							verbo(Tipo_Objeto1,Tipo_Objeto2, Comando, EnLista-S1),
 							objeto(Tipo_Objeto1, Objeto1, S1-S2),
 							determinante2(_,S2-S3),
 							objeto(Tipo_Objeto2, Objeto2, S3-[]),
 							not(contenedor(Objeto2,_)),
 							not(apilador(Objeto2)).
 							
 							
 	command([Comando,Objeto1,Objeto2], EnLista) :-
 							verbo(Tipo_Objeto1,Tipo_Objeto2, Comando, EnLista-S1),
 							objeto(Tipo_Objeto1, Objeto1, S1-S2),
 							determinante2(Tipo_determinante,S2-S3),
 							objeto(Tipo_Objeto2, Objeto2, S3-[]),
 							contenedor(Objeto2,_),
 							Tipo_determinante == contenedor.
 							
 	command([Comando,Objeto1,Objeto2], EnLista) :-
 							verbo(Tipo_Objeto1,Tipo_Objeto2, Comando, EnLista-S1),
 							objeto(Tipo_Objeto1, Objeto1, S1-S2),
 							determinante2(Tipo_determinante,S2-S3),
 							objeto(Tipo_Objeto2, Objeto2, S3-[]),
 							apilador(Objeto2),
 							Tipo_determinante == apilador.
 							
 							
 							
 	determinante2(apilador,[en|X]- X).
 	determinante2(contenedor,[en|X]- X).
 	determinante2(apilador,[sobre|X]- X).
 	determinante2(contenedor,[dentro|X]- X).
 	
 	%verbo(ver, [ver|X]-X).						
 	%verbo(estandar, abrir, [abrir|X]-X).
 	verbo(estandar, estandar,  soltar, [soltar|X]-X).
 	
 	
 	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 	%%%%% dar dos parámetros diferente
 	
 	command([Comando,Objeto1,Objeto2], EnLista) :-
 							verbo_dar(Tipo_Objeto1,Tipo_Objeto2, Comando, EnLista-S1),
 							objeto(Tipo_Objeto1, Objeto1, S1-S2),
 							determinante3(S2-S3),
 							objeto(Tipo_Objeto2, Objeto2, S3-[]).
 	
 	verbo_dar(estandar, estandar,  dar, [dar|X]-X).
 	
 	determinante3([a|X]- X).
 	
 	

  