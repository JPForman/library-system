class Author
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch("name")
      id = author.fetch("id").to_i
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(author_to_compare)
    self.name() == author_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM authors *;")
  end

  def self.find(id)
    author = DB.exec("SELECT * FROM authors WHERE id = #{id};").first
    name = author.fetch("name")
    id = author.fetch("id")
    Author.new({:name => name, :id => id})
  end

  def update(name)
    @name = name
    DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM authors WHERE id = #{@id};")

    #   results = DB.exec("SELECT books.* FROM authors JOIN authors_books ON (authors.id = authors_books.author_id)
    #   JOIN books ON (authors_books.book_id = books.id)
    #   WHERE authors.id = #{@id};")
    #   results.each do |book|
    #     id = book.fetch(:id)
    #     book.find(id).delete
    #   end
    #   books
    # end

    # binding.pry



    # DB.exec("DELETE FROM books WHERE author_id = #{@id};") #?
  end

  def books
    Book.find_by_author(self.id)
  end

end
