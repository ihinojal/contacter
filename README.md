# CONTACTER

## Que es contacter?
Esta aplicación Ruby on Rails permite a un usuario registrado guardar
sus contactos.

Cada contacto debe tener obligatoriamente nombre, apellidos y email,
donde el email debe ser único.Además el contacto puede tener una foto y
varios teléfonos. Los contactos pueden ser de tres tipos: amigos,
familiares y compañeros.

Los usuarios mediante la web pueden ver, crear, actualizar, borrar sus
contactos, y buscar por nombre y/o apellidos

Via API se puden:
  a) ver los contactos de un usuario
  b) ver el detalle de cada contacto

Via Cliente se pueden:
  a) ver los contactos de un usuario
  b) ver el detalle de cada contacto

## Como instalar contacter?

Necesitas instalar imagemagick. Para ello..
Si estas en Mac OS X:

    $ brew install imagemagick

Si estas cualquier distrubucion basada en debian:

    $ sudo apt-get install imagemagick -y

Descarga el codigo de github con:

     $ git clone git@github.com:ihinojal/contacter.git

Descarga las gemas dependientes del proyecto con:

     $ bundle install

Ejecuta el servidor en modo development con:

     $ rails server

Ahora podrás ver la web en http://localhost:3000


## API contacter

Contacter tiene una API sencilla que permite recuperar todos los
contactos de un usuario a partir de su ID, o ver el detalle de un
contacto determinado.

#### Listar contactos de un usuario

  Sintaxis: `GET /users/:user_id/contacts.json`

  Ejemplo: `GET /users/1/contacs.json`

  Respuesta de ejemplo:

    [
      {"id":1,
       "user_id":1,
       "name":"Pepe",
       "surname":"Gutierrez",
       "email":"pepe@example.com",
       "picture":"/pictures/original/missing.png",
       "type_of_contact":"friend",
       "url":"http://localhost:3000/contacts/1.json"}
    ]

#### Listar un contacto determinado

  Sintaxis: `GET /contacts/:id.json`

  Ejemplo: `GET /contacts/3.json`

  Respuesta de ejemplo:

    {"id":1,
      "user_id":1,
      "name":"Pepe",
      "surname":"Gutierrez",
      "email":"pepe@example.com",
      "picture":"/pictures/original/missing.png",
      "type_of_contact":"friend",
      "url":"http://localhost:3000/contacts/1.json"}


## Cliente API

  Se incluye un cliente para hacer peticiones a la API usando JSON.
  A modo de ejemplo puedes ejecutar la consola de rails:

    $ rails console
      > c = ContacterApi.new('http://localhost:3000')
        #=> #<ContacterApi @host="http://localhost:3000">
      > c.get_user_contacts 1
        #=> [{"id"=>1, "user_id"=>1, "name"=>"Pepe", "surname"=>"Gutierrez", "email"=>"pepe@example.com", "picture"=>"/pictures/original/missing.png", "type_of_contact"=>"friend", "url"=>"http://localhost:3000/contacts/1.json"}]
      > c.get_contact 1
        #=> {"id"=>1, "user_id"=>1, "name"=>"Pepe", "surname"=>"Gutierrez", "email"=>"pepe@example.com", "picture"=>"/pictures/original/missing.png", "type_of_contact"=>"friend", "created_at"=>"2016-04-10T17:34:57.620Z", "updated_at"=>"2016-04-10T17:34:57.620Z"}


## Cómo ejecutar las 'specs'

  En la raiz donde se encuentre descargada ejecuta:

    $ rspec --format documentation

