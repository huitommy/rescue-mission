class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :title, presence: true, length: { minimum: 4 }
  validates :body, presence: true, length: { minimum: 15 }
  validates :user_id, presence: true
end
