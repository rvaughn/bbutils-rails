class AddPermissions < ActiveRecord::Migration
  def change
    add_column :group_permissions, :group_id, :integer
    add_column :group_permissions, :repository_id, :integer
    add_foreign_key :group_permissions, :groups
    add_foreign_key :group_permissions, :repositories

    add_column :member_permissions, :member_id, :integer
    add_column :member_permissions, :repository_id, :integer
    add_foreign_key :member_permissions, :members
    add_foreign_key :member_permissions, :repositories
  end
end
