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
end
