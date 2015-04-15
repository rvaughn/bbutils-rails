class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :slug
      t.string :desc
      t.string :owner

      t.timestamps null: false
    end
  end
end
