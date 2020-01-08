require('spec_helper')

describe '#Book' do

  before(:each) do
    @author = Author.new({:name => "J.D. Salinger", :id => nil})
    @author.save()
  end

  describe('#==') do
    it("is the same book if it has the same attributes as another book") do
      book = Book.new({:name => "Franny and Zooey", :id => nil})
      book2 = Book.new({:name => "Franny and Zooey", :id => nil})
      expect(book).to(eq(book2))
    end
  end

  describe('.all') do
    it("returns a list of all books") do
      book = Book.new({:name => "Giant Steps", :id => nil})
      book.save()
      book2 = Book.new({:name => "Naima", :id => nil})
      book2.save()
      expect(
        Book.all).to(eq([book, book2]))
      end
    end
  end

    describe('.clear') do
      it("clears all books") do
        book =
        Book.new({:name => "Giant Steps", :id => nil})
        book.save()
        book2 =
        Book.new({:name => "Naima", :id => nil})
        book2.save()

        Book.clear()
        expect(
          Book.all).to(eq([]))
      end
    end

    describe('#save') do
      it("saves a book") do
        book =
        Book.new({:name => "Naima", :id => nil})
        book.save()
        expect(
          Book.all).to(eq([book]))
      end
    end

    describe('.find') do
      it("finds a book by id") do
        book =
        Book.new({:name => "Giant Steps", :id => nil})
        book.save()
        book2 =
        Book.new({:name => "Naima", :id => nil})
        book2.save()
        expect(
          Book.find(book.id)).to(eq(book))
      end
    end

    describe('#update') do
      it("updates an book by id") do
        @author = Author.new({:name => 'kilaj', :id => nil})
        book =
        Book.new({:name => "Naima", :id => nil})
        book.save()
        book.update("Mr. P.C.")
        expect(book.name).to(eq("Mr. P.C."))
      end
    end

    describe('#delete') do
      it("deletes an book by id") do
        book =
        Book.new({:name => "Giant Steps", :id => nil})
        book.save()
        book2 =
        Book.new({:name => "Naima", :id => nil})
        book2.save()
        book.delete()
        expect(
          Book.all).to(eq([book2]))
      end
    end

    describe('#delete') do
    it("deletes all books belonging to a deleted author") do
      author = Author.new({:name => "A Love Supreme", :id => nil})
      author.save()
      book =
      Book.new({:name => "Naima", :id => nil})
      book.save()
      author.delete()
      expect(
        Book.find(book.id)).to(eq(nil))
    end
  end

  #   describe('.find_by_author') do
  #     it("finds books for an author") do
  #       author2 = Album.new({:name => "Blue", :id => nil})
  #       author2.save
  #       book =
  #       Book.new({:name => "Naima", :id => nil})
  #       book.save()
  #       book2 =
  #       Book.new({:name => "California", :author_id => author2.id , :id => nil})
  #       book2.save()
  #       expect(
  #         Book.find_by_author(author2.id)).to(eq([book2]))
  #     end
  #   end
  #
  #   describe('#author') do
  #     it("finds the author a book belongs to") do
  #       book =
  #       Book.new({:name => "Naima", :id => nil})
  #       book.save()
  #       expect(book.author()).to(eq(@author))
  #     end
  #   end
  # end
