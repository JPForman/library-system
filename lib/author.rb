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

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")
    end
    if (attributes.has_key?(:title)) && (attributes.fetch(:title) != nil)
      title = attributes.fetch(:title)
      book = DB.exec("SELECT * FROM books WHERE lower(title) ='#{title.downcase}';").first
      if book != nil
        DB.exec("INSERT INTO authors_books (book_id, author_id) VALUES (#{book['id'].to_i}, #{@id});")
      else
        new_book = Book.new({:name => title, :id => nil})
        new_book.save
        DB.exec("INSERT INTO authors_books (book_id, author_id) VALUES (#{new_book.id}, #{@id});")
      end
    end
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
