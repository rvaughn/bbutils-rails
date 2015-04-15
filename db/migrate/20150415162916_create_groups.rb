class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :slug
      t.string :permission

      t.timestamps null: false
    end
  end
end
