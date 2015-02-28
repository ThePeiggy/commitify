class User < ActiveRecord::Base
  validates_uniqueness_of :email
  has_many :commitments

  def self.koala(auth)
    access_token = auth['token']
    facebook = Koala::Facebook::API.new(access_token)
  end

end
