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
      slack.post text: "質問 #{@inquiry.subject}"
    end
  
    def slack
      notifier = Slack::Notifier.new(
        "https://hooks.slack.com/services/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",
        username: "通知"
      )
    end
end
