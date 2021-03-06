# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(first_name: 'Pei', last_name: 'Li', email: 'peihongli94@gmail.com', account_id: "529653a1ce21cd9e53000076")
commitment = Commitment.create(title: "Shave Pei's Head", description: "We're gonna shave Pei.", expiry_date: DateTime.now + 3.days, status: Commitment::READY, cost: 0.004, account_id: "54f289b581878d6e9e00005a", beneficiary: 'charity', beneficiary_id: "529653a1ce21cd9e53000076")
sponsorship = user.sponsorships.create(sponsorship_type: 'ownership', commitment_id: commitment.id)
