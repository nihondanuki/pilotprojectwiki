class InquirySaveAndSlackDecorator
  require 'dotenv'
  include ActiveModel::Model
  Dotenv.load
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
        ENV["WEB_SLACK"],
        username: "通知"
      )
    end
end
