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
    DB[:conn].execute("DROP TABLE dogs")
  end

  def self.new_from_db(rows)
    sql = <<-SQL
    SQL

    DB[:conn].execute(sql).map do |row|
    end
  end
end
