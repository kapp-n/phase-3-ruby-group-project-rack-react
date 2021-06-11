class Shelf < ActiveRecord::Base
    has_many :books
end