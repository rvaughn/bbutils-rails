class MembersController < ApplicationController

  def index
    @members = Member.order(:name)
  end

end
