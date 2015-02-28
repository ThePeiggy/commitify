class Sponsorship < ActiveRecord::Base
  OWNERSHIP = 'ownership'.freeze
  SPONSORSHIP = 'sponsorship'.freeze
  belongs_to :user
  belongs_to :commitment
end
