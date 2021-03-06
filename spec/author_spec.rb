require 'spec_helper'

describe '#Author' do

  before(:each) do
    Author.clear
  end

  describe('.all') do
    it("returns all authors") do
      expect(Author.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an author") do
      author = Author.new({:name => "J.D. Salinger", :id => nil})
      author.save()
      author2 = Author.new({:name => "William Faulkner", :id => nil})
      author2.save()
      expect(Author.all).to(eq([author, author2]))
    end
  end

  describe('.clear') do
    it("clears all authors") do
      author = Author.new({:name => "J.D. Salinger", :id => nil})
      author.save()
      author2 = Author.new({:name => "William Faulkner", :id => nil})
      author2.save()
      Author.clear
      expect(Author.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same author if it has the same attributes as another author") do
      author = Author.new({:name => "J.D. Salinger", :id => nil})
      author.save()
      author2 = Author.new({:name => "J.D. Salinger", :id => nil})
      author2.save()
      expect(author).to(eq(author2))
    end
  end

  describe('.find') do
    it("finds an author by id") do
      author = Author.new({:name => "J.D.Salinger", :id => nil})
      author.save()
      author2 = Author.new({:name => "Faulkner", :id => nil})
      author2.save()
      expect(Author.find(author.id)).to(eq(author))
    end
  end

  describe('#update') do
    it("updates an author by id") do
      author = Author.new({:name => "J.D.Salinger", :id => nil})
      author.save()
      author.update({:name => "P.T Anderson"})
      expect(author.name).to(eq("P.T Anderson"))
    end
  end

  describe('#delete') do
    it("deletes an author by id") do
      author = Author.new({:name => "J.D.Salinger", :id => nil})
      author.save()
      author2 = Author.new({:name => "Faulkner", :id => nil})
      author2.save()
      author.delete()
      expect(Author.all).to(eq([author2]))
    end
  end

  describe('#delete') do
    it("deletes all books belonging to a deleted author") do
      author = Author.new({:name => "A Love Supreme", :id => nil})
      author.save()
      book = Book.new({:name => "Naima", :id => nil})
      book.save()
      author.delete()
      expect(
        Book.find(book.id)).to(eq(book))
      end
    end

    describe('#find_books_by_author') do
      it("returns an author's books") do
        author = Author.new({:name => "J.D.Salinger", :id => nil})
        author.save()

        author2 = Author.new({:name => "Faulkner", :id => nil})
        author2.save()

        book = Book.new({:name => "Naima", :id => nil})
        book.save()

        book2 = Book.new({:name => "As I Lay Dying", :id => nil})
        book2.save()

        author.update({:title => "Naima"})
        author2.update({:title => "As I Lay Dying"})
        expect(Book.find_books_by_author(author.id)).to(eq([book]))
        expect(Book.find_books_by_author(author2.id)).to(eq([book2]))
      end
    end
  end
