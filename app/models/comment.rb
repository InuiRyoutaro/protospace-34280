class Comment < ApplicationRecord
  validates :comment, presence: true

  belongs_to :prototype
  belongs_to :user
end
