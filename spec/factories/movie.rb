FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Movie_#{n}" }
    description { 'Dummy text' }
    user

    trait :with_rating do
      transient do
        rating { 1 }
      end

      after(:create) do |movie, evaluator|
        create :rating, movie: movie, rating: evaluator.rating
      end
    end
  end
end
