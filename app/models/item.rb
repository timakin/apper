class Item < ActiveRecord::Base
  attr_accessible :text, :title, :image, :user_id, :tag_list
  acts_as_taggable
  belongs_to :user
  mount_uploader :image, ImageUploader
end
