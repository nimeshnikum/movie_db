FactoryBot.define do
  sequence(:first_name) { |n| "first_name_#{n}" }
  sequence(:last_name) { |n| "last_name#{n}" }
  sequence(:user_username) { |n| "username_#{n}" }
  sequence(:user_email) { |n| "user_#{n}@moviedb.com" }

  factory :user do
    username { generate(:user_username) }
    email { generate(:user_email) }
    first_name
    last_name

    after :build do |u|
      u.password ||= "Password_#{rand(10000)}"
      u.password_confirmation ||= u.password
    end

    factory(:admin_user) do
      first_name { 'Admin' }
      last_name { 'User' }
      email { 'admin_user@moviedb.com' }
    end
  end
end
