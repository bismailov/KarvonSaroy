require 'spec_helper'

describe "Authenticaton" do
  
  let(:base_title){"KarvonSaroy.uz > English for Kids | "}
  
  subject { page }

  describe 'signin page' do
    before { visit signin_path }

    it { should have_selector('h1', text: I18n.t("messages.session.sign_in")) }
    it { should have_title("#{base_title}#{I18n.t("messages.session.sign_in")}") }
  end

  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button I18n.t("messages.session.sign_in") }
      
      it { should have_title("#{base_title}#{I18n.t("messages.session.sign_in")}") }
      it { should have_selector('div.alert.alert-error', text: I18n.t("messages.session.invalid_credentials") ) }
      
      describe "after visiting another page" do
        #look at following page http://techblog.fundinggates.com/blog/2012/08/capybara-2-0-upgrade-guide/
        #it explains why first variant (click_link) won't work
        # before { click_link I18n.t("ui.home") }
        before { first(:link, I18n.t("ui.home") ).click }
        it { should_not have_selector('div.alert.alert-error') }
      end
    

    end


    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_title("#{base_title}#{user.name}") }

      it { should_not have_link( I18n.t("ui.users"), href: users_path ) }
      it { should have_link( I18n.t("ui.profile"), href: user_path(user) ) }
      it { should have_link( I18n.t("ui.settings"), href: edit_user_path(user) ) }
      # it { should have_link( I18n.t("messages.session.sign_out"), href: signout_path(user) ) }
      it { should have_content( I18n.t("messages.session.sign_out") ) }

      it { should_not have_link( I18n.t("messages.session.sign_in"), href: signin_path(user) ) }
    
      describe "followed by signout" do
        before { click_link I18n.t("messages.session.sign_out") }
        it { should have_link( I18n.t("messages.session.sign_in") ) }
      end
    
    end
  end

  describe "authorization" do
    context "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      context "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title("#{base_title}#{I18n.t("messages.session.sign_in")}") }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title("#{base_title}#{I18n.t("messages.session.sign_in")}") } 
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in I18n.t("activerecord.attributes.user.email"),      with: user.email
          fill_in I18n.t("activerecord.attributes.user.password"),   with: user.password
          click_button I18n.t("messages.session.sign_in")
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_title("#{base_title}#{I18n.t("messages.edit_user")}") 
          end
        end
      end

    end


    context "as wrong user" do
      let (:user) {FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title("#{base_title}#{I18n.t("messages.edit_user")}") }
      end

      describe "submitting a PUT request to the Users@update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end

    end
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
    
      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end
end
