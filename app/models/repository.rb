class Repository < ActiveRecord::Base

  def url
    "https://bitbucket.org/#{owner}/#{slug}"
  end
  
end
