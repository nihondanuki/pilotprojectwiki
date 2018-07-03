require "rails_helper"

RSpec.describe InquirySaveAndSlackDecorator, type: :model do
  describe "#save" do
    context "保存に成功した場合" do
      context "slackへのpostが成功した場合" do
        let(:inquiry) { instance_double(Inquiry, save: true, subject: "gitの使い方を教えて欲しい") }
        let(:inquiry_slack_decorator) { InquirySaveAndSlackDecorator.new(inquiry) }
        let(:post_slack) { instance_double(Slack::Notifier) }
        before do
          allow(post_slack).to receive(:post).with(text: "質問 #{inquiry.subject}").and_return(true)
          allow(inquiry_slack_decorator).to receive(:slack).and_return(post_slack)
        end

        it { expect(inquiry_slack_decorator.save).to be_truthy }
      end

      context "slackへのpostが失敗した場合" do
        let(:inquiry) { instance_double(Inquiry, save: true, subject: "gitの使い方を教えて欲しい") }
        let(:inquiry_slack_decorator) { InquirySaveAndSlackDecorator.new(inquiry) }
        let(:post_slack) { instance_double(Slack::Notifier) }
        before do
          allow(post_slack).to receive(:post).with(text: "質問 #{inquiry.subject}").and_return(false)
          allow(inquiry_slack_decorator).to receive(:slack).and_return(post_slack)
        end

        it { expect(inquiry_slack_decorator.save).to be_truthy }
      end
    end

    context "保存に失敗した場合" do
      let(:inquiry) { instance_double(Inquiry, save: false) }
      let(:inquiry_slack_decorator) { InquirySaveAndSlackDecorator.new(inquiry) }

      it { expect(inquiry_slack_decorator.save).to be_falsey }
    end
  end
end
