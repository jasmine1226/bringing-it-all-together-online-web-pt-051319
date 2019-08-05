class Dog
  attr_accessor :id, :name, :breed

  def initialize(name:, breed:, id:nil)
    self.name = name
    self.breed = breed
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE dogs")
  end

  def save
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (? , ?)
    SQL
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid()")[0][0]
    self
  end

  def self.create(input)
    dog = self.new(name: input[:name], breed: input[:breed])
    dog.save
  end

  def self.new_from_db(row)
    dog = self.new(name: row[1], breed: row[2])
    dog.id = row[0]
    dog
  end

  def self.find_by_id(id)
    sql = <<-SQL
      SELECT * FROM dogs
      WHERE id = ?
      LIMIT 1
    SQL
    DB[:conn].execute(sql, id).map do |row|
      self.new_from_db(row)
    end.first
  end

  def self.find_or_create_by(name:, breed:)
    sql = <<-SQL
      SELECR * FROM dogs
      WHERE name = ? AND breed = ?
    SQL
    dog = DB[:conn].execute(sql, name, breed)
    if !dog.empty?
      dog_data = dog[0]
      dog = Dog.new(name: dog_data[1], breed: dog_data[2])
    else
      dog = Dog.create(name: dog_data[1], breed: dog_data[2])
    end
    dog
  end
end
