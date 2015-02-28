class Commitment < ActiveRecord::Base
  has_many :sponsorships
  has_many :users, through: :sponsorships do
    def owner
      where("sponsorships.sponsorship_type = ?", Sponsorship::OWNERSHIP).first
    end

    def sponsors
      where("sponsorships.sponsorship_type = ?", Sponsorship::SPONSORSHIP)
    end
  end
end
