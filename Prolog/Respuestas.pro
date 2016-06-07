	
	respuesta:-
	  repeat,
	  tomar_respuesta(X),nl,
	  write(X),nl,
	  do(X),nl,write('222222222').
	
	leerRespuesta(L):-
	  write('>> '),
	  read_word_list(L).


	tomar_respuesta(C):-
		leerRespuesta(L),        % reads a sentence and puts [it,in,list,form]
		comando_respuesta(X,L),    % call the grammar for command
		C =.. X,!.          % make the command list a structure
	tomar_respuesta(_):-
	  write('asdfadfadfasdfasd'), nl, fail.
	  
	  
		% ?- comando_respuesta(X,[tolle,animam,meam]).
		comando_respuesta([Comando], EnLista):- 
							resp(Comando, EnLista-[]).
	  
		resp(pacto_aceptado, [tolle,animam,meam|X]-X).

		
		
		
		
		
		
		