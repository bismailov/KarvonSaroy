require 'spec_helper'

describe "Static pages" do
  
  let(:base_title){"KarvonSaroy.uz > English for Kids | "}

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_content('English for Children') }
    it { should have_selector('h1', text: 'English for Children') }
    it { should have_title("#{base_title}Home") }
      # there is a bug in Capybara 2, you can't use have_selector on 'title'
      # attribute:
      # page.should have_selector('title', text: "KarvonSaroy.uz > English for Kids | Home")
    
  end


  describe "About" do
    before { visit about_path }
    it { should have_content('About KarvonSaroy.uz') }
    it { should have_selector('h1', text: 'About KarvonSaroy.uz') }
    
    it "should have the title 'About'" do
      page.should have_title("#{base_title}About")
    end


  end



end



# describe "StaticPages" do
#   describe "GET /static_pages" do
#     it "works! (now write some real specs)" do
#       # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#       get static_pages_index_path
#       response.status.should be(200)
#     end
#   end
# end
