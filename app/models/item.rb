class Item < ActiveRecord::Base
  attr_accessible :text, :title, :image, :user_id, :tag_list
  acts_as_taggable
  acts_as_commentable
  belongs_to :user
  mount_uploader :image, ImageUploader
end
