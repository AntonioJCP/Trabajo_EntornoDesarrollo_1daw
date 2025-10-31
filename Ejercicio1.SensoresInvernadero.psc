//=======================================================
// FUNCIÓN: CalcularMediaTemp
//=======================================================
Funcion resultado <- CalcularMediaTemp(temperatura_total, cant_sensores Por Referencia)
	Definir resultado Como Real;
	resultado <- temperatura_total / cant_sensores;
FinFuncion

//=======================================================
// FUNCIÓN: CalcularPorcentaje
// Devuelve 1 si la temperatura está dentro de +-2 grados
//=======================================================
Funcion resultado <- CalcularPorcentaje(temperatura_objetivo, temperatura Por Referencia)
	Definir resultado Como Entero;
	resultado <- 0;
	Si temperatura_objetivo >= temperatura - 2 Y temperatura_objetivo <= temperatura + 2 Entonces
		resultado <- 1;
	FinSi
FinFuncion

//=======================================================
// ALGORITMO PRINCIPAL
//=======================================================
Algoritmo MedirTemperaturas
	Definir cant_sensores, temp_max_pos, temp_min_pos, por_encima_media, por_debajo_media, igual_media, contador_temp, contadortemperatura, i Como Entero;
	Definir temperatura_objetivo, media_temp, temperatura_total, temp_max, temp_min Como Real;
	Definir estado_sistem Como Cadena;
	
	temperatura_total <- 0;
	por_debajo_media <- 0;
	por_encima_media <- 0;
	igual_media <- 0;
	temp_max <- -70;
	temp_min <- 70;
	temp_max_pos <- 0;
	temp_min_pos <- 0;
	contador_temp <- 0;
	contadortemperatura <- 0;
	
	//Menú para elegir la cantidad de sensores
	Escribir "Escribe la cantidad de sensores (entre 1 y 20):";
	Leer cant_sensores;
	Mientras cant_sensores < 1 O cant_sensores > 20 Hacer
		Escribir "Error. La cantidad de sensores debe estar entre 1 y 20.";
		Escribir "Inténtalo de nuevo:";
		Leer cant_sensores;
	FinMientras
	
	Dimension temperatura[cant_sensores];
	
	//Cargar temperaturas
	Para i <- 0 Hasta cant_sensores - 1 Hacer
		Escribir "Introduce la temperatura del sensor ", i + 1, ":";
		Leer temperatura[i];
		
		Mientras temperatura[i] < -60 O temperatura[i] > 60 Hacer
			Escribir "Error: la temperatura debe estar entre -60 y 60 grados.";
			Escribir "Inténtalo de nuevo:";
			Leer temperatura[i];
		FinMientras
		
		temperatura_total <- temperatura_total + temperatura[i];
	FinPara
	
	//Temperatura objetivo
	Escribir "Escribe la temperatura objetivo:";
	Leer temperatura_objetivo;
	
	Mientras temperatura_objetivo < -60 O temperatura_objetivo > 60 Hacer
		Escribir "Error: la temperatura debe estar entre -60 y 60 grados.";
		Escribir "Inténtalo de nuevo:";
		Leer temperatura_objetivo;
	FinMientras
	
	//Cálculo de la media
	media_temp <- CalcularMediaTemp(temperatura_total, cant_sensores);
	Escribir "------------------------------------------";
	Escribir "La temperatura media es: ", media_temp;
	
	//Analizar cada sensor
	Para i <- 0 Hasta cant_sensores - 1 Hacer
		Si temperatura[i] < media_temp Entonces
			por_debajo_media <- por_debajo_media + 1;
		FinSi
		
		Si temperatura[i] > media_temp Entonces
			por_encima_media <- por_encima_media + 1;
		FinSi
		
		Si temperatura[i] = media_temp Entonces
			igual_media <- igual_media + 1;
		FinSi
		
		//Máxima y mínima
		Si temperatura[i] > temp_max Entonces
			temp_max <- temperatura[i];
			temp_max_pos <- i + 1;
		FinSi
		
		Si temperatura[i] < temp_min Entonces
			temp_min <- temperatura[i];
			temp_min_pos <- i + 1;
		FinSi
		
		//Sensores dentro de ±2 grados de la temperatura objetivo
		contador_temp <- contador_temp + CalcularPorcentaje(temperatura_objetivo, temperatura[i]);
		
		//Sensores dentro de ±5 grados respecto a la media
		Si temperatura[i] >= media_temp - 5 Y temperatura[i] <= media_temp + 5 Entonces
			contadortemperatura <- contadortemperatura + 1;
		FinSi
	FinPara
	
	//Estado del sistema
	Si contadortemperatura = cant_sensores Entonces
		estado_sistem <- "El sistema está equilibrado.";
	SiNo
		estado_sistem <- "El sistema no está equilibrado.";
	FinSi
	
	//Resultados finales
	Escribir "";
	Escribir "====== Estadísticas Finales ======";
	Escribir "Sensores por debajo de la media: ", por_debajo_media;
	Escribir "Sensores iguales a la media: ", igual_media;
	Escribir "Sensores por encima de la media: ", por_encima_media;
	Escribir "Porcentaje de sensores dentro de ±2 grados: ", (contador_temp * 100) / cant_sensores, "%";
	Escribir estado_sistem;
	Escribir "-----------------------------------";
	Escribir "Temperatura máxima: ", temp_max, " (sensor ", temp_max_pos, ")";
	Escribir "Temperatura mínima: ", temp_min, " (sensor ", temp_min_pos, ")";
FinAlgoritmo
