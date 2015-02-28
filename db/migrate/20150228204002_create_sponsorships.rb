class CreateSponsorships < ActiveRecord::Migration
  def change
    create_table :sponsorships do |t|
      t.float :cost
      t.references :user, index: true
      t.references :commitment, index: true
      t.string :sponsorship_type, null: false, default: ""

      t.timestamps
    end
  end
end
