FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "Category_#{n}" }

    factory :category_with_movies do
      transient do
        movies_count { 3 }
      end

      after(:create) do |category, evaluator|
        create_list(:movie, evaluator.movies_count, categories: [category])
      end
    end
  end
end
