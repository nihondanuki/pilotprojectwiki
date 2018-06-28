class Inquiry < ApplicationRecord
  belongs_to :user
  has_many :answers
  validates :user_id, presence: true
  validates :subject, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 1000 }
end
