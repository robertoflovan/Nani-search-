%%%%%%%%%%%%%%%%%%%%%%---------Puertas---------%%%%%%%%%%%%%%%%%%%%%%%%%%
%Piso1

puerta(pasillo1,ba�o1).     
puerta(sala1,cochera). requiere_llave2(sala1,cochera).

puerta_abierta2(sala1,pasillo1).
puerta_abierta2(sala1,escaleras).
puerta_abierta2(pasillo1,comedor).
puerta_abierta2(comedor,cocina).

%Piso2

puerta(pasillo2,ba�o2).
puerta(pasillo2,patio2).     
puerta(pasillo2,cuarto1).
puerta(pasillo2,cuarto2).    
puerta(pasillo2,cuarto3).
puerta(patio2,lavander�a). requiere_llave2(patio2,lavander�a).

puerta_abierta2(pasillo2,sala2).
puerta_abierta2(escaleras,pasillo2).

%%%%%%%%- Llaves -%%%%%%%%%%%
	llave2(llave1,sala1,cochera).
	llave2(llave2,patio2,lavander�a).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%