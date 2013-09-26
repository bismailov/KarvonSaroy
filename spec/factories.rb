FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:surname) { |n| "Persona #{n}" }
    sequence(:email) { |n| "person_persona_#{n}@example.com.eu" }
    password  "foobar"
    password_confirmation "foobar"
    
    # factory :admin do
      # admin true
    # end

    factory :admin do
      role "admin"
    end

    factory :editor do
      role "editor"
    end

    factory :author do
      role "author"
    end

  end


  factory :course do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:objectives) { |n| "Objectives #{n}" }
    user_id 1 
    subject_id 1
    student_level_id 1
  end


  factory :subject do
    title "French for Adults"
  end

  factory :student_level do
    title "Advanced"
  end

end
