module Blogit
  class Category < ActiveRecord::Base
    has_many :posts, :class_name => 'Blogit::Post', foreign_key: 'blogit_category_id'
  end
end
