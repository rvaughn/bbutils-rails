class StatsController < ApplicationController
  
  def index
    @repo_count = Repository.count
    @member_count = Member.count
    @group_count = Group.count
  end
  
end
