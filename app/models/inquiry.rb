class Inquiry < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presense: true
  validates :subject, presense: true, length: { maximum: 30 }
  validates :body, presense: true, length: { maximum: 1000 }
end
