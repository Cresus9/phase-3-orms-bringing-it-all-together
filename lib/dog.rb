class Dog
attr_accessor :id, :name, :breed
def initialize(name:, breed:, id:nil) 
    @id = id
    @name = name,
    @breed = breed
end

def self.create_table
    sql = <<-SQL
        CREATE TABLE IF NOT EXISTS dogs(
            id INTEGER PRIMARY KEY,
            name TEXT,
            breed TEXT
        )
        SQL
    DB[:conn].execute(sql)
    Dog.create_table
    table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='dogs';"
    expect(DB[:conn].execute(table_check_sql)[0]).to eq(['dogs'])
end

def self.drop_table 
    sql = <<-SQL
        DROP TABLE dogs FROM Database
        SQL
        Dog.drop_table
        table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='dogs';"
    expect(DB[:conn].execute(table_check_sql)[0]).to eq(nil)
  end

def save
    sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.breed)
end

def self.create(name:, breed:)
    dog = Dog.new(name:name, breed:breed)
    dog.save
end
def self.new_form_db
end
def all
    sql= <<-SQL 
        SELECT * 
        FROM dogs
        SQL
    DB[:conn].execute(sql).map do |row|
        self.new_form_db(row)
    end
end
def self.find_by_name(name)
    sql = <<-SQL
        SELECT *
         FROM dogs WHERE name = ?
         LIMIT 1
        SQL
    DB[:conn].execute(sql, name).map do |row|
        self.new_form_db(row)
    end.first
end





    









end
