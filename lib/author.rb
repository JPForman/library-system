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
    if author
      id = author.fetch("id")
      name = author.fetch("name")
      Author.new({:id => id, :name => name})
    else
      nil
    end
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")
    end
    if (attributes.has_key?(:title)) && (attributes.fetch(:title) != nil)
      title = attributes.fetch(:title)
      book = DB.exec("SELECT * FROM books WHERE lower(title) ='#{title.downcase}';").first
      puts DB.exec("SELECT * FROM books;").first
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
  end

  def self.find_authors_by_book(book_id)
    authors = []
    results = DB.exec("SELECT * FROM authors_books WHERE book_id = #{book_id};")
    binding.pry
    # results return as {"id"=>"706", "author_id"=>"4415", "book_id"=>"2907"}
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      author_id = result.fetch("author_id").to_i()
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      name = author.first().fetch("name")
      authors.push(Author.new({:name => name, :id => author_id}))
    end
    authors
  end

end
