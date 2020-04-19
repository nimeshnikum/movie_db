require 'elasticsearch/model'

class Movie < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_and_belongs_to_many :categories
  belongs_to :user, optional: true

  has_many :ratings

  validates :title, presence: true, uniqueness: true

  scope :in_category, ->(category_ids) { includes(:categories).where(categories: { id: category_ids }) }

  after_touch :update_average_rating

  def user_rating(user)
    ratings.find_by(user: user).try(:rating)
  end

  private

  def update_average_rating
    update(average_rating: ratings.average(:rating).round(2))
  rescue
    # do nothing
  end
end
