require 'elasticsearch/model'

class Movie < ApplicationRecord
  include Searchable

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

# Delete the previous articles index in Elasticsearch
Movie.__elasticsearch__.client.indices.delete index: Movie.index_name rescue nil

# Create the new index with the new mapping
Movie.__elasticsearch__.client.indices.create \
  index: Movie.index_name,
  body: { settings: Movie.settings.to_hash, mappings: Movie.mappings.to_hash }

Movie.import
