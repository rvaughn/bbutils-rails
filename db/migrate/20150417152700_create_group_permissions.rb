class CreateGroupPermissions < ActiveRecord::Migration
  def change
    create_table :group_permissions do |t|
      t.string :permission

      t.timestamps null: false
    end
  end
end
