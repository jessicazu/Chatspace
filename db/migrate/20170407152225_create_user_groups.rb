class CreateUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_groups do |t|
      t.references :group, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
