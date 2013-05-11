class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order('created_at DESC')
    @following = current_user.following
  end
end
