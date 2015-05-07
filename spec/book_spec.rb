require('rspec')
require('book')

describe(Book) do
  describe('#title') do
    it('returns the title of a book') do
      test_book = Book.new({:title => "Beowulf", :id => nil})
      expect(test_book.title()).to(eq("Beowulf"))
    end
  end
end
