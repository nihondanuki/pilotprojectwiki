require "rails_helper"

RSpec.describe MakeInquiryPostSlack, type: :model do
  describe "#save" do
    context "保存に成功した場合" do
      let(:inquiry) { instance_double(Inquiry, save: true, subject: "gitの使い方を教えて欲しい") }
      let(:decorator) { MakeInquiryPostSlack.new(inquiry) }
      let(:post_slack) { instance_double(Slack::Notifier) }

      it do
        expect(post_slack).to receive(:post).with(text: "質問 #{inquiry.subject}")
        expect(decorator).to receive(:slack).and_return(post_slack)
        expect(decorator.save).to be_truthy
      end
    end

    context "保存に失敗した場合" do
      let(:inquiry) { instance_double(Inquiry, save: false) }
      let(:decorator) { MakeInquiryPostSlack.new(inquiry) }

      it do
        expect(decorator).not_to receive(:slack)
        expect(decorator.save).to be_falsey
      end
    end
  end
end
