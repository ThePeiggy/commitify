class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.string :title
      t.text :description
      t.datetime :expiry_date
      t.string :status
      t.float :cost
      t.string :account_id, unique: true

      t.timestamps
    end
  end
end
