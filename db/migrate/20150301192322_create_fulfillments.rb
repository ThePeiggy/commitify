class CreateFulfillments < ActiveRecord::Migration
  def change
    create_table :fulfillments do |t|
      t.references :commitment, index: true
      t.text :description
      t.string :title
      t.boolean :approved

      t.timestamps
    end
  end
end
