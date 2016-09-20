module Blogit
  class Category < ActiveRecord::Base
    has_many :posts, :class_name => 'Blogit::Post'
    def to_param
      "#{name.parameterize}"
    end
  end
end
