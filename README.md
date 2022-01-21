# Práctica

1. Hacer un wrapper para el JSON modelando las identidades:
  - Person
  - Starship
  - Vehicle

2. Crear una clase padre para manejar la conexión con la DB.
3. Crear Modulos para manejar las relaciones

### Interfaz esperada:
```ruby
Model.all  # => Arreglo de instancias de Model
Model.find(id) # => Instancia de Model con el id pasado por parametro o nil si no se encuentra

# Metodos para acceder a los atributos de los modelos

person = Person.find(1)

person.name # => Luke Skywalker
person.height # => 172
person.vehicles # => [<Vehicle>, <Vehicle>]
```

# Práctica 2

1. Crear una Gema que contenga las Clases y Modulos de la Práctica anterior.
2. Crear un API con Sinatra (http://sinatrarb.com/):
  - Debe tener a endpoint /people/:id, me devuelva un personaje con todo la info relacionada.
  - Debe ser un projecto con su propio Gemfile
  - Debe tener como dependencia unicamente Sinatra y nuestra gema wrapper

