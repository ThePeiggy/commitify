class User < ActiveRecord::Base
  validates_uniqueness_of :email
  has_many :sponsorships
  has_many :commitments, through: :sponsorships do
    def owned
      where("sponsorships.sponsorship_type = ?", Sponsorship::OWNERSHIP)
    end

    def sponsored
      where("sponsorships.sponsorship_type = ?", Sponsorship::SPONSORSHIP)
    end
  end

  def self.koala(auth)
    access_token = auth['token']
    facebook = Koala::Facebook::API.new(access_token)
  end

end
