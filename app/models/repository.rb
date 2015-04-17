class Repository < ActiveRecord::Base

  has_many :member_permissions
  has_many :members, :through => :member_permissions
  has_many :group_permissions
  has_many :groups, :through => :group_permissions
  
  def url
    "https://bitbucket.org/#{owner}/#{slug}"
  end
  
end
