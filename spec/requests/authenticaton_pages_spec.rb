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
      before do
        fill_in I18n.t("activerecord.attributes.user.email"),      with: user.email
        fill_in I18n.t("activerecord.attributes.user.password"),   with: user.password
        click_button I18n.t("messages.session.sign_in")
      end

      it { should have_title("#{base_title}#{user.name}") }
      it { should have_link( I18n.t("ui.profile"), href: user_path(user) ) }
      it { should have_link( I18n.t("messages.session.sign_out"), href: signout_path(user) ) }
      it { should_not have_link( I18n.t("messages.session.sign_in"), href: signout_path(user) ) }
    
      describe "followed by signout" do
        before { click_link I18n.t("messages.session.sign_out") }
        it { should have_link( I18n.t("messages.session.sign_in") ) }
      end
    
    end
  end
end
