class Sponsorship < ActiveRecord::Base
  OWNERSHIP = 'ownership'.freeze
  SPONSORSHIP = 'sponsorship'.freeze
  belongs_to :user
  belongs_to :commitment

  validates_uniqueness_of :user_id, scope: [:commitment_id, :sponsorship_type]
end
