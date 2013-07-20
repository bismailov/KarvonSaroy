FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:surname) { |n| "Persona #{n}" }
    sequence(:email) { |n| "person_persona_#{n}@example.com.eu" }
    password  "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
  end
end
