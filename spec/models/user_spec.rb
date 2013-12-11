# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  surname         :string(255)
#  remember_token  :string(255)
#  role            :string(255)
#

require 'spec_helper'

describe User do

  before do
    @user = User.new(name: 'Example', surname: 'User', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar') 
  end

  subject { @user }

  
  it { should respond_to(:name) }
  it { should respond_to(:surname) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  # it { should respond_to(:admin) }
  # it { should respond_to(:editor) }
  it { should respond_to(:role) }
  

  it { should be_valid }
  # it { should_not be_admin }
  # it { should_not be_editor }

  # describe "role initial valie" do
    # @user.role should be_empty 
  # end

  describe "when name is not present" do
    before { @user.name = "" } 
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 } 
    it { should_not be_valid }
  end


  describe "when surname is not present" do
    before { @user.surname = "" } 
    it { should_not be_valid }
  end

  describe "when surname is too long" do
    before { @user.surname = "a" * 51 } 
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" } 
    it { should_not be_valid }
  end


  describe "when role is invalid" do
    it "should be invalid" do
      roles = %w[administrator moderators cromophag author_ banner]
      roles.each do |invalid_role|
        @user.role = invalid_role
        @user.should_not be_valid
      end
    end
  end

  describe "when role is valid" do
    it "should be valid" do
      roles = %w[admin moderator editor author banned] << nil
      roles.each do |valid_role|
        @user.role = valid_role
        @user.should be_valid
      end
    end
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com] 
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid}

  end

  describe "when email address is already taken case insensitive" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid}

  end



  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end



  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it {should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end


  describe "remember token" do
    before { @user.save }
    its(:remember_token) {should_not be_blank}
  end

  #http://stackoverflow.com/questions/16244902/using-rspec-to-test-for-correct-order-of-records-in-a-model
  describe "default scope" do
    before do
      @user2 = User.create(name: 'Roy', surname: 'McAndy', email: 'pam@exam.com', password: 'foobar', password_confirmation: 'foobar') 
      @user3 = User.create(name: 'Roy', surname: 'Andyman', email: 'pamjim@ex.com', password: 'foobar', password_confirmation: 'foobar')
    end

    # pp User.all
    # pp [@user3, @user2]
    
    it "should order by surname" do
      User.all.should == [@user3, @user2]
    end
  end

  describe "with role set to admin" do
    before do
      @user.save!
      @user.update_attribute(:role, "admin")
    end

    it { should be_valid }
  end

  describe "with editor attribute set to 'true'" do
    before do
      @user.save!
      @user.update_attribute(:role, "editor")
    end

    it { should be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to role" do
      expect do
        # User.new(admin: true)
        User.new(role: "admin")
        # expect {}.should is deprecated:
      # end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    # it "should not allow access to editor" do
      # expect do
        # User.new(editor: true)
      # end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    # end

  end
end
