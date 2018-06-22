class MakeInquiryPostSlack
  include ActiveModel::Model
  define_model_callbacks :save, only: :after
  after_save :post_slack
  attr_reader :inquiry

  def initialize(inquiry)
    @inquiry = inquiry
  end

  def save
    run_callbacks :save do
      @inquiry.save
    end
  end

  private

    def post_slack
      notifier = Slack::Notifier.new(
        "https://hooks.slack.com/services/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",
        username: "通知"
      )
      notifier.post text: "質問 #{@inquiry.subject}"
    end
end
