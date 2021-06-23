
class Book < ActiveRecord::Base
    belongs_to :shelf

    def self.long_books
        self.all.select{ |b| b.pages > 400 }
    end

    def book_name
        title = self.name
        author = self.author
        shelf = self.shelf.genre
        "#{title} #{author} #{shelf}"
    end

end