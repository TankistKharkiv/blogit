module Blogit
  class Category < ActiveRecord::Base
    has_many :posts, :class_name => 'Blogit::Post', foreign_key: 'blogit_categories_id'
  end
end
