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

    it { should_not have_selector('h1', text: user.name) }
    it { should_not have_title("#{base_title}#{user.name} #{user.surname}") }
  end

  

  describe "signup" do

    before {visit signup_path}
    let(:submit) { I18n.t("messages.register_me") }

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
    before do
      sign_in user
      visit edit_user_path(user) 
    end

    describe "page" do
      it { should have_selector('h1', text: I18n.t("messages.update_your_profile") ) }
      it { should have_title("#{base_title}#{I18n.t("messages.edit_user")}") }
    end

    describe "with invalid information" do
      before { click_button I18n.t("messages.save_changes") }

      it { should have_content(I18n.t("messages.error") ) }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_surname) { "New Surname" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in I18n.t("activerecord.attributes.user.name"),       with: new_name 
        fill_in I18n.t("activerecord.attributes.user.surname"),    with: new_surname 
        fill_in I18n.t("activerecord.attributes.user.email"),      with: new_email 
        fill_in I18n.t("activerecord.attributes.user.password"),   with: user.password 
        fill_in I18n.t("activerecord.attributes.user.password_confirmation"),   with: user.password 
        click_button ( I18n.t("messages.save_changes") )
      end
      
      it { should have_title("#{base_title}#{new_name} #{new_surname}") }
      it { should have_selector('div.alert.alert-success')}
      it { should have_link(I18n.t("messages.session.sign_out"), href: signout_path) }

      specify { user.reload.name.should == new_name }
      specify { user.reload.surname.should == new_surname }
      specify { user.reload.email.should == new_email}
    end
  end

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }
    let(:subject_) { FactoryGirl.create(:subject) }

    before(:all) {50.times { FactoryGirl.create(:user) } }
    after(:all) { User.delete_all }

    before(:all) {10.times { FactoryGirl.create(:course) } }
    after(:all) { Course.delete_all }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should_not have_title("#{base_title}#{I18n.t("ui.all_users")}") }
    it { should_not have_selector('h1', text: I18n.t("ui.all_users")) }

    describe "pagination" do

      it { should_not have_selector('div.pagination') } 
      
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should_not have_selector('li', text: user.name)
        end
      end
    end

    

    describe "delete links" do
      
      it { should_not have_link(I18n.t('ui.delete')) }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path  
        end
                                      # look which user comes from db
        # it { should have_link(I18n.t('ui.delete'), href: user_path(User.last)) }
        it "should be able to delete another user" do
          # expect { click_link(I18n.t('ui.delete')) }.to change(User, :count).by(-1)
          expect { first(:link, I18n.t('ui.delete')).click }.to change(User, :count).by(-1)
        end
        it { should_not have_link(I18n.t('ui.delete'), href: user_path(admin)) }
      end

      describe "as an editor user" do
        let(:editor) { FactoryGirl.create(:editor) }
        before do
          sign_in editor
          visit users_path  
        end

        it { should_not have_link(I18n.t('ui.delete'), href: user_path(User.first)) }
        it { should_not have_link(I18n.t('ui.delete'), href: user_path(editor)) }
      end

      describe "as an author" do
        let(:author) { FactoryGirl.create(:author) }
        before do
          sign_in author
          visit users_path  
        end

        it { should_not have_link(I18n.t('ui.delete'), href: user_path(User.first)) }
        it { should_not have_link(I18n.t('ui.delete'), href: user_path(author)) }
      end

      describe "as a user" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          sign_in user
          visit users_path  
        end

        it { should_not have_link(I18n.t('ui.delete'), href: user_path(User.first)) }
        it { should_not have_link(I18n.t('ui.delete'), href: user_path(user)) }
      end

      #courses page delete links

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit courses_path  
        end

        # it { should have_link(I18n.t('ui.delete'), href: course_path(Course.first)) }
        # it "should be able to delete a course" do
         # # expect { click_link(I18n.t('ui.delete')) }.to change(Course, :count).by(-1)
          # expect { first(:link, I18n.t('ui.delete')).click }.to change(Course, :count).by(-1)
        # end
        # it { should_not have_link(I18n.t('ui.delete'), href: user_path(admin)) }
      end

      describe "as an editor" do
        let(:editor) { FactoryGirl.create(:editor) }
        before do
          sign_in editor
          visit courses_path  
        end

        # it { should_not have_link(I18n.t('ui.delete'), href: course_path(Course.first)) }
      end

      describe "as an author" do
        let(:author) { FactoryGirl.create(:author) }
        before do
          sign_in author
          visit courses_path  
        end

        # it { should_not have_link(I18n.t('ui.delete'), href: course_path(Course.first)) }
      end

      describe "as a user testing courses" do
        let!(:user) { FactoryGirl.create(:user) }        
        let!(:course_name) { FactoryGirl.create(:course) }
        before do
          sign_in user
          visit courses_path  
        end

        # it { should_not have_link(I18n.t('ui.delete'), href: course_path(Course.first)) }
        # it { should_not have_link(I18n.t('ui.delete'), href: course_path(course_name)) }
      end


    end




  end

  describe "user permissions" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit root_path
    end

    context "user menus regular user" do
      it { should_not have_content(I18n.t('ui.administration')) }
    end

    context "user menus editor" do
      let(:editor) { FactoryGirl.create(:editor) }
      before do
        sign_in editor
        visit root_path  
      end

      it { should have_content(I18n.t('ui.administration')) }
    end


    context "user menus author" do
      let(:author) { FactoryGirl.create(:author) }
      before do
        sign_in author
        visit root_path  
      end

      it { should have_content(I18n.t('ui.administration')) }
    end

    context "user menus admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit root_path  
      end

      it { should have_content(I18n.t('ui.administration')) }
    end

  end

 end
