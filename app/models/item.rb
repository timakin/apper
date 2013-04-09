class Item < ActiveRecord::Base
  attr_accessible :text, :title, :image, :user_id
  belongs_to :user
  mount_uploader :image, ImageUploader
end
