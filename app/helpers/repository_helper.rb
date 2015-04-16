module RepositoryHelper

  def sort_link_to(text, path, param)
    key = params[:sort] == param ? param + "_reverse" : param
    link_to text, repositories_path(sort: key)
  end
  
end
