class Dog
  attr_accessor :id, :name, :breed

  def self.create_table
    sql = <<-SQL
      DROP TABLE IF EXISTS dogs
      CREATE TABLE (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE dogs
    SQL
    DB[:conn].execute(sql)
  end

end
