class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.order(:slug)
  end

end
