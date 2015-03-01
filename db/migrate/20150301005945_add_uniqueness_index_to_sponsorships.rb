class AddUniquenessIndexToSponsorships < ActiveRecord::Migration
  def change
    add_index :sponsorships, [:user_id, :commitment_id, :sponsorship_type], :unique => true, name: 'unique_sponsorships'
  end
end
