class Book

  attr_reader(:title, :id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    books = []
    returned_books = DB.exec("SELECT * FROM books ;")
    returned_books.each() do |book|
      id = book.fetch('id').to_i()
      title = book.fetch('title')
      books.push(Book.new(:title => title, :id => id))
    end
    books
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_book|
    self.title().eql?(another_book.title()) && self.id().eql?(another_book.id())
  end

  define_singleton_method(:find) do |id|
    found_books = DB.exec("SELECT * FROM books WHERE id = #{id};")
    title = found_books.first.fetch('title')
    Book.new(title: title, id: id)
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{self.id};")

    attributes.fetch(:author_ids, []).each() do |author_id|
      DB.exec("INSERT INTO authors_books (book_id, author_id) VALUES (#{self.id}, #{author_id}); ")
    end
  end

  define_method(:authors) do
    authors = []
    results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{self.id}")
    results.each do |result|
      author_id = result.fetch('author_id').to_i
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      name = author.first().fetch('name')
      authors.push(Author.new({:name=> name, :id => author_id}))
      end
    authors
  end
  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{self.id}")
    DB.exec("DELETE FROM authors_books WHERE book_id = #{self.id}")

  end

end
