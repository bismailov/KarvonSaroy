require 'spec_helper'

describe "Authenticaton" do

  let(:base_title){"KarvonSaroy.uz > English for Kids | "}

  subject { page }

  describe "for non-signed-in users" do

    let(:user) { FactoryGirl.create(:user) }
    let(:subject_name) { FactoryGirl.create(:subject) }

    context "in the Subjects controller" do

      describe "visiting the edit page" do
        before { visit edit_subject_path(subject_name) }
        it { should have_title("#{base_title}Home") }
      end 

      describe "visiting the subject index" do
        before { visit subjects_path }
        it { should have_title("#{base_title}#{I18n.t("ui.all_subjects")}") } 
      end 

    end 
  end 
end
