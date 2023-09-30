# Primera Práctica Calificada 
Integrantes:  
- Acuña Napan Jaime Gonzalo
- Canales Yarin, Edward Alexander
- Zuñiga Chicaña, Alejandra Aztirma  

# Creacion de aplicaciones SaaS

**Objetivo:**  
El objetivo de este trabajo es comprender y documentar los pasos esenciales para crear, versionar e implementar una aplicación de Software como Servicio (SaaS). Además, se abordará la importancia de mantener la consistencia en los entornos de producción y desarrollo, asegurando que las bibliotecas y dependencias se gestionen adecuadamente.

**Tareas a Realizar:**  
En este proyecto, se llevarán a cabo las siguientes tareas:  
- Creación de una Aplicación "Hello World": Se desarrollará una aplicación de ejemplo utilizando el framework Sinatra.
- Versionamiento Correcto: Se aplicarán prácticas de versionamiento adecuadas para garantizar un control.efectivo del código fuente de la aplicación. Esto incluye el uso de sistemas de control de versiones como Git.

- Implementación en Heroku: La aplicación desarrollada se implementará en la plataforma de alojamiento en la nube Heroku. 


## Creación y versionado de una aplicación SaaS sencilla

Para llevar a cabo esto realizamos los siguientes pasos:

- Creamos un nuevo directorio vacío destinado a alojar nuestra nueva aplicación y utilizamos el comando git init en ese directorio para iniciar el control de versiones mediante Git.

- Dentro de este directorio, creamos un archivo nuevo llamado Gemfile con el siguiente contenido: 

 ```ruby
 source 'https://rubygems.org'
 ruby '2.6.6'  
 gem 'sinatra','>= 2.0.1'
 ```
             
Este archivo reconocera las versiones de las gemas (bibliotecas) que utilizaremos en nuestra aplicacion.

Luego, procedemos a la instalación de estas gemas ejecutando el comando `bundle install`. Esta acción instala automáticamente las gemas necesarias para el funcionamiento de nuestra aplicación.

![Alt text](image.png)

Para mantener un sistema de control de versiones para nuestra aplicación, utilizamos Git. Gracias a la configuración previa del Gemfile, podemos controlar las versiones de manera efectiva a través de Git.

![Alt text](image-1.png)

 

### Preguntas 
<details><summary>Respuestas</summary>
<p><blockquote>

**¿Cuál es la diferencia entre el propósito y el contenido de Gemfile y Gemfile.lock?**


El archivo *Gemfile* que creamos alberga una lista de todas las gemas necesarias para nuestra aplicación.

![Alt text](image-3.png)

Por otro lado, *Gemfile.lock* registra no solo las versiones de estas gemas, sino también las versiones de otras dependencias requeridas por las gemas especificadas en Gemfile.

![Alt text](image-2.png)

**¿Qué archivo se necesita para reproducir completamente las gemas del entorno de desarrollo en el entorno de producción?**

Para reproducir completamente las gemas del entorno de desarrollo en el entorno de producción, se necesita el archivo *Gemfile.lock*. Este archivo proporciona información detallada sobre las versiones exactas de las gemas y sus dependencias que deben instalarse para que la aplicación funcione correctamente en producción.


**Después de ejecutar el bundle, ¿Por qué aparecen gemas en Gemfile.lock que no estaban en Gemfile?**

Al ejecutar el comando "bundle", Bundler examina las gemas especificadas en el archivo Gemfile. Por ejemplo, cuando se instala Sinatra, Bundler detecta que esta dependencia tiene requisitos adicionales, por lo que de manera recursiva instala todas las dependencias necesarias para satisfacer estos requisitos.
    
</p></blockquote></details>

