module Blogit

  # Handles requests for viewing Blogit::Posts
  class PostsController < ::Blogit::ApplicationController

    # The current Blogit::Post being displayed.
    #
    # Returns a Blogit::Post with id from params

    before_action :redirect_to_witout_slash, only: :index
    attr_reader :post

    # The current Posts being displayed
    #
    # Returns ActiveRecord::Relation for Post table
    attr_reader :posts
    
    # If a layout is specified, use that. Otherwise, fall back to the default
    layout Blogit.configuration.layout if Blogit.configuration.layout
    # Handles GET requests to /blogit/posts.html, /blogit/posts.xml, and /blogit/posts.rss
    # Possible formats include:
    #
    # "XML" -  calls {#set_posts_for_feed}.
    # "RSS" -  calls {#set_posts_for_feed}.
    # "HTML" - calls {#set_posts_for_index_page}.
    #
    # Yields #posts if called with a block (useful for calling super from subclasses)
    #
    # Returns nil
    def index
      respond_to do |format|
        format.xml  { set_posts_for_feed }
        format.rss  { set_posts_for_feed }
        format.html { set_posts_for_index_page }
      end
      yield(posts) if block_given?      
    end

    # Handles GET requests to /blogit/posts/:id.html
    #
    # Yields #post if called with a block (useful for calling super from subclasses)
    def show
      set_post
      yield post if block_given?
    end

    # Handles GET requests to /blogit/posts/tagged/:tag.html. Renders the index template
    # with Posts tagged with tag in *tag* parameter
    #
    # Yields #posts if called with a block (useful for calling super from subclasses)
    def tagged
      set_posts_for_tagged_page
      yield(posts) if block_given?      
      render :index
    end


    private
    
    
    # Set {#post} based on the :id param
    def set_post
      @post = Post.active_with_id(params[:id])
    end
    
    # The page parameter value for the current locale

    
    # Sets {#posts} for the XML feed
    def set_posts_for_feed
      @posts ||= Post.for_feed
    end

    # Sets {#posts} for the HTML index page
    # 
    # tag - The tag name to filter Posts by (default: nil)
    #
    def set_posts_for_index_page(tag = nil)
      @categories ||= Category.all
      @total_posts_count ||= Post.tagged_with(params[:tag]).length
      @tags  ||= Post.tag_counts_on(:tags)
      @posts ||= Post.for_index(page_number)
    end
    
    # Sets {#posts} for the HTML index page when a tag parameter is present
    # 
    def set_posts_for_tagged_page
      @posts = set_posts_for_index_page.tagged_with(params[:tag])
    end

    def redirect_to_witout_slash
      redirect_to main_app.blogit_url, status: 301 if request.original_fullpath.ends_with? '/'
    end
  end

end