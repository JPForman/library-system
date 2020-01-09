require('spec_helper')

describe '#Book' do

  before(:each) do
    @author = Author.new({:name => "J.D. Salinger", :id => nil})
    @author.save()
    Book.clear
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
              book = Book.new({:name => "Giant Steps", :id => nil})
              book.save()
              book2 = Book.new({:name => "Naima", :id => nil})
              book2.save()
              book.delete()
              expect(Book.all).to(eq([book2]))
            end
          end

          describe('.find_authors_by_book') do
            it("finds authors of a book") do
              author1 = Author.new({:name => "Red", :id => nil})
              author1.save
              author2 = Author.new({:name => "Blue", :id => nil})
              author2.save
              book = Book.new({:name => "California", :id => nil})
              book.save()
              author1.update({:name => "Red", :id => nil, :title => "California"})
              author2.update({:name => "Blue", :id => nil, :title => "California"})
              expect(Author.find_authors_by_book(book.id)).to(eq([author1, author2]))
            end
          end
        end