## Crea una aplicación SaaS sencilla con Sinatra
Como se ha explicado las aplicaciones SaaS requieren un servidor web para recibir solicitudes HTTP del mundo exterior y un servidor de aplicaciones que "conecte" la lógica de su aplicación al servidor web. Para el desarrollo, usaremos webrick, un servidor web muy simple basado en Ruby que sería inapropiado para producción pero que está bien para el desarrollo. Tanto en desarrollo como en producción, utilizaremos el servidor de aplicaciones en rack basado en Ruby, que admite aplicaciones Ruby escritas en varios frameworks, incluidos Sinatra y Rails.
Como se ha explicado una aplicación SaaS esencialmente reconoce y responde a las solicitudes HTTP correspondientes a las rutas de la aplicación (recuerda que una ruta consta de un método HTTP como GET o POST más un URI). Sinatra proporciona una abreviatura ligera para coincidir una ruta con el código de aplicación que se ejecutará cuando llegue una solicitud de uso de esa ruta desde el servidor web.
Crea un archivo en tu proyecto llamado app.rb que contenga lo siguiente:
```ruby	
require 'sinatra' 
    class MyApp < Sinatra::Base 
        get '/' do 
            "<!DOCTYPE html><html><head></head><body><h1>Hello World</h1></body></html>" 
    end 
end
```
El método get lo proporciona la clase Sinatra::Base, de la cual hereda la clase MyApp. Sinatra::Base está disponible porque cargamos la biblioteca Sinatra en la línea 1.
Como puedes ver en el ejemplo simple anterior, Sinatra te permite escribir funciones que coinciden con una ruta HTTP entrante, en este caso GET '/' (la URL raíz), se devolverá a la presentación un documento HTML muy simple que contiene la cadena Hello world como resultado de la solicitud.
Para ejecutar la aplicación, tenemos que iniciar el servidor de aplicaciones y el servidor de nivel de presentación (web). El servidor de aplicaciones en rack está controlado por un archivo config.ru, que ahora debe crear y agregar al control de versiones, y que contiene lo siguiente:
```ruby
require './app' 
run MyApp
```
La primera línea le dice a Rack que la aplicación se encuentra en el archivo app.rb, que creó anteriormente para contener el código de tu aplicación. Tenemos que indicar explícitamente que el archivo de la aplicación está ubicado en el directorio actual (.) porque normalmente require busca solo en directorios estándar del sistema para encontrar gemas.
Ahora estás listo para probar la sencilla aplicación con una línea de comando:

    bundle exec rackup --port 3000

<details><summary>Respuesta</summary>
<p><blockquote>
Ejecutando el comando `bundle exec rackup --port 3000` nos muestra que nuestra aplicacion esta corriendo en el puerto 3000 :

![Alt text](image-4.png)

si ingresamos a la ruta http://localhost:3000/ nos mostrara el mensaje Hello World: 

![Alt text](image-5.png)

</p></blockquote></details>


## Pregunta
¿Qué sucede si intentas visitar una URL no raíz cómo https://localhost:3000/hello y por qué? (la raíz de tu URL variará)
<details><summary>Respuesta</summary>
<p><blockquote>
Al acceder a la ruta http://localhost:3000/hello nos mostrara un error ya que no existe esa ruta en nuestra aplicacion , por lo que nos mostrara el siguiente mensaje:

![Alt text](image-6.png)

</p></blockquote></details>

## Modifica la aplicación
Modifica app.rb para que en lugar de "Hello world" imprime "Goodbye world". Guarda tus cambios en app.rb e intenta actualizar la pestaña de tu navegador donde se ejecuta la aplicación.
Ahora regresa a la ventana del shell donde ejecutaste rackup y presione Ctrl-C para detener Rack. Luego escribe bundle exec rackup --port 3000 para desarrollo local y una vez que se esté ejecutando, regresa a la pestaña de tu navegador con tu aplicación y actualiza la página. Esta vez debería funcionar.

<details><summary>Respuesta</summary>
<p><blockquote>
Primero cancelamos la ejecucion de la aplicacion con el comando `Ctrl-C`  :

![Alt text](image-8.png)


modificamos el archivo app.rb para que nos muestre el mensaje Goodbye world y ejectuamos el comando `bundle exec rackup --port 3000` para volver a ejecutar la aplicacion :

![Alt text](image-9.png)

</p></blockquote></details>

Lo que esto te muestra es que, si modificas tu aplicación mientras se está ejecutando, debes reiniciar Rack para que "veas" esos cambios. Dado que reiniciarlo manualmente es tedioso, usaremos la gema de rerun, que reinicia Rack automáticamente cuando ve cambios en los archivos en el directorio de la aplicación. (Rails hace esto de forma predeterminada durante el desarrollo, como veremos, pero Sinatra no).
Probablemente ya estés pensando:  Si la aplicación depende de esta gema adicional, debemos agregarla al Gemfile y ejecutar el paquete para asegurarnos de que esté realmente presente”. Buen pensamiento. Pero también se te puede ocurrir que esta gema en particular no sería necesaria en un entorno de producción: sólo la necesitamos como herramienta durante el desarrollo. Afortunadamente, hay una manera de decirle a Bundler que algunas gemas sólo son necesarias en determinados entornos. Agrega lo siguiente al Gemfile (no importa dónde):
<details><summary>Respuesta</summary>
<p><blockquote>
Agregamos la gema rerun al archivo Gemfile :

![Alt text](image-10.png)

al tener esto , no sera necesario reiniciar el servidor cada vez que hagamos un cambio en nuestra aplicacion , ya que esta gema se encargara de reiniciar el servidor automaticamente.
Ejecutamos el comando `bundle install` para instalar la gema rerun para luego ejecutar el comando `bundle exec rerun rackup --port 3000` para ejecutar la aplicacion con la gema rerun :

![Alt text](image-11.png)

El puerto estaria de esta forma : 

![Alt text](image-12.png)

Ahora si cambiamos el mensaje del html a Hello worl ! y guardamos , el servidor detectara el cambio y reiniciara automaticamente :

![Alt text](image-13.png)

y si vemos en el navegador el mensaje cambio :

![Alt text](image-14.png)

</p></blockquote></details>

## Implementar en Heroku
Heroku es una plataforma como servicio (PaaS) en la nube donde podemos implementar las aplicaciones Sinatra (y posteriores Rails). Si aún no tiene una cuenta, regístrese en http://www.heroku.com. Necesitarás su nombre de usuario y contraseña para el siguiente paso.
Instala Heroku CLI siguiendo las instrucciones. 
Inicia sesión en tu cuenta Heroku escribiendo el comando: heroku login -i en la terminal. Esto te conectará con tu cuenta Heroku.

<details><summary>Respuesta</summary>
<p><blockquote>

ejecutamos el comando y nos pedira el correo y la contraseña de nuestra cuenta de heroku : 

![Alt text](image-15.png)

heroku create :

![Alt text](image-16.png)

Procfile:
![Alt text](image-17.png)

Luego subimos el repositorio a heroku con el comando `git push heroku master` :

![Alt text](image-18.png)

Viendolo desde la pagina de heroku :

![Alt text](image-19.png)

![Alt text](image-20.png)

Vemos que se ejecuta correctamente .
</p></blockquote></details>

## Parte 1: Wordguesser
Con toda esta maquinaria en mente, clona este repositorio y trabajemos el juego de adivinar palabras (Wordguesser).

    Clonaremos el repositorio de wordguesser con el repositorio e ingresaremos a este 

![Alt text](image-21.png)


## Desarrollo de Wordguesser usando TDD y Guard
En esta actividad utilizaremos el desarrollo basado en pruebas (TDD) basado en las pruebas que proporcionamos para desarrollar la lógica del juego para Wordguesser, lo que te obliga a pensar en qué datos son necesarios para capturar el estado del juego. Esto será importante cuando hagas el juego en forma SaaS en la siguiente parte.
Qué harás: utilizarás  autotest: los casos de prueba proporcionados se volverán a ejecutar cada vez que realices un cambio en el código de la aplicación. Una por una, las pruebas pasarán de rojo (reprobado) a verde (aprobado) a medida que creas el código de la aplicación. Cuando hayas terminado, tendrá una clase de juego Wordguesser funcional, lista para ser "envuelta" en SaaS usando Sinatra.
El juego de adivinanzas de palabras basado en la Web funcionará de la siguiente manera:
-	La computadora elige una palabra al azar.
-	El jugador adivina letras para adivinar la palabra.
-	Si el jugador adivina la palabra antes de adivinar siete letras incorrectamente, gana, de lo contrario pierden. (Adivinar la misma letra repetidamente simplemente se ignora).
-	Una letra que ya ha sido adivinada o que no es un carácter del alfabeto se considera "no válida", es decir, no es una adivinación "válida".
Para que el juego sea divertido, cada vez que inicies un nuevo juego, la aplicación recuperará 	una palabra en inglés aleatoria de un servidor remoto, por lo que cada juego será diferente. Esta 	característica te presentará no sólo el uso de un servicio externo (el generador de palabras 	aleatorias) como un "bloque de construcción" en una arquitectura orientada a servicios, sino 	también cómo un escenario de Cucumber puedes probar dicha aplicación de manera 		determinista con pruebas que rompan la dependencia del servicio externo en el momento de 	la prueba.
-	En el directorio raíz de la aplicación, escribe bundle exec autotest.
Esto activará el framework Autotest, que busca varios archivos para determinar qué tipo de aplicación estás probando y qué framework de prueba estás usando. En este caso, descubrirá el archivo llamado .rspec, que contiene opciones de RSpec e indica que estamos usando el framework de prueba de RSpec. Por lo tanto, Autotest buscará archivos de prueba en spec/ y los archivos de clase correspondientes en lib/.
Proporcionamos un conjunto de 18 casos de prueba para ayudarte a desarrollar la clase de juego. Echa un vistazo a spec/wordguesser_game_spec.rb. Especifica los comportamientos que espera de la clase lib/wordguesser_game.rb. Inicialmente, agregamos :pending => true a cada especificación (spec), por lo que cuando Autotest las ejecute por primera vez, debería ver los nombres de los casos de prueba impresos en amarillo y el informe "18 examples, 0 failures, 18 pending".
Ahora, con Autotest aun ejecutándose, elimina :pending => true y guarde el archivo. Deberías ver inmediatamente que Autotest se activa y vuelve a ejecutar las pruebas. Ahora debería tener 18 ejemplos, 1 fallido y 17 pendientes.
El bloque describe ‘new’ significa "el siguiente bloque de pruebas describe el comportamiento de una 'nueva' instancia de WordGuesserGame". La línea WordGuesserGame.new hace que se cree una nueva instancia y las siguientes líneas verifican la presencia y los valores de las variables de instancia.





