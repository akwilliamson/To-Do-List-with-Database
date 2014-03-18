class List
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def id
    @id
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    @@lists = []
    results = DB.exec("SELECT * FROM lists;")
    results.each do |result|
      name = result['name']
      @@lists << List.new(name)
    end
    @@lists
  end

  # def self.find_list(index)
  #   current_list = DB.exec("SELECT * from lists WHERE id = #{index};")
  #   current_list
  # end


  # def List.show_current_list(list_index)
  #   current_list = DB.exec("SELECT (name) FROM lists WHERE id = #{task.list_id};")
  #   puts "\nHere is Your List and the T-Do's, get goin"
  #   puts current_list.first['name']
  #   puts "--------"
  # end

  def == (another_list)
    self.name == another_list.name
  end
end
