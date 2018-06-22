require "rails_helper"

RSpec.describe MakeInquiryPostSlack, type: :model do
  describe "#save" do
    context "保存に成功した場合" do
      let(:inquiry) { instance_double(Inquiry, save: true) }
      let(:decorator) { MakeInquiryPostSlack.new(inquiry) }
      let(:post_slack) { instance_double(Slack::Notifier, post_slack: true) }

      it do
        expect(Slack::Notifier).to receive(:post).and_return(post_slack)
        expect(decorator.save).to be_truthy
      end
    end

    context "保存に失敗した場合" do
      let(:inquiry) { instance_double(Article, save: false) }
      let(:decorator) { MakeInquiryPostSlack.new(inquiry) }

      it do
        expect(Slack::Notifier).not_to receive(:post)
        expect(decorator.save).to be_falsey
      end
    end
  end
end
