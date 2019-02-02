
# <ins>MODELOS LINEALES</ins>

Antes de entrar en el análisis de modelos lineales es necesario comprender de qué se trata el enfoque de la estadística aplicada. Para verlo de  manera sencilla se puede decir que la estadística empieza con un problema, continúa con la recolección de datos, sigue con el análisis de los mismos y finaliza con conclusiones.

El aspecto más importante es la formulación correcta del problema ya que, de su comprensión, depende el desarrollo estadístico. La formulación del problema puede resumirse en los siguientes pasos <sup><a name="myfootnote1">1</a></sup>

1. Conocer los antecedentes.
2. Entender los objetivos.
3. Comprender lo que el 'cliente' busca.
4. Poner el problema en términos estadísticos.

También es necesario conocer los datos recolectados. Para ello hay que tener en cuenta:

1. Si los datos son observacionales o experimentales.
2. Si hay cuestiones sin responder.
3. Si existen valores perdidos.
4. Cuál ha sido la forma de codificar los datos.
5. Cuáles son las unidades de medidas.
6. Revisar si existen datos corruptos o errores en las entradas.

Una vez revisados estos aspectos, se procede con el análisis de los datos.

## Análisis Inicial o Análisis Exploratorio

Aunque es un paso simple, se trata de un momento crucial para la comprensión de los datos. El análisis inicial da una perspectiva general del problema y permite identificar aspectos que podrían ser susceptibles de ajustar, antes de avanzarcon el proceso. Existen dos maneras de exploración: análisis numérico y análisis gráfico; ambos se complementan y ofrecen información.

Para este procedimiento se va a emplear algunas bases de datos que se encuentran asociadas al programa `R`. Para este ejercicio se va a emplear la base de datos llamada `pima` asociada a la librería `faraway` (si no se encuentra instalada hay que proceder a instalarla). Los datos se llaman con la siguiente línea:


```R
data(pima, package="faraway")
```

En este comando hay dos argumentos para considerar: `data(x, package)`, donde el argumento `x` hace referencia al conjunto de datos a emplear (en este caso `pima`) y `package` se refiere a la librería asociada (`faraway`). Es importante anotar las comillas en el nombre del paquete o librería ya que la selección por parte del software se basa en caracteres, si no se colocan las comillas el programa lo interpreta como un objeto y puede generar un error en la ejecución del comando.

Otra manera de hacerlo es llamar la librería y, luego, importar los datos. Se puede emplear la siguiente línea de comandos y los resultados son los mismos:


```R
library(faraway)
data(pima)
```

El conjunto de datos correspondea un estudio realizado por el Instituto Nacional de la Diabetes y Enfermedades Digestivas a 768 indígenas Pima adultas viviendo cerca de Phoenix. Las variables registradas son:

