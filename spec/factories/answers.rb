FactoryBot.define do
  factory :answer do
    content "イーハトーヴ"
    association :inquiry
    association :user
  end
end
