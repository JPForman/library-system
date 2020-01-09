class Book
  attr_reader :id
  attr_accessor :name, :author_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    # @author_id = attributes.fetch(:author_id)
    @id = attributes.fetch(:id)
  end

  def ==(book_to_compare)
    if book_to_compare != nil
      (self.name() == book_to_compare.name()) && (self.id() == book_to_compare.id())
    else
      false
    end
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      name = book.fetch("title")
      # author_id = book.fetch("author_id").to_i
      id = book.fetch("id").to_i
      books.push(Book.new({:name => name, :id => id}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@name}') RETURNING id;")
    puts @name
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    book = DB.exec("SELECT * FROM books WHERE id = #{id};").first
    if book
      name = book.fetch("title")
      id = book.fetch("id").to_i
      Book.new({:name => name, :id => id})
    else
      nil
    end
  end

  def update(name)
    @name = name
    DB.exec("UPDATE books SET title = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM books *;")
  end

  def self.find_by_author(auth_id)
    books = []
    returned_books = DB.exec("SELECT books.* FROM authors JOIN authors_books ON (authors.id = authors_books.author_id) JOIN books ON (authors_books.book_id = books.id) WHERE authors.id = #{auth_id};")
    returned_books.each() do |book|
      name = book.fetch("title")
      id = book.fetch("id").to_i
      books.push(Book.new({:name => name, :id => id}))
    end
    books
  end

  def author
    Author.find(@author_id)
  end
end
