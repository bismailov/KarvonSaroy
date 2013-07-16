require 'spec_helper'

describe "User pages" do
  

  let(:base_title){"KarvonSaroy.uz > English for Kids | "}

  subject { page }

  describe "signup page" do
    before { visit signup_path}

    it { should have_selector('h1', text: I18n.t("messages.registration") ) }
    it { should have_title("#{base_title}#{I18n.t("messages.registration")}" )}

  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_title("#{base_title}#{user.name} #{user.surname}") }
  end

  

  describe "signup" do

    before {visit signup_path}

    let(:submit) { "Meni ro'yxatdan o'tkaz" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end


      describe "after submission" do
        before { click_button submit }

        it { should have_title I18n.t("messages.registration") }
        it { should have_content I18n.t("messages.error") }
      end

    end
  

    describe "with valid information" do
      before do
        fill_in I18n.t("activerecord.attributes.user.name"),       with: "Example User"
        fill_in I18n.t("activerecord.attributes.user.surname"),    with: "Userov"
        fill_in I18n.t("activerecord.attributes.user.email"),      with: "user@example.com"
        fill_in I18n.t("activerecord.attributes.user.password"),   with: "foobar"
        fill_in I18n.t("activerecord.attributes.user.password_confirmation"),   with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)  
      end 
      
      describe "after saving the user" do
        before { click_button submit}
        let(:user) { User.find_by_email('user@example.com') }
        it { should have_title("#{base_title}#{user.name} #{user.surname}") }
        it { should have_selector('div.alert.alert-success', text: I18n.t("messages.registration_welcome"))}
        it { should have_link(I18n.t("messages.session.sign_out")) }
      end
    end
    
  end


  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h1',    text: I18n.t("messages.update_your_profile") ) }
      it { should have_title("#{base_title}#{I18n.t("messages.edit_user")}") }
    end

    describe "with invalid information" do
      before { click_button I18n.t("messages.save_changes") }

      it { should have_content(I18n.t("messages.error")) }
    end
  end
end