- `pregnant` Numero de veces que ha estado embarazada.
- `glucose` Concentración de glucosa plasmática a las 2 horas en una prueba oral de tolerancia a la glucosa.
- `diastolic` Presión distólica (mm Hg).
- `triceps` Espesor de los pliegues cutáneos en los tríceps (mm)
-  `ìnsulin` 2 horas de insulina en suero (mu U/ml)
- `bmi` Índice de Masa Corporal (peso en kg/altura en m<sup>2</sup>
- `diabetes` Función pedigrí de la diabetes (Es una función que representa la probabilidad de que contraigan la enfermedad mediante la extrapolación de la historia de su antepasado)
- `age` Edad en Años
- `test` Prueba de signos de diabetes (0 = Negativo; 1 = Positivo)

Una visión inicial de los datos se puede obtener mediante los comandos `head` y `tail` que muestran el inicio y el final de la tabla (tambien se puede usar el comando `View` pero este es procedente cuando la tabla es corta). Los comandos tienen dos elementos: `x` que hace referencia a la tabla que se desea visualizar y `n` que se refiere a la cantidad de observaciones a mostrar. Por defecto `n = 6`.


```R
head(pima)
```


<table>
<thead><tr><th scope=col>pregnant</th><th scope=col>glucose</th><th scope=col>diastolic</th><th scope=col>triceps</th><th scope=col>insulin</th><th scope=col>bmi</th><th scope=col>diabetes</th><th scope=col>age</th><th scope=col>test</th></tr></thead>
<tbody>
	<tr><td>6    </td><td>148  </td><td>72   </td><td>35   </td><td>  0  </td><td>33.6 </td><td>0.627</td><td>50   </td><td>1    </td></tr>
	<tr><td>1    </td><td> 85  </td><td>66   </td><td>29   </td><td>  0  </td><td>26.6 </td><td>0.351</td><td>31   </td><td>0    </td></tr>
	<tr><td>8    </td><td>183  </td><td>64   </td><td> 0   </td><td>  0  </td><td>23.3 </td><td>0.672</td><td>32   </td><td>1    </td></tr>
	<tr><td>1    </td><td> 89  </td><td>66   </td><td>23   </td><td> 94  </td><td>28.1 </td><td>0.167</td><td>21   </td><td>0    </td></tr>
	<tr><td>0    </td><td>137  </td><td>40   </td><td>35   </td><td>168  </td><td>43.1 </td><td>2.288</td><td>33   </td><td>1    </td></tr>
	<tr><td>5    </td><td>116  </td><td>74   </td><td> 0   </td><td>  0  </td><td>25.6 </td><td>0.201</td><td>30   </td><td>0    </td></tr>
</tbody>
</table>




```R
tail(pima)
```


<table>
<thead><tr><th></th><th scope=col>pregnant</th><th scope=col>glucose</th><th scope=col>diastolic</th><th scope=col>triceps</th><th scope=col>insulin</th><th scope=col>bmi</th><th scope=col>diabetes</th><th scope=col>age</th><th scope=col>test</th></tr></thead>
<tbody>
	<tr><th scope=row>763</th><td> 9   </td><td> 89  </td><td>62   </td><td> 0   </td><td>  0  </td><td>22.5 </td><td>0.142</td><td>33   </td><td>0    </td></tr>
	<tr><th scope=row>764</th><td>10   </td><td>101  </td><td>76   </td><td>48   </td><td>180  </td><td>32.9 </td><td>0.171</td><td>63   </td><td>0    </td></tr>
	<tr><th scope=row>765</th><td> 2   </td><td>122  </td><td>70   </td><td>27   </td><td>  0  </td><td>36.8 </td><td>0.340</td><td>27   </td><td>0    </td></tr>
	<tr><th scope=row>766</th><td> 5   </td><td>121  </td><td>72   </td><td>23   </td><td>112  </td><td>26.2 </td><td>0.245</td><td>30   </td><td>0    </td></tr>
	<tr><th scope=row>767</th><td> 1   </td><td>126  </td><td>60   </td><td> 0   </td><td>  0  </td><td>30.1 </td><td>0.349</td><td>47   </td><td>1    </td></tr>
	<tr><th scope=row>768</th><td> 1   </td><td> 93  </td><td>70   </td><td>31   </td><td>  0  </td><td>30.4 </td><td>0.315</td><td>23   </td><td>0    </td></tr>
</tbody>
</table>



Se puede empezar con un resumen numérico de los datos usando la función `summary`:


```R
summary(pima)
```


        pregnant         glucose        diastolic         triceps     
     Min.   : 0.000   Min.   :  0.0   Min.   :  0.00   Min.   : 0.00  
     1st Qu.: 1.000   1st Qu.: 99.0   1st Qu.: 62.00   1st Qu.: 0.00  
     Median : 3.000   Median :117.0   Median : 72.00   Median :23.00  
     Mean   : 3.845   Mean   :120.9   Mean   : 69.11   Mean   :20.54  
     3rd Qu.: 6.000   3rd Qu.:140.2   3rd Qu.: 80.00   3rd Qu.:32.00  
     Max.   :17.000   Max.   :199.0   Max.   :122.00   Max.   :99.00  
        insulin           bmi           diabetes           age       
     Min.   :  0.0   Min.   : 0.00   Min.   :0.0780   Min.   :21.00  
     1st Qu.:  0.0   1st Qu.:27.30   1st Qu.:0.2437   1st Qu.:24.00  
     Median : 30.5   Median :32.00   Median :0.3725   Median :29.00  
     Mean   : 79.8   Mean   :31.99   Mean   :0.4719   Mean   :33.24  
     3rd Qu.:127.2   3rd Qu.:36.60   3rd Qu.:0.6262   3rd Qu.:41.00  
     Max.   :846.0   Max.   :67.10   Max.   :2.4200   Max.   :81.00  
          test      
     Min.   :0.000  
     1st Qu.:0.000  
     Median :0.000  
     Mean   :0.349  
     3rd Qu.:1.000  
     Max.   :1.000  


Algunos datos se observan raros; por ejemplo, el número de veces que ha estado embarazada presenta un máximo de 17, raro pero no imposible. Sim embargo, la presión diastólica muestra valores cero lo cual puede corresponder a datos perdidos pues ausencia de presión en la sangre no es buen síntoma. Una opción para la comprender esta variables es ordenarla (usando la función `sort`)


```R
head(sort(pima$diastolic),50)
```


<ol class=list-inline>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>0</li>
	<li>24</li>
	<li>30</li>
	<li>30</li>
	<li>38</li>
	<li>40</li>
	<li>44</li>
	<li>44</li>
	<li>44</li>
	<li>44</li>
	<li>46</li>
	<li>46</li>
	<li>48</li>
	<li>48</li>
	<li>48</li>
	<li>48</li>
</ol>



Se aprecian 35 observaciones con valores cero lo que sugiere que el dato no se registró debido a problemas en la investigación por lo que asignar estas observaciones como datos perdidos sería lo correcto. El procedimiento es el siguiente:


```R
pima$diastolic[pima$diastolic == 0] <- NA
pima$glucose[pima$glucose == 0] <- NA
pima$triceps[pima$triceps == 0] <- NA
pima$insulin[pima$insulin == 0] <- NA
pima$bmi[pima$bmi == 0] <- NA
```

Ahora se debe transformar en factor la variable `test` dado que se trata de una variable categórica:


```R
pima$test <- factor(pima$test)
levels(pima$test) <- c("negative","positive")
summary(pima)
```


        pregnant         glucose        diastolic         triceps     
     Min.   : 0.000   Min.   : 44.0   Min.   : 24.00   Min.   : 7.00  
     1st Qu.: 1.000   1st Qu.: 99.0   1st Qu.: 64.00   1st Qu.:22.00  
     Median : 3.000   Median :117.0   Median : 72.00   Median :29.00  
     Mean   : 3.845   Mean   :121.7   Mean   : 72.41   Mean   :29.15  
     3rd Qu.: 6.000   3rd Qu.:141.0   3rd Qu.: 80.00   3rd Qu.:36.00  
     Max.   :17.000   Max.   :199.0   Max.   :122.00   Max.   :99.00  
                      NA's   :5       NA's   :35       NA's   :227    
        insulin            bmi           diabetes           age       
     Min.   : 14.00   Min.   :18.20   Min.   :0.0780   Min.   :21.00  
     1st Qu.: 76.25   1st Qu.:27.50   1st Qu.:0.2437   1st Qu.:24.00  
     Median :125.00   Median :32.30   Median :0.3725   Median :29.00  
     Mean   :155.55   Mean   :32.46   Mean   :0.4719   Mean   :33.24  
     3rd Qu.:190.00   3rd Qu.:36.60   3rd Qu.:0.6262   3rd Qu.:41.00  
     Max.   :846.00   Max.   :67.10   Max.   :2.4200   Max.   :81.00  
     NA's   :374      NA's   :11                                      
           test    
     negative:500  
     positive:268  
                   
                   
                   
                   
                   


Con esto corregido, el siguiente paso es la exploración gráfica. Ésta se puede hacer por dos vías: funciones básicas para gráficos y funciones especiales (de la librería `ggplot2`). Para las funciones básicas las lineas de comado son las siguientes:


```R
par(mfrow=c(2,3))
hist(pima$diastolic,xlab="Diastolic",main="")
plot(density(pima$diastolic,na.rm=TRUE),main="")
plot(sort(pima$diastolic),ylab="Sorted Diastolic")
plot(diabetes ~ diastolic,pima)
plot(diabetes ~ test,pima)
par(mfrow=c(1,1))
```


![png](output_18_0.png)


## Estimación

Los modelos lineales se utilizan para explicar la relación entre una variable dependiente $Y$ y una o más variables independientes $X_{1}, X_{2}, \dots; X_{p}$ (que también suelen llamarse variables predictoras o explicatorias). El subíndice $p$ indica el número de predictores que intervienen en la relación.

Si $p=1$ se denomina regresión simple, si $p>1$ se llama regresión múltiple. Un aspecto importante a tener en cuenta es que $Y$ debe ser siempre una variable continua, mientras que las covariables $X$ pueden ser continuas, discretas o categóricas. El análisis de la regresión busca dos objetivos:

1. Predecir posibles respuestas dados unos valores específicos de los predictores
2. Evaluar el efecto de (o la relación entre) las variables explicativas o independientes y la variable de respuesta o dependiente

Como se sabe, de manera general, el modelo puede expresarse de la forma:

$$
Y = f\left(X_{1},X_{2},\dots,X_{p}\right) + \varepsilon
$$

o bien

$$
Y = \beta_{0} + \beta_{1}X_{1} + \beta_{2}X_{2} + \dots + \beta_{p}X_{p} + \varepsilon
$$

y su correspondiente expresión matricial

$$
y = X\beta + \varepsilon
$$

En todos los casos, los valores $\beta$ son desconocidos; la estimación se basa en calcular dichos valores con base en los datos recolectados. Se trata de una operación algebraica que, dependiendo del número de parámetros y de observaciones, representa complejidad. Por lo tanto, el uso de herramientas computacionales es de gran utilidad.

### Ejemplo usando R

La literatura presenta múltiples ejemplo para modelos lineales. Para este ejemplo, se usará un conjunto de datos asociado al programa R. Se analizará el caso particular del conjunto de datos denominado `gala` de la librería `faraway` que hace referencia a las especies encontradas en las Islas Galápago. Las variables que contiene son:

- `Species` número de especies encontradas en la isla
- `Endemics` número de especies endémicas
- `Area` area de la isla en Km<sup>2</sup>
- `Elevation` altitud de la isla en m
- `Nearest` distancia desde la isla más cercana (Km)
- `Scruz` Distancia de Santa Cruz a la isla
- `Adjacent` área de la isla adjacente (Km<sup>2</sup>)

El ajuste del modelo lineal se hace empleado el comando `lm()` cuya sintanxis debe especificar los predictores; además, se debe especificar un el argumento `data=` donde se relaciona el conjunto de datos a emplear.

Primero, se deben cargar los datos:


```R
data(gala, package="faraway")
head(gala)
```


<table>
<thead><tr><th></th><th scope=col>Species</th><th scope=col>Endemics</th><th scope=col>Area</th><th scope=col>Elevation</th><th scope=col>Nearest</th><th scope=col>Scruz</th><th scope=col>Adjacent</th></tr></thead>
<tbody>
	<tr><th scope=row>Baltra</th><td>58    </td><td>23    </td><td>25.09 </td><td>346   </td><td>0.6   </td><td> 0.6  </td><td>  1.84</td></tr>
	<tr><th scope=row>Bartolome</th><td>31    </td><td>21    </td><td> 1.24 </td><td>109   </td><td>0.6   </td><td>26.3  </td><td>572.33</td></tr>
	<tr><th scope=row>Caldwell</th><td> 3    </td><td> 3    </td><td> 0.21 </td><td>114   </td><td>2.8   </td><td>58.7  </td><td>  0.78</td></tr>
	<tr><th scope=row>Champion</th><td>25    </td><td> 9    </td><td> 0.10 </td><td> 46   </td><td>1.9   </td><td>47.4  </td><td>  0.18</td></tr>
	<tr><th scope=row>Coamano</th><td> 2    </td><td> 1    </td><td> 0.05 </td><td> 77   </td><td>1.9   </td><td> 1.9  </td><td>903.82</td></tr>
	<tr><th scope=row>Daphne.Major</th><td>18    </td><td>11    </td><td> 0.34 </td><td>119   </td><td>8.0   </td><td> 8.0  </td><td>  1.84</td></tr>
</tbody>
</table>



Lo correcto es iniciar con el planteamiento del problema. Para efectos del ejercicio se seleccionarán dos variables: `Species` y `Endemic`.
Se busca establecer si el número de especies encontradas en la isla depende del número de Especies Endémicas.
Lo siguiente es realizar un análisis exploratorio con las variables seleccionadas:


```R
varsel<-gala[,c(1,2)]
summary(varsel)
```


        Species          Endemics    
     Min.   :  2.00   Min.   : 0.00  
     1st Qu.: 13.00   1st Qu.: 7.25  
     Median : 42.00   Median :18.00  
     Mean   : 85.23   Mean   :26.10  
     3rd Qu.: 96.00   3rd Qu.:32.25  
     Max.   :444.00   Max.   :95.00  



```R
par(mfrow=c(2,3))
x <- varsel$Species
boxplot(varsel, main="Boxplor for Species & Endemics")
h<-hist(x, breaks=25, col="red", xlab="Species", main="Histogram with \n Density Curve")
xfit<-seq(min(x), max(x), length=40)
yfit<-dnorm(xfit, mean=mean(x), sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)
h<-hist(x, freq = F, breaks=25, col="red", xlab="Species", main="Histogram with \n Normal Curve")
lines(density(x), col="blue", lwd=2)
plot(sort(x),ylab="Sorted Species", main = "Sorted Plot")
with(gala, plot(Endemics,Species, main = "Dispersion Plot"))
par(mfrow=c(1,1))
```


![png](output_23_0.png)


Ahora, se procede a estimar el modelo.
El comando `lm()` hace referencia a la estimación de los modelos lineales; contiene dos elementos importantes en sus argumentos: `formula` y `data`. La primera describe la relación que se ha planteado para las variables donde la virgulilla (~) denota la dependencia; así, para el caso específico del ejercicio, debe escribirse: `Species~Endemics`, y en el segundo argumento debe declararse el conjunto de datos del cual se toman las variables: `data = varse` o, si se desea: `data = gala` ya que el primer conjunto de datos corresponde a una selección de variables del segundo.
El comando `sumary` de la libreía `faraway` permite mostrar los estadísticos más relevantes para esta parte del ejercicio:


```R
fit<-lm(Species~Endemics, data = varsel)
library(faraway)
sumary(fit)
```

                Estimate Std. Error t value  Pr(>|t|)
    (Intercept) -21.0480     7.1138 -2.9588  0.006219
    Endemics      4.0721     0.1899 21.4433 < 2.2e-16
    
    n = 30, p = 2, Residual SE = 27.94996, R-Squared = 0.94
    

O bien, ver el resumen numérico del modelo completo:


```R
summary(fit)
```


    
    Call:
    lm(formula = Species ~ Endemics, data = varsel)
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -71.791 -15.894   3.507  12.088  78.200 
    
    Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
    (Intercept) -21.0480     7.1138  -2.959  0.00622 ** 
    Endemics      4.0721     0.1899  21.443  < 2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    Residual standard error: 27.95 on 28 degrees of freedom
    Multiple R-squared:  0.9426,	Adjusted R-squared:  0.9406 
    F-statistic: 459.8 on 1 and 28 DF,  p-value: < 2.2e-16
    


Del estadístico `F` se desprende el análisis de la Varianza:


```R
summary(aov(fit))
```


                Df Sum Sq Mean Sq F value Pr(>F)    
    Endemics     1 359208  359208   459.8 <2e-16 ***
    Residuals   28  21874     781                   
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


Ahora, se pueden graficar los intervalos de confianza:


```R
x0<-seq(min(varsel$Endemics),max(varsel$Endemics),length=30)
pred.m<-predict(fit,data.frame(Endemics=x0),interval="confidence",se.fit=T)
pred.p<-predict(fit,data.frame(Endemics=x0),interval="prediction",se.fit=T)

matplot(x0,cbind(pred.m$fit,pred.p$fit[,-1]),lty=c(1,2,2,3,3),
        col=c("black","red","red","blue","blue"),type="l",xlab="Endemics",
        ylab="Species")

legend('topleft',c("Estim.Media","Prediccion"),lty=c(2,3),
       col=c("red","blue"))

points(varsel$Endemics,varsel$Species, pch = 20)
```


![png](output_31_0.png)


### Ejercicio

Con el mismo conjunto de datos `gala` el estudiante realizará la exploración de las diferentes combinaciones de variables usando como variable dependiente la denominada `Species`. Debe discutir la interpretación de los resultados con sus compañeros de clase.

### Taller en clase

El conjunto de datos del enlace https://www.dropbox.com/s/dn30luorh63w1h3/acme.csv?dl=0 contiene información sobre los excedentes de los rendimiento mensuales de la Corporación Acme registrada en las Bolsas de Valores de Nueva York durante un periodo de cinco años. Las variables del archivo son las siguientes:

* `market` representa el excesos de rentas del mercado en conjunto
* `acme` se refiere al excedo de rendimientos de la compañía Acme
* `month` es una cadena de caracteres que denota el mes en el cual se recolectaron los datos

El estudiante debe plantear el modelo lineal adecuado y realizar el correspondiente análisis.


### Taller en casa

El estudiante debe descargar el archivo del siguiente enlace y realizar el respectivo análisis haciendo uso de los modelos lineales: https://www.dropbox.com/s/vv0f1k2y5nalpgx/bank-additional-full.csv?dl=0

Los datos están relacionados con las campañas de marketing directo de una institución bancaria portuguesa. Las campañas de marketing se basaron en llamadas telefónicas. A menudo, se requería más de un contacto con el mismo cliente, para poder acceder si el producto (depósito bancario) estaba ("sí") o no ("no") suscrito.

Las variables registradas son las siguientes:

* `age` - edad
* `job`- tipo de trabajo
* `marital` - estado civil
* `education` - nivel educativo
* `default` - crédito en incumplimiento
* `housing` - crédito de vivienda
* `loan` - préstamos personal
* `contact` - tipo de contacto realizado
* `month` - mes en que se hizo el último contacto
* `day_of_week` - último día de contacto de la semana
* `duration` - duración del último contacto, en segundos
* `campaign` - número de contactos realizados durante esta campaña y para este cliente
* `pdays` - número de días que pasaron después de que el cliente fue contactado por última vez desde una campaña anterior (999 significa que el cliente no fue contactado previamente)
* `previous`- número de contactos realizados antes de esta campaña y para este cliente
* `poutcome` - resultado de la campaña de marketing anterior
* `emp.var.rate`- tasa de variación del empleo - indicador trimestral
* `cons.price.idx` - índice de precios al consumidor - indicador mensual
* `cons.conf.idx` - índice de confianza del consumidor - indicador mensual
* `euribor3m` - euribor tasa de 3 meses - indicador diario
* `nr.employed` - número de empleados
* `y` - ¿el cliente ha suscrito un depósito a plazo?

Los datos fueron tomados de:
S. Moro, R. Laureano and P. Cortez. Using Data Mining for Bank Direct Marketing: An Application of the CRISP-DM Methodology. 
  In P. Novais et al. (Eds.), Proceedings of the European Simulation and Modelling Conference - ESM'2011, pp. 117-121, Guimarães, Portugal, October, 2011. EUROSIS.

Plazo máximo de entrega: viernes 8 de febrero 5:30 pm
