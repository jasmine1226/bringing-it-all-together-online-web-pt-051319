class Dog
  attr_accessor :id, :name, :breed

  def initialize(name:, breed:, id:nil)
    self.name = name
    self.breed = breed
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

  def self.new_from_db
    sql = <<-SQL
      SELECT * FROM dogs
    SQL

    DB[:conn].execute(sql).map do |row|
    end
  end
end
