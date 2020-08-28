FactoryBot.define do
  factory :user do
    account_id { String.random_number(6) }
    token      { String.random_number(15)}

    factory :user_facebook do
      account_id { String.random_number(6) }
      token      { String.random_number(15)}
      token_type { "facebook" }
    end

    factory :user_google do
      account_id { String.random_number(6) }
      token      { String.random_number(15)}
      token_type { "google" }
    end
  end

 
end
