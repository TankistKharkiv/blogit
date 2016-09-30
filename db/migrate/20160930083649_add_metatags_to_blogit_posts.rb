class AddMetatagsToBlogitPosts < ActiveRecord::Migration
  def change
    add_column :blogit_posts, :meta_description, :string
    add_column :blogit_posts, :meta_keywords, :string
  end
end

