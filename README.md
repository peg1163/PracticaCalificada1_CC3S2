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

![Alt text](Imagenes/image.png)

Para mantener un sistema de control de versiones para nuestra aplicación, utilizamos Git. Gracias a la configuración previa del Gemfile, podemos controlar las versiones de manera efectiva a través de Git.

![Alt text](Imagenes/image-1.png)

 

### Preguntas 
<details><summary>Respuestas</summary>
<p><blockquote>

**¿Cuál es la diferencia entre el propósito y el contenido de Gemfile y Gemfile.lock?**

![Alt text](Imagenes/image-3.png)

El archivo *Gemfile* que creamos alberga una lista de todas las 

Por otro lado, *Gemfile.lock* registra no solo las versiones de estas gemas, sino también las versiones de otras dependencias requeridas por las gemas especificadas en Gemfile.

![Alt text](Imagenes/image-2.png)

**¿Qué archivo se necesita para reproducir completamente las gemas del entorno de desarrollo en el entorno de producción?**

Para reproducir completamente las gemas del entorno de desarrollo en el entorno de producción, se necesita el archivo *Gemfile.lock*. Este archivo proporciona información detallada sobre las versiones exactas de las gemas y sus dependencias que deben instalarse para que la aplicación funcione correctamente en producción.


**Después de ejecutar el bundle, ¿Por qué aparecen gemas en Gemfile.lock que no estaban en Gemfile?**

Al ejecutar el comando "bundle", Bundler examina las gemas especificadas en el archivo Gemfile. Por ejemplo, cuando se instala Sinatra, Bundler detecta que esta dependencia tiene requisitos adicionales, por lo que de manera recursiva instala todas las dependencias necesarias para satisfacer estos requisitos.
    
</p></blockquote></details>

## Crea una aplicación SaaS sencilla con Sinatra

En el desarrollo de aplicaciones SaaS, comenzaremos con Webrick para pruebas y luego usaremos Rack en producción. Sinatra, un marco ligero, nos permitirá definir cómo nuestra aplicación manejará solicitudes HTTP.

**Paso 1: Creación del Archivo de la Aplicación**

En un archivo llamado app.rb, escribimos el siguiente código:

```ruby	
require 'sinatra' 
    class MyApp < Sinatra::Base 
        get '/' do 
            "<!DOCTYPE html><html><head></head><body><h1>Hello World</h1></body></html>" 
    end 
end
```
Este código responde con "Hello World" cuando accedemos a la URL proporcionada.

**Paso 2: Configuración del Archivo config.ru**

Creamos un archivo llamado config.ru con el siguiente contenido:


```ruby
require './app' 
run MyApp
```
Esto le dice a Rack que nuestra aplicación se encuentra en app.rb.

**Paso 3: Ejecución de la Aplicación**

Finalmente, ejecutamos la aplicación con el siguiente comando:

    bundle exec rackup --port 3000

Después de haber completado los pasos anteriores, podremos verificar que nuestra aplicación está en funcionamiento en el puerto 3000, como se muestra en la siguiente imagen: 

![Alt text](Imagenes/image-4.png)

Como se menciono en el paso 2, al acceder a la ruta http://localhost:3000/ veremos el mensaje Hello World, como se muestra a continuación: 

![Alt text](Imagenes/image-5.png)

## Pregunta
 
**¿Qué sucede si intentas visitar una URL no raíz cómo https://localhost:3000/hello y por qué?**
<details><summary>Respuesta</summary>
<p><blockquote>
Si intentamos acceder a la ruta http://localhost:3000/hello, se generará un error, ya que dicha ruta no está definida en nuestra aplicación. Esto dará como resultado que muestre el siguiente mensaje de error:

![Alt text](Imagenes/image-6.png)

</p></blockquote></details>

## Modifica la aplicación
Para cambiar la salida de nuestra aplicación de "Hello world" a "Goodbye world", seguimos los siguientes pasos:
 
1. Detuvimos la aplicación actual mediante el comando `Ctrl-C`, como se muestra en la siguiente imagen:

    ![Alt text](Imagenes/image-8.png)


2. Luego, modificamos el archivo app.rb para que la aplicación muestre el mensaje "Goodbye world".
3. Después, reiniciamos la aplicación utilizando el comando bundle exec `rackup --port 3000` para el desarrollo local.

    ![Alt text](Imagenes/image-9.png)


Esto ilustra que al realizar modificaciones en nuestra aplicación mientras esta se encuentra en ejecución, debemos reiniciar Rack para que los cambios surtan efecto. Para automatizar este proceso, podemos emplear la gema `rerun`, que reinicia automáticamente Rack cuando detecta cambios en los archivos del directorio de la aplicación.

Continuando, añadimos la gema `rerun` a nuestro archivo Gemfile, como se muestra en la siguiente imagen:

![Alt text](Imagenes/image-10.png)

Con esto, ya no será necesario reiniciar manualmente el servidor cada vez que realicemos cambios en nuestra aplicación. La gema `rerun` se encargará de reiniciar automáticamente el servidor por nosotros.

**Instalación de la Gema "rerun" y Ejecución de la Aplicación con ella**

Para hacer uso de la gema `rerun` seguimos estos pasos:

1. Ejecutamos el comando bundle install para instalar la gema `rerun`.


2. Luego, ejecutamos la aplicación con la gema "rerun" utilizando el comando bundle exec rerun rackup --port 3000, como se ilustra en la imagen.
![Alt text](Imagenes/image-11.png)

3. Con esto, el puerto estará configurado de la siguiente manera:  

    ![Alt text](Imagenes/image-12.png)

**Detección Automática de Cambios y Reinicio Automático del Servidor**

Ahora, si modificamos el mensaje HTML en nuestra aplicación a "Hello worl !" y guardamos los cambios, el servidor detectará automáticamente la modificación y se reiniciará por sí mismo, como se muestra aquí:

![Alt text](Imagenes/image-13.png)

Si observamos el navegador, veremos que el mensaje también ha cambiado:

![Alt text](Imagenes/image-14.png)

## Implementar en Heroku
Heroku es una plataforma como servicio (PaaS) en la nube que nos permite implementar nuestras aplicaciones Sinatra (y más adelante, Rails). Procedemos a crear una cuenta en http://www.heroku.com para poder llevar a cabo esta implementación.

**Paso 1: Instalamos Heroku CLI**  
**Paso 2: Iniciamos Sesión en nuestra Cuenta Heroku**
Ejecutamos el comando  `heroku login -i ` en nuestra terminal. Esto nos solicita ingresar el correo y la contraseña de nuestra cuenta de Heroku.

![Alt text](Imagenes/image-15.png)

**Paso 3: Creamos una Nueva Aplicación Heroku**

Utilizamos el comando `heroku create` para crear una nueva aplicación en Heroku.

![Alt text](Imagenes/image-16.png)

**Paso 4: Creamos un Archivo Procfile**

Creamos un archivo llamado "Procfile" en nuestro proyecto con las instrucciones necesarias para ejecutar nuestra aplicación en Heroku. Este archivo define el proceso web que Heroku debe ejecutar.

![Alt text](Imagenes/image-17.png)

**Paso 5: Subimos nuestro Repositorio a Heroku**
Usamos el comando `git push heroku master` para cargar nuestro repositorio en Heroku.

![Alt text](Imagenes/image-18.png)

**Paso 6: Verificamos la Implementación en Heroku**

Podemos verificar la ejecución de nuestra aplicación desde la página de Heroku.



![Alt text](Imagenes/image-19.png)

Si todo se ejecuta correctamente, vemos nuestra aplicación en funcionamiento en la plataforma Heroku.

![Alt text](Imagenes/image-20.png)
 
Este proceso nos permite llevar nuestra aplicación Sinatra a la nube y hacerla accesible en línea a través de Heroku.

# Parte 1: Wordguesser
Con todos estos pasos en mente, procedamos a clonar este repositorio y a trabajar en el juego de adivinanza de palabras, conocido como Wordguesser.

Para llevar a cabo esto, clonamos el repositorio de Wordguesser utilizando el siguiente comando:

    git clone https://github.com/saasbook/hw-sinatra-saas-wordguesser

Luego, ingresamos al repositorio clonado para continuar con nuestro trabajo.

    cd hw-sinatra-saas-wordguesser 

A continuación, se presenta una vista de lo que realizamos:

![Alt text](Imagenes/image-21.png)
 


## Desarrollo de Wordguesser usando TDD y Guard

En esta etapa del desarrollo, nos centraremos en implementar la lógica del juego Wordguesser utilizando la metodología de Desarrollo Basado en Pruebas (TDD). 

 
A diferencia de lo que se muestra en la aplicación, optamos por utilizar Guard en lugar de Autotest para ejecutar las pruebas. Esta decisión se basó en ciertos problemas que enfrentamos con las gemas desactualizadas en el proyecto clonado, ya que este requería una versión específica de Ruby, que en este caso era Ruby 2.6.6. Para gestionar esta versión de Ruby, utilizamos RVM (Ruby Version Manager). Esto nos permitió asegurarnos de que estábamos trabajando con la versión exacta de Ruby que el proyecto requería- Sin embargo, dado que Autotest no funcionaba correctamente debido a las discrepancias en las gemas y las versiones de Ruby, decidimos optar por Guard para la ejecución de las pruebas. Guard nos proporcionó una solución más efectiva para administrar las pruebas y asegurarnos de que funcionaran sin problemas, incluso con nuestras gemas actualizadas y la versión específica de Ruby.
 

Una vez configurado nuestro entorno y ejecutado el guard, nos dimos cuenta de que había un conjunto de 18 pruebas pendientes:

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/52f637ee-6858-48cc-b381-a96c902a8491)

Comenzaremos eliminando pending => true (estado pendiente) de la primera prueba y guardamos el archivo.Esto hará que Guard ejecute automaticamente las pruebas relacionadas.

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/8de29370-0907-495e-b7bb-19ba1263f4ef) 

Como momencionamos eliminamos  pending => true (estado "pendiente"), de este modo esta prueba dejará de estar pendiente, pero aún se observa que la prueba fallará, esto debio a que aún no hemos implementado el método al cual la prueba hace referencia.

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/3599338a-3940-4524-9f55-a2ef5582e2a2)

## Pregunta
**Según los casos de prueba, ¿Cuántos argumentos espera el constructor de la clase de juegos (identifica la clase) y, por lo tanto, cómo será la primera línea de la definición del método que debes agregar a `wordguesser_game.rb`?**

```ruby
describe 'new' do
  it "takes a parameter and returns a WordGuesserGame object" do
    @game = WordGuesserGame.new('glorp')
    expect(@game).to be_an_instance_of(WordGuesserGame)
    expect(@game.word).to eq('glorp')
    expect(@game.guesses).to eq('')
    expect(@game.wrong_guesses).to eq('')
  end
end
```
 
<details><summary>Respuesta</summary>
<p><blockquote>

 El constructor de la clase WordGuesserGame espera un argumento, que es la palabra a adivinar. Entonces, la primera línea de la definición del método initialize en el archivo `wordguesser_game.rb` debería ser:
```  ruby
    def initialize(word_to_guess)
   ```
Esto significa que el constructor tomará un único argumento llamado *word_to_guess*, que será la palabra que se va a adivinar.  
</p></blockquote></details>

**Según las pruebas de este bloque describe, ¿Qué variables de instancia se espera que tenga WordGuesserGame?**

<details><summary>Respuesta</summary>
<p><blockquote>

Según las pruebas en el bloque `describe`, se espera que la clase `WordGuesserGame` tenga tres variables de instancia. La primera, `@game.word`, debería contener la palabra a adivinar. La segunda, `@game.guesses`, se llenará con las letras adivinadas correctamente y estará vacía al inicio. La tercera, `@game.wrong_guesses`, se utilizará para almacenar letras adivinadas incorrectamente y también comenzará vacía.
</p></blockquote></details>


Continuando con la actividad, implementamos la clase `WordGuesserGame` con un constructor que acepte los argumentos necesarios según las pruebas que tenemos. Además nos aseguramos de que estas variables actúen como getters y setters para que podamos acceder y modificar sus valores según sea necesario para pasar las pruebas.

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/b376477f-0b61-4e5e-b7be-1d0706694bf7)


Anteriormente, eliminamos *pending => true* de la primera prueba, como se puede observar, ya que planeamos trabajar en esta prueba una vez que hayamos implementado completamente la clase `WordGuesserGame`.

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/2d3d510f-0329-4a62-be25-248f58a83b49)

Cuando guardamos los cambios, el sistema de guardado detecta la modificación y nos muestra el siguiente mensaje:

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/982b03c6-f0d6-490b-8c38-df47a7179f94)

Luego, continuamos eliminando *:pending => true* del resto de las pruebas: guess, check_win_or_lose y word_with_guesses.


Siguiendo las pruebas y los casos propuestos, a continuación, se presenta la prueba "guessing": 

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/49aeb148-f8e7-41c2-b463-da40febf7c7f)


![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/e99f81b6-a226-4064-a4be-ca2b0e1ad97b)


Para esta prueba se implementa el método guess de la clase `WordGuesserGame`

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/7e526a76-99ad-4769-b713-6e52b4430f4a)

Analogamente para el resto  pruebas check_win_or_lose y word_with_guesses

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/740c20df-b915-45c5-9bea-439c766cf963)

Se definio para prueba, su método respectivo.

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/912cc220-3d9a-4584-accc-1db03e1aac9d)

Al guardar y actualizar las pruebas, hemos comprobado que cumplen con todos los requisitos necesarios:

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/205c91dc-8c43-4309-946b-8504106ce2f9)

Este proceso de desarrollo y pruebas asegura que nuestro código cumpla con los estándares y funcione correctamente.

# Parte 2: RESTful para Wordguesser

## Identificación del estado mínimo del juego

Antes de diseñar la aplicación, es importante identificar cuál es el estado mínimo del juego que debemos mantener para que los usuarios puedan jugar de manera efectiva. Este estado mínimo es esencial para preservar el progreso del juego entre las solicitudes HTTP.

**Pregunta 1: Enumera el estado mínimo del juego que se debe mantener durante una partida de Wordguesser.**

El estado mínimo del juego que debe mantenerse incluye:
- La palabra oculta que el jugador está tratando de adivinar.
- Las letras adivinadas correctamente.
- Las letras adivinadas incorrectamente.
- El número de intentos restantes.


## Identificación de las acciones del jugador

Para diseñar una aplicación interactiva como Wordguesser, es crucial identificar las acciones que los jugadores pueden realizar y que tienen un impacto en el estado del juego. Estas acciones definirán las rutas RESTful de la aplicación.

**Pregunta 2: Enumera las acciones del jugador que podrían provocar cambios en el estado del juego.**

 Las acciones del jugador que pueden cambiar el estado del juego incluyen:
- Adivinar una letra.
- Comenzar un nuevo juego.

## Asignación de métodos HTTP en un diseño RESTful

En el diseño de una aplicación RESTful, es fundamental asignar correctamente los métodos HTTP a las operaciones de recursos. Esto garantiza que las solicitudes se manejen de manera coherente y segura.

**Pregunta 3: Para un buen diseño RESTful, ¿cuáles de las operaciones de recursos deberían ser manejadas por HTTP GET y cuáles deberían ser manejadas por HTTP POST?**

En un diseño RESTful, las operaciones suelen manejarse de la siguiente manera:
- `GET` se utiliza para acciones que no modifican el estado del servidor y que pueden mostrarse en una página web, como mostrar el estado actual del juego o las páginas de victoria/derrota.
- `POST` se utiliza para acciones que modifican el estado del servidor, como enviar una adivinanza o iniciar un nuevo juego.

## Uso de `GET` en la acción "nueva"
En el diseño RESTful, es importante asignar el método HTTP correcto para cada acción. La pregunta se centra en la elección de `GET` para la acción "nueva" y su justificación.

**Pregunta 4: ¿Por qué es apropiado que la nueva acción utilice GET en lugar de POST?**

La acción "nueva" utiliza el método `GET` porque no modifica el estado del servidor. Simplemente muestra un formulario para que el usuario humano inicie un nuevo juego, y esta acción no tiene un impacto directo en el servidor.

## Acción `GET /new` en una arquitectura orientada a servicios

Se explora la necesidad de la acción `GET /new` en el contexto de una arquitectura orientada a servicios frente a una aplicación web tradicional.

**Pregunta 5: Explica por qué la acción GET /new no sería necesaria si tu juego Wordguesser fuera llamado como un servicio en una verdadera arquitectura orientada a servicios.**

En una arquitectura orientada a servicios, los servicios web generalmente no necesitan una acción `GET /new` porque las interacciones se realizan programáticamente a través de API y no a través de interfaces web humanas. La acción `GET /new` es específica de una interfaz web para permitir que los usuarios inicien juegos manualmente.


# Parte 4 : Cucumber 

## Preguntas
Lea la sección sobre " Using Capybara with Cucumber”  en la página de inicio de Capybara. ¿Qué pasos utiliza Capybara para simular el servidor como lo haría un navegador? ¿Qué pasos utiliza Capybara para inspeccionar la respuesta de la aplicación al estímulo?
Mirando features/guess.feature, ¿cuál es la función de las tres líneas que siguen al encabezado "Feature:"?
En el mismo archivo, observando el paso del escenario Given I start a new game with word "garply" qué líneas en game_steps.rb se invocarán cuando Cucumber intente ejecutar este paso y cuál es el papel de la cadena "garply" en el paso?
### Haz que pase tu primer escenario

Al ejecutar el comando cucumber features/start_new_game.feature vemos que la prueba no llega a pasar ya que necesitamos completar algunos atributos en el <form> : 

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/404a4e4e-b3ed-431c-b4b0-cda04b50c789)

Agregando un atributo mas el cual es " action " 

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/2abd62b5-a10e-4e2b-8cde-f239349ebef6)

Ejecutando el comando de prueba :

![image](https://github.com/peg1163/PracticaCalificada1_CC3S2/assets/92898224/891d9420-df8f-4f2f-871a-46805bc89268)

## Pregunta 
¿Cuál es el significado de usar Given versus When versus Them en el archivo de características? ¿Qué pasa si los cambias? Realiza un experimento sencillo para averiguarlo y luego confirme los resultados utilizando Google.

### Desarrollar el escenario para adivinar una letra



















