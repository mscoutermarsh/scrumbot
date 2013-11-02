FactoryGirl.define do
  factory :integration do |i|
    i.account { create(:account) }
    i.username 'OviTheBullDog'
    i.token 'ABC123'
    i.user { create(:user) }
  end
end