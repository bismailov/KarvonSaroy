require 'spec_helper'

describe "User pages" do
  

  let(:base_title){"KarvonSaroy.uz > English for Kids | "}
  subject { page }

  describe "signup page" do
    before { visit signup_path}

    it { should have_selector('h1', text: "Ro'yxatdan o'tish") }
    it { should have_title("#{base_title}Ro'yxatdan o'tish")}

  end
end

