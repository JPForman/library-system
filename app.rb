require('sinatra')
require('sinatra/reloader')
require('./lib/author')
require('./lib/book')
require('pry')
also_reload('lib/**/*.rb')
require("pg")
# require('./lib/artist')

DB = PG.connect({:dbname => "library_system"})

get('/') do
  redirect to('/books')
end

get('/books') do
  @books = Book.all
  erb(:books)
end

get ('/books/new') do
  erb(:new_book)
end

post ('/books') do
  title = params[:book_title]
  book = Book.new({:name => title, :id => nil})
  book.save()
  redirect to('/books')
end

get ('/books/:id') do
  @book = Book.find(params[:id].to_i())
  erb(:book)
end

get ('/books/:id/edit') do
  @book= Book.find(params[:id].to_i())
  erb(:edit_book)
end

patch ('/books/:id') do
  @book = Book.find(params[:id].to_i())
  @book.update(params[:name])
  redirect to('/books')
end

delete ('/books/:id') do
  @book = Book.find(params[:id].to_i())
  @book.delete()
  redirect to('/books')
end

get ('/books/:id/authors/:author_id') do
  @author = Author.find(params[:author_id].to_i())
  erb(:author)
end

post ('/books/:id/authors') do
  @book = Book.find(params[:id].to_i())
  author = Author.new({:name => params[:author_name], :id => nil})
  author.save()
  author.update({:name => params[:author_name], :id => nil, :title => @book.name})
  erb(:book)
end

patch ('/books/:id/authors/:author_id') do
  @book = Book.find(params[:id].to_i())
  author = Author.find(params[:author_id].to_i())
  author.update({:name => params[:author_name], :id => nil, :title => @book.name})
  erb(:book)
end

delete ('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @book = Album.find(params[:id].to_i())
  erb(:album)
end

get('/authors') do
  @artists = Artist.all
  erb(:artists)
end
#
# get ('/artists/new') do
#   erb(:new_artist)
# end
#
# get ('/artists/:id') do
#   @artist = Artist.find(params[:id].to_i())
#   erb(:artist)
# end
#
# post ('/artists') do
#   artist = Artist.new({:name => params[:artist_name], :id => nil})
#   artist.save()
#   redirect to('/artists')
# end
#
#
# patch ('/artists/:id') do
#   @artist = Artist.find(params[:id].to_i())
#   @artist.update_name(params[:name])
#   redirect to('/artists')
# end
#
# delete ('/artists/:id') do
#   @artist = Artist.find(params[:id].to_i())
#   @artist.delete()
#   redirect to('/artists')
# end
#
#
# get ('/artists/:id/edit') do
#   @artist = Artist.find(params[:id].to_i())
#   erb(:edit_artist)
# end
#
# post ('/artists/:id/albums') do
#   @artist = Artist.find(params[:id].to_i())
#   @artist.update({:album_name => params[:album_name]})
#   erb(:artist)
# end
