require 'rspec'
require 'pg'
require 'author'
require 'book'
require 'patron'
require 'pry'

DB = PG.connect({:dbname => 'library_system_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")
  end

end
