class Movie < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :user, optional: true

  has_many :ratings

  validates :title, presence: true, uniqueness: true

  scope :in_category, ->(category_ids) { includes(:categories).where(categories: { id: category_ids }) }

  def average_rating
    valid_ratings = ratings.reject { |r| r.rating.nil? }
    return nil if valid_ratings.blank?
    valid_ratings.sum(0) / valid_ratings.size
  end
end
