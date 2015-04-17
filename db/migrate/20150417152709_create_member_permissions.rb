class CreateMemberPermissions < ActiveRecord::Migration
  def change
    create_table :member_permissions do |t|
      t.string :permission

      t.timestamps null: false
    end
  end
end
