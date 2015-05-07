require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/author'
require './lib/book'
require 'pg'

DB = PG.connect(dbname: 'library')

get('/') do
  @authors = Author.all
  @books = Book.all
  erb(:index)
end

get('/authors') do
  @authors = Author.all()
  erb(:authors)

end

post('/authors') do
  name = params.fetch('author')
  author = Author.new(name: name, id: nil)
  author.save
  @authors = Author.all
  erb(:authors)
end
get('/books') do

end
