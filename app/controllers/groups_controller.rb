class GroupsController < ApplicationController

  def index
    @groups = Group.order(:slug)
  end

  def show
    @group = Group.find_by(slug: params[:id])
  end
  
end
