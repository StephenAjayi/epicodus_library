class Author

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    found_authors = []
    returned_authors = DB.exec("SELECT * FROM authors")
    returned_authors.each() do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i()
      found_authors.push(Author.new(name: name, id: id))
    end
    found_authors
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_author|
    self.name().eql?(another_author.name()) && self.id().eql?(another_author.id())
  end



end
