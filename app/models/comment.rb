class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  attr_accessible :comment, :commentable_id, :commentable_type, :user_id
  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }, recipient: Proc.new{ |controller, model| model.user }, params: { reason: 'TEST' }
end
