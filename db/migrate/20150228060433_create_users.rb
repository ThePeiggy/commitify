class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :first_name, default: ""
      t.string :last_name, default: ""
      t.string :account_id, unique: true

      t.timestamps
    end
  end
end
