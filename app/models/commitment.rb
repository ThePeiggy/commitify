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

  def sponsor_count
    sponsorships.where(sponsorship_type: Sponsorship::SPONSORSHIP).count
  end

  def cost_sponsored
    sponsorships.where(sponsorship_type: Sponsorship::SPONSORSHIP).sum :cost
  end
end
