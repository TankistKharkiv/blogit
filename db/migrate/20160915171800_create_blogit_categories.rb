class CreateBlogitCategories < ActiveRecord::Migration
  def change
    create_table :blogit_categories do |t|
      t.string :name
    end
    add_reference :blogit_posts, :category
    add_index :blogit_posts, :category_id
  end
end
