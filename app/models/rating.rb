class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie, touch: true

  validates :movie_id, uniqueness: { scope: :user_id }
end
