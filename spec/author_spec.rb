require 'spec_helper'



describe(Author) do
  describe("#name") do
    it('returns the name of the author') do
      author = Author.new(name: "ernest hemingway", id: nil)
      expect(author.name).to(eq("ernest hemingway"))
    end
  end

  describe('#id') do
    it('returns the id of the author') do
      author = Author.new(name: "ernest hemingway", id: 1)
      expect(author.id).to(eq(1))
    end
  end

  describe('.all') do
    it('has no authors at first') do
      expect(Author.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves an author to the database') do
      author = Author.new(name: "ernest hemingway", id: nil)
      author.save
      expect(Author.all).to(eq([author]))
    end
  end

  describe('#==') do
    it('ascribes equal to two objects are equal to each others') do
      test_author = Author.new({:name => "Ernest Hemingway", :id => nil})
      test_author2 = Author.new({:name => "Ernest Hemingway", :id => nil})
      expect(test_author).to(eq(test_author2))
     end
   end

   describe('.find') do
     it('finds the book by its id ') do
       test_author = Author.new({:name => "Ernest Hemingway", :id => nil})
       test_author2 = Author.new({:name => "Earnest Hemingway", :id => nil})
       test_author.save()
       test_author2.save()
       expect(Author.find(test_author2.id())).to(eq(test_author2))
     end
   end

   describe('#update') do
     it('lets you update actors in the database') do
       test_author = Author.new({:name => "Ernest Hemingway", :id => nil})
       test_author.save()
       test_author.update({:name => "Brad Pitt"})
       expect(test_author.name()).to(eq("Brad Pitt"))
     end
   end

   describe('#books') do
     it('returns all books associated with author') do
       test_author = Author.new({:name => "Ernest Hemingway", :id => nil})
       test_author.save
       test_book = Book.new(title: "Moby Dick", id: nil)
       test_book.save
       test_book1 = Book.new(title: "Moby Dick", id: nil)
       test_book1.save
       test_author.update(book_ids: [test_book.id(), test_book1.id()])
       expect(test_author.books).to(eq([test_book, test_book1]))
     end
   end

   describe('#delete') do
     it('deletes the author from the database') do
       test_author = Author.new({:name => "Ernest Hemingway", :id => nil})
       test_author1 = Author.new({:name => "Ernest Hemingway", :id => nil})
       test_author1.save()
       test_author.save()
       test_author.delete()
       expect(Author.all).to(eq([test_author1]))
     end
   end
end
