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

get ('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  redirect to('/albums')
end

delete ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  redirect to('/albums')
end

get ('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

post ('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new({:name => params[:song_name], :album_id => @album.id, :id => nil})
  song.save()
  erb(:album)
end

patch ('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

delete ('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/artists') do
  @artists = Artist.all
  erb(:artists)
end

get ('/artists/new') do
  erb(:new_artist)
end

get ('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  erb(:artist)
end

post ('/artists') do
  artist = Artist.new({:name => params[:artist_name], :id => nil})
  artist.save()
  redirect to('/artists')
end


patch ('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.update_name(params[:name])
  redirect to('/artists')
end

delete ('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.delete()
  redirect to('/artists')
end


get ('/artists/:id/edit') do
  @artist = Artist.find(params[:id].to_i())
  erb(:edit_artist)
end

post ('/artists/:id/albums') do
  @artist = Artist.find(params[:id].to_i())
  @artist.update({:album_name => params[:album_name]})
  erb(:artist)
end
