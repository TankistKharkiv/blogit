module Blogit

  # Inherits from the application's controller instead of ActionController::Base
  class ApplicationController < ::ApplicationController

    helper Blogit::ApplicationHelper
    helper Blogit::LayoutHelper
    helper Blogit::PostsHelper
    helper Blogit::CommentsHelper
    helper ActsAsTaggableOn::TagsHelper
    
    helper_method :blogit_conf

    # A helper method to access the {Blogit::configuration} at the class level.
    #
    # Returns a Blogit::Configuration
    def self.blogit_conf
      Blogit::configuration
    end

    # A helper method to access the {Blogit::configuration} at the controller instance
    #   level.
    #
    # Returns a Blogit::Configuration
    def blogit_conf
      self.class.blogit_conf
    end

    protected
    def page_number
      @page_number ||= params[Kaminari.config.param_name]
    end

  end
  
end