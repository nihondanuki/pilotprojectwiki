FactoryBot.define do
  factory :inquiry do
    body "イートハーブのなんとか"
    subject "gitの使い方を教えてほしい"
    association :user
  end
end
