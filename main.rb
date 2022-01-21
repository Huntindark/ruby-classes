# frozen_string_literal: true

require 'json'

# https://ruby-doc.org/core-3.0.3/File.html
# Read JSON file

# https://ruby-doc.org/stdlib-3.0.3/libdoc/json/rdoc/JSON.html
# Parse JSON content to Hash

# https://github.com/ruby/debug

class JsonReader
  @@collection ||= Hash.new 
  
  def self.collection
    @@collection
  end

  def self.loadCollection(what)
    @@collection[self.to_s.downcase] ||= Array.new
    file = File.read("swapi.json")
    data_hash = JSON.parse(file)
    data_hash[what].each { |item| @@collection[self.to_s.downcase].append(self.new(item))}
  end

  def self.all
    @@collection
  end

  def self.find(id)
    @@collection[self.to_s.downcase].find { |item| item.id == id }
  end

end

class Person < JsonReader
  attr_accessor :height, :mass, :hair_color, :skin_color, :vehicles, :starships
  attr_reader :id, :name, :birth_year, :gender, :eye_color

  def initialize(params = {})
    @id = params.fetch('id')
    @name = params.fetch('name')
    @height = params.fetch('height')
    @mass = params.fetch('mass')
    @hair_color = params.fetch('hair_color')
    @skin_color = params.fetch('skin_color')
    @eye_color = params.fetch('eye_color')
    @birth_year = params.fetch('birth_year')
    @gender = params.fetch('gender')
    vehicles = params.fetch('vehicles')
    @vehicles = {}
    @starships = {}
    params.fetch('vehicles').each { |vehicle_id| @vehicles[vehicle_id] = '' }
    params.fetch('starships').each { |starship_id| @starships[starship_id] = '' }
  end

  def self.loadCollection
    super('people')
    self.addVehicles
    self.addStarships
  end
end

class Vehicle < JsonReader
  attr_accessor :name, :cost_in_credits, :length, :max_atmosphering_speed, :crew, :passengers, :cargo_capacity, :consumables, :vehicle_class
  attr_reader :id, :model, :manufacturer
  
  def initialize(params = {})
    @id = params.fetch('id')
    @name = params.fetch('name')
    @model = params.fetch('model')
    @manufacturer = params.fetch('manufacturer')
    @cost_in_credits = params.fetch('cost_in_credits')
    @length = params.fetch('length')
    @max_atmosphering_speed = params.fetch('max_atmosphering_speed')
    @crew = params.fetch('crew')
    @passengers = params.fetch('passengers')
    @cargo_capacity = params.fetch('cargo_capacity')
    @consumables = params.fetch('consumables')
    @vehicle_class = params.fetch('vehicle_class')
  end
  def self.loadCollection
    super('vehicles')
  end
end

class Starship < JsonReader
  attr_accessor :name, :cost_in_credits, :length, :max_atmosphering_speed, :crew, :passengers, :cargo_capacity, :consumables, :hyperdrive_rating, :MGLT, :starship_class 
  attr_reader :id, :model, :manufacturer
  
  def initialize(params = {})
    @id = params.fetch('id')
    @name = params.fetch('name')
    @model = params.fetch('model')
    @manufacturer = params.fetch('manufacturer')
    @cost_in_credits = params.fetch('cost_in_credits')
    @length = params.fetch('length')
    @max_atmosphering_speed = params.fetch('max_atmosphering_speed')
    @crew = params.fetch('crew')
    @passengers = params.fetch('passengers')
    @cargo_capacity = params.fetch('cargo_capacity')
    @consumables = params.fetch('consumables')
    @vehicle_class = params.fetch('hyperdrive_rating')
    @MLGT = params.fetch('MGLT')
    @starship_class = params.fetch('starship_class')
  end
  def self.loadCollection
    super('starships')
  end
end

module RelationsManager

  def addVehicles
    Person.collection['person'].each do |person|
      person.vehicles.each do |id, key|
        person.vehicles[id] = Vehicle.find(id)
      end
    end
  end

  def addStarships
    Person.collection['person'].each do |person|
      person.starships.each do |id, key|
        person.starships[id] = Starship.find(id)
      end
    end
  end
end

class Person
extend RelationsManager
end

Vehicle.loadCollection
Starship.loadCollection
Person.loadCollection
p = Person.find(1)
p.starships.each {|id, starship| puts starship.name}

=begin

-------
people = Array.new
vehicles = Array.new
starship = Array.new
data_hash['people'].each { |person| people.append(Person.new(person))}
data_hash['vehicles'].each { |vehicle| vehicles.append(Vehicle.new(vehicle))}
data_hash['starships'].each { |starship| starships.append(Starship.new(starship))}
-------
first = Person.new(data_hash['people'][0]['id'],data_hash['people'][0]['name'],data_hash['people'][0]['height'],data_hash['people'][0]['mass'],data_hash['people'][0]['hair_color'],data_hash['people'][0]['skin_color'],data_hash['people'][0]['eye_color'],data_hash['people'][0]['birth_year'],data_hash['people'][0]['gender'],data_hash['people'][0]['vehicles'],data_hash['people'][0]['starships'])

  def s(id, name, height, mass, hair_color, skin_color, eye_color, birth_year, gender, vehicles, starships)
    @id = id
    @name = name
    @height = height
    @mass = mass
    @hair_color = hair_color
    @skin_color = skin_color
    @eye_color = eye_color
    @birth_year = birth_year
    @gender = gender
    @vehicles = vehicles
    @starships = starships
  end

=end