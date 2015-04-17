class Group < ActiveRecord::Base

  has_and_belongs_to_many :members

  has_many :group_permissions
  has_many :repositories, :through => :group_permissions
  
end
