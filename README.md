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
