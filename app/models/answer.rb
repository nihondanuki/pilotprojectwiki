class Answer < ApplicationRecord
  belongs_to :inquiry
  belongs_to :user
  validates :inquiry_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
end
