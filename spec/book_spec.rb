require 'spec_helper'

describe(Book) do
  describe('#title') do
    it('returns the title of a book') do
      test_book = Book.new({:title => "Beowulf", :id => nil})
      expect(test_book.title()).to(eq("Beowulf"))
    end
  end

  describe('#id') do
    it('returns the id of a book') do
      test_book = Book.new({:title => "Beowulf", :id => 1})
      expect(test_book.id()).to(eq(1))
    end
  end

  describe('#save') do
    it('saves book to the database') do
      test_book = Book.new({ :title => 'Beowulf', :id => nil})
      test_book.save
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('.all') do
    it('shows all books saved to the database, it is blank a first') do
      expect(Book.all).to(eq([]))
    end
  end

  describe('#==') do
    it('ascribes equal to two objects are equal to each others') do
      test_book = Book.new({:title => "Beowulf", :id => nil})
      test_book2 = Book.new({:title => "Beowulf", :id => nil})
      expect(test_book).to(eq(test_book2))
     end
   end

  describe('.find') do
    it('finds the book by its id ') do
      test_book = Book.new({:title => "Beowulf", :id => nil})
      test_book1 = Book.new({:title => "beowulf", :id => nil})
      test_book.save()
      test_book1.save()
      expect(Book.find(test_book1.id())).to(eq(test_book1))
    end
  end


   describe('#update') do
     it('lets you update books in the database') do
       test_book = Book.new({:title => "Beowulf", :id => nil})
       test_book.save
       test_book.update({:title => "Moby Dick"})
       expect(test_book.title()).to(eq("Moby Dick"))
     end
   end

end
