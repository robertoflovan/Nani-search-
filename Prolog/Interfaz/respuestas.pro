
%	Entrar� a �ste 'command loop' automaticamente desde Java al tener un 
%	hecho 'pide_respuesta/1'

respuesta_loop(ComandoEntrada):-
								write('se ejecut� respuesta_loop'),
								get_respuesta(X,ComandoEntrada),
								do(X).
								
%	Dependiendo del n�mero de respuesta (pide_respuesta/1), ser� el texto que mandar� si
%	se escribe algo que no est� contemplado

get_respuesta(C,ComandoEntrada):-
							readlist(L,ComandoEntrada),		% reads a sentence and puts [it,in,list,form]
							respuesta(X, L),   				% call the grammar for command
							C =.. X,!.          			% make the command list a structure

respuesta([Comando], EnLista):- 
							verbo_respuesta(Comando, EnLista-[]).

%%%%%%%  pide_respuesta(1) %%%%%%%
%%%%%%%  Pide insertar las palabras "tolle animam meam"

get_respuesta(_,_):-
							pide_respuesta(1),
							newWrite,
							appendWrite('Consola&*Escribe "tolle animam meam"*'), nl, fail.
							
							
verbo_respuesta(respuesta_pacto, [tolle,animam,meam|X]-X).


					
							%respuesta(X, L-[]),
							%respuesta(ver, [ver|X]-X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
							
%%%%%%%  pide_respuesta(2) %%%%%%%
%%%%%%%  Pide insertar las palabras "tolle animam meam"

get_respuesta(_,_):-
							pide_respuesta(2),
							newWrite,
							appendWrite('Lo&Antes de cualquier cosa es necesario que observes en donde se encuentra la ni�a&&Consola&*Escribe "ver"*'), nl, fail.
							
							
verbo_respuesta(respuesta_ver, [ver|X]-X).


					
							%respuesta(X, L-[]),
							%respuesta(ver, [ver|X]-X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%				
							
							