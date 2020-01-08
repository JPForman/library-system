require 'spec_helper'

describe '#Author' do
  describe('.all') do
    it("returns all authors") do
      expect(Author.all).to(eq([]))
    end
  end
end
