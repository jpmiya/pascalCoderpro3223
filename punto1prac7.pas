{Una productora nacional realiza un casting de personas para la selección de actores extras de una
nueva película, para ello se debe leer y almacenar la información de las personas que desean
participar de dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el código de
género de actuación que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La lectura
finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse.
Una vez finalizada la lectura de todas las personas, se pide:
a. Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
b. Informar los dos códigos de género más elegidos.
c. Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no
existir. Invocar dicho módulo en el programa principal.}
{-----------------------------------------------------------------------------------------------------}

program punto1prac7;

type
	gen = 1..5;
	persona = record
		DNI : integer;
		ApNom : string[30];
		edad : integer;
		codigo : gen;
		end;
		
	genero = array [1..5] of integer;	
		
	lista = ^nodo;
	nodo = record
		datos : persona;
		sig : lista;
		end;
{zona modulos}

procedure leer(var p : persona);
begin
	readln(p.DNI);
	readln(p.ApNom);
	readln(p.edad);
	readln(p.codigo);
end;

procedure analizarGen(g : genero; cod1, cod2 : gen);
var
	i, max1, max2:integer;
begin
	max1:= -1;
	max2:= -1;
	for i := 1 to 5 do
		if (g[i] > max1) then begin
			max2 := max1;
			max1 := g[i];
			cod1 := i;
			cod2 := cod1;
			end;
		if ((g[i] > max2) and (g[i] < max1)) then begin
				max2 := g[i];
				cod2 := i;
				end;
	writeln('Los dos generos mas elegidos son: ', cod1, ' y ', cod2)
end;
procedure crear(L : lista);
begin
	L := nil;
end;

procedure AgregarAdelante (var L : lista; p: persona);
var
	nuevo : lista;
begin
	new(nuevo);
	nuevo^.datos := p;
	nuevo^.sig := nil;
	if (L = nil) then L := nuevo
	else begin
		nuevo^.sig := L;
		L := nuevo
		end;
end;

function parImp(p : persona) : boolean;
var
	resto : integer;
	pares : integer;
	impares : integer;
	aux : boolean;
	num : integer;
begin
	num := p.DNI;
	pares := 0;
	impares := 0;
	while (num <> 0) do begin
		resto := num mod 10;
		if (resto mod 2 = 0) then
			pares := pares + 1
		else
			impares := impares + 1;
		num := num div 10
		end;
	if (pares > impares) then aux := true
	else aux := false;
	parImp := aux;
end;

procedure cargarLista (var L : lista; p : persona; var cantDniPar : integer; var g : genero);
var
	cantidad : integer;
	esOno : boolean;
	
begin
	leer(p);
	while (p.DNI <> 33555444) do begin
		g[p.codigo] := g[p.codigo] + 1;
		AgregarAdelante(L, p);
		esOno := parImp(p.DNI);
		if (esOno) then cantDniPar := cantDniPar + 1;
		leer(p);
		end;
	writeln('La cantidad de dnis con mas numeros pares que impares son: ', cantDniPar)
end;

procedure eliminarDNI(var l : lista; dni : integer);
var
	actual,ant : lista
begin
	actual := l
	while (aux <> nil) and (aux^datos.DNI <> dni) do begin
		ant := actual; actual := actual^.sig;
		end;
	if (l <> nil) then begin
		if (aux = l) then begin
			l:= l^.sig;
			dispose(aux);
			end;
		else begin
			ant^sig:=actual^.sig;
			dispose(actual);
			end;
		end;

{programa principal}
var
	l : lista;
	per : persona;
	masParQimp, dniAeliminar : integer;
	vector : genero;
	codigo1 : gen;
	codigo2 : gen;
begin
	masParQimp := 0;
	codigo1 : 1;
	codigo2 : 1;
	crear(l);
	cargarLista(l, per, masParQimp, vector);
	analizarGen(vector, codigo1, codigo2);
	readln(dniAeliminar);
	eliminarDNI(l, dniAeliminar)
end.
