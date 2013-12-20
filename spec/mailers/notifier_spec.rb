require "spec_helper"

describe Notifier do
  describe "verify_email" do
    let(:mail) { Notifier.verify_email }

    it "renders the headers" do
      mail.subject.should eq("Verify email")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
