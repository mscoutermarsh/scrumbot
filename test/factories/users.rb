FactoryGirl.define do
  factory :user do
    first_name  'Alex'
    last_name   'Ovechkin'
    sequence(:email){|n| "user#{n}@factory.com" }
    password    'c@pitals'
    skip_weekends 'true'
    time_zone     'Eastern Time (US & Canada)'
    tweet         'false'
  end
end