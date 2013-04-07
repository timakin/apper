class Item < ActiveRecord::Base
  attr_accessible :text, :title, :image
  belongs_to :user
  mount_uploader :image, ImageUploader
end
