module Blogit
  class Category < ActiveRecord::Base
    has_many :posts, :class_name => 'Blogit::Post'
  end
end
