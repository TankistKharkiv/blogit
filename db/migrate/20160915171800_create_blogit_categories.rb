class CreateBlogitCategories < ActiveRecord::Migration
  def change
    create_table :blogit_categories do |t|
      t.string :name
    end
    add_reference :blogit_posts, :blogit_categories
    add_index :blogit_posts, :blogit_categories_id
  end
end
