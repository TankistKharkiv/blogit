class AddAttachmentThumbnailToBlogitPosts < ActiveRecord::Migration
  def self.up
    change_table :blogit_posts do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :blogit_posts, :thumbnail
  end
end
