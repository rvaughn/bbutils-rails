class GroupsController < ApplicationController

  def index
    @groups = Group.order(:slug)
  end

end
