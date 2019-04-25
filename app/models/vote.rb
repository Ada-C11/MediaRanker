class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
end

# def first_published
#   my_books = self.books.where.not(publication_date: nil).order(:publication_date)

#   return my_books.first.publication_date if !my_books.empty?

#   return nil # If the author's never been published
# end
