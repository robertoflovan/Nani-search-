%%%%%%- imprimir objetos -%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% PRUEBAS TXT %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pruebaWrite:-
			open('file.txt',write,Stream), 
         	write(Stream,'Hogwarts asd'),  nl(Stream), 
         	close(Stream).
         	
locate_prolog_file(Spec, Path) :-
        absolute_file_name(Spec,
                           [ file_type(prolog),
                             access(read)
                           ],
                           Path).
      
pruebaAdd :- open('texto.txt', append, Handle), write(Handle, 'abc'), close(Handle).

appendWrite(X) :-
			open('texto.txt', append, Handle),
			write(Handle, X),
			close(Handle).
newWrite :-
			open('texto.txt',write,Stream), 
         	write(Stream,''),
         	close(Stream).
nlW :- 
			open('texto.txt', append, Handle),
			write(Handle,'\n'),
			close(Handle).

pruebaAppendWrite :-
			X= '111',
			newWrite('000'),
			appendWrite(X),
			appendWrite('222').

pruebaNewWrite :-
			newWrite('\nNew\nNew\n').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		
imprimir_b�sico(Objeto) :- 
									tab(7),
									appendWrite('un/una '),
									appendWrite(Objeto).
imprimir_objeto(Objeto) :-
									imprimir_b�sico(Objeto),
									nlW,fail.
									
									
									
									
imprimir_objetos(Objeto) :- % Es un objeto sobre otro objeto
									locaci�n(Objeto,Lugar),
									apilador(Lugar),
									imprimir_b�sico(Objeto),
									appendWrite(' se encuentra sobre el/la '),
									appendWrite(Lugar),
									nlW,fail.
									
imprimir_objetos(Objeto) :- % Es un objeto dentro de otro objeto
									locaci�n(Objeto,Contenedor),
									contenedor(Contenedor,_),
									imprimir_b�sico(Objeto),
									appendWrite(' se encuentra dentro de la '),
									appendWrite(Contenedor),
									nlW,fail.
imprimir_objetos(Objeto) :- % Es un objeto directamente en la habitaci�n
									locaci�n(Objeto,Contenedor),
									not(contenedor(Contenedor,_)),
									not(apilador(Contenedor)),
									imprimir_b�sico(Objeto),
									nlW,fail.
								
								






/*imprimir_objetos(Objetos) :- %%Es un objeto sobre otro Objeto
		not llave2(Objetos,_,_),
		locaci�n(Objetos,Lugar),
		apilador(Lugar),
		objeto(Objetos, color(Color), tama�o(Tama�o), peso(Peso)),
		tab(5),appendWrite('Una '),appendWrite(Tama�o),
		tab(1), appendWrite(Objetos),
		tab(1), appendWrite(Color),
		appendWrite(', que pesa '),
		appendWrite(Peso), appendWrite(' kilos. '),
		appendWrite( ' Se encuentra sobre el/la '),
		appendWrite(Lugar),
		imprimir_objetos2(Lugar).

imprimir_objetos(Objetos) :- %%Es una llave
		
		llave2(Objetos,X,Y),
		locaci�n(Objetos,Lugar),
		not apilador(Lugar),
		objeto(Objetos, color(Color), tama�o(Tama�o), peso(Peso)),
		tab(5),appendWrite('Una '),appendWrite(Tama�o),
		tab(1), appendWrite(Objetos),
		tab(1), appendWrite(Color),
		appendWrite(', que pesa '),
		appendWrite(Peso), appendWrite(' kilos. '),
		appendWrite( ' Por una etiqueta sabes que es la llave para la puerta entre el/la '),
		appendWrite(X), appendWrite(' y el/la '),
		appendWrite(Y),
		imprimir_objetos2(Lugar).

imprimir_objetos(Objetos) :-  %% No es una llave, objeto cualquiera
		
		not llave2(Objetos,_,_),
		locaci�n(Objetos,Lugar),
		not apilador(Lugar),
		objeto(Objetos, color(Color), tama�o(Tama�o), peso(Peso)),
		tab(5),appendWrite('Un/Una '),appendWrite(Tama�o),
		tab(1), appendWrite(Objetos), 
		tab(1), appendWrite(Color),
		appendWrite(', que pesa '),
		appendWrite(Peso), appendWrite(' kilos.'),
		imprimir_objetos2(Lugar).
		
%%%%%%%%%%%
				imprimir_objetos2(Lugar) :- contenedor(Lugar,_),
													  appendWrite(' Se encuentra dentro de la '),
													  appendWrite(Lugar),%nlW,
													  fail.
				imprimir_objetos2(Lugar) :- nlW,fail.
%%%%%%%%%%%

imprimir_objeto(Objeto) :- 
		not llave2(Objeto,_,_),
		objeto(Objeto, color(Color), tama�o(Tama�o), peso(Peso)),
		tab(5),appendWrite('Un/Una '),appendWrite(Tama�o),
		tab(1), appendWrite(Objeto),
		tab(1), appendWrite(Color),
		appendWrite(', que pesa '),
		appendWrite(Peso), appendWrite(' kilos.'),nlW,fail.
imprimir_objeto(Objeto) :-  
		llave2(Objeto,X,Y),
		objeto(Objeto, color(Color), tama�o(Tama�o), peso(Peso)),
		tab(5),appendWrite('Un/Una '),appendWrite(Tama�o),
		tab(1), appendWrite(Objeto),
		tab(1), appendWrite(Color),
		appendWrite(', que pesa '),
		appendWrite(Peso), appendWrite(' kilos.'),
		appendWrite( ' Por una etiqueta sabes que es la llave para la puerta entre el/la '),
		appendWrite(X), appendWrite(' y el/la '),
		appendWrite(Y),
		nlW,fail.*/
