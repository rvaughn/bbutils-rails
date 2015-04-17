class Member < ActiveRecord::Base

  has_and_belongs_to_many :groups

  has_many :member_permissions
  has_many :repositories, :through => :member_permissions
  
end
