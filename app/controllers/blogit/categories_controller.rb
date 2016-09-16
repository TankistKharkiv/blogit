module Blogit

  class CategoriesController < ::Blogit::ApplicationController

    layout Blogit.configuration.layout if Blogit.configuration.layout

    def show
      @total_posts_count = Category.find(params[:category]).posts.length
      @posts = posts_for_category.for_index page_number
      @tags = posts_for_category.tag_counts_on(:tags)
      yield post if block_given?
    end

  end

end