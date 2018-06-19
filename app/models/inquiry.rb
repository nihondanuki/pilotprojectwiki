class Inquiry < ApplicationRecord
  belongs_to :user
  validates :user_id, presense: true
  validates :subject, presense: true, length: { maximum: 30 }
  validates :body, presense: true, length: { maximum: 1000 }
end
