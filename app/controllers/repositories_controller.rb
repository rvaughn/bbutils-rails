class RepositoriesController < ApplicationController

  def index
    sort = case params['sort']
           when "name" then "slug"
           when "name_reverse" then "slug desc"
           when "date" then "updated_at"
           when "date_reverse" then "updated_at desc"
           else "slug"
           end
    
    @repositories = Repository.order(sort)
  end

  def show
    @repo = Repository.find_by(slug: params[:id])
  end

end
