require 'spec_helper'

describe "User pages" do
  

  let(:base_title){"KarvonSaroy.uz > English for Kids | "}

  subject { page }

  describe "signup page" do
    before { visit signup_path}

    it { should have_selector('h1', text: "Ro'yxatdan o'tish") }
    it { should have_title("#{base_title}Ro'yxatdan o'tish")}

  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_title("#{base_title}#{user.name}") }
  end

  

  describe "signup" do

    before {visit signup_path}

    let(:submit) { "Meni ro'yxatdan o'tkaz" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Ismingiz",               with: "Example User"
        fill_in "Familiyangiz",           with: "Userov"
        fill_in "Email manzilingiz",      with: "User@example.com"
        fill_in "Parol",                  with: "foobar"
        fill_in "Parolni tasdiqlang",     with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to_change(User, :count).by(1)  
      end
    end
  end


end

