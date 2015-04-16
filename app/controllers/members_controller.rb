class MembersController < ApplicationController

  def index
    @members = Member.order(:name)
  end

  def show
    @member = Member.find_by(username: params[:id])
  end
  
end
