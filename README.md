# Creacion de aplicacionde SaaS
Objetivo: comprender los pasos necesarios para crear, versionar e implementar una aplicación SaaS, incluido el seguimiento de las librerías de las que depende para que sus entornos de producción y desarrollo sean lo más similares posible.

Qué harás: crear una aplicación sencilla de "Hello world" utilizando el framework Sinatra, versionarla correctamente e implementarla en Heroku.

## Creación y versionado de una aplicación SaaS sencilla

Comencemos con los siguientes pasos:

- Crea un nuevo directorio vacío para contener tu nueva aplicación y usa git init en ese directorio para comenzar a versionarlo con Git.

- En ese directorio, crea un nuevo archivo llamado Gemfile (las mayúsculas son importantes) con el siguiente contenido. Este archivo será una parte permanente de su aplicación y viajará con su aplicación a donde quiera que vaya: source 'https://rubygems.org'

ruby '2.6.6'

gem 'sinatra', '>= 2.0.1'

La primera línea dice que el lugar preferido para descargar las gemas necesarias es https://rubygems.org, que es donde la comunidad Ruby registra las gemas "listas para producción".

La segunda línea especifica qué versión del intérprete de lenguaje Ruby se requiere. Si omitiéramos esta línea, Bundler no intentaría verificar qué versión de Ruby está disponible; Existen diferencias sutiles entre las versiones y no todas las gemas funcionan con todas las versiones, por lo que es mejor especificar esto.

La última línea dice que necesitamos la versión 2.0.1 o posterior de Sinatra. En algunos casos no necesitamos especificar qué versión de una gema queremos. En este caso lo especificamos porque nos basamos en algunas características que están ausentes en versiones anteriores de Sinatra

<details><summary>Respuesta</summary>
<p><blockquote>
Crearemos un directorio llamado produccion y dentro de este directorio crearemos un archivo llamado Gemfile con el siguiente contenido:

```ruby

source 'https://rubygems.org'

ruby '2.6.6'

gem 'sinatra', '>= 2.0.1'
```	
Este archivo reconocera las versiones de las gemas (bibliotecas) que utilizaremos en nuestra aplicacion.
ahora para la instalacion ejecutaremos el comando `bundle install`

Al ejecutar este comando nos instala las gemas que necesitamos para nuestra aplicacion.

![Alt text](image.png)

Para tener un sistema de versiones de nuestra aplicacion usaremos git , como ya tenemos el gemfile configurado ,controlaremos las 
versiones con git 

![Alt text](image-1.png)

</p></blockquote>
</details>


## Preguntas 
¿Cuál es la diferencia entre el propósito y el contenido de Gemfile y Gemfile.lock? ¿Qué archivo se necesita para reproducir completamente las gemas del entorno de desarrollo en el entorno de producción?
Después de ejecutar el bundle, ¿por qué aparecen gemas en Gemfile.lock que no estaban en Gemfile?

<details><summary>Respuesta</summary>
<p><blockquote>
El archivo Gemfile que creamos es donde tendremos todas las gemas que necesitamos para la aplicacion ,mientras que Gemfile.lock guarda las versiones de estas y tambien las versiones de otras dependencias que necesitan las gemas que tenemos en Gemfile.
Por lo que asi tendriamos nuestros archivos :       


# Gemfile:

![Alt text](image-3.png)
# Gemfile.lock:
![Alt text](image-2.png)


Al ejecutar el comando , Bundle busca informacion de las gemas que se encuantran en el archivo Gemfile , por ejemplo sinatra , al instalar sinatra , bundle ve que esta dependencia requiere de otras por las que de manera recursiva instala todas las dependencias necesarias .

</p></blockquote>
</details>

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

</p></blockquote></details>



