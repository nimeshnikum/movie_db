FactoryBot.define do
  factory :rating do
    rating { (1..5).to_a.sample }
    comment { 'Dummy Comment' }
    movie
    user
  end
end
