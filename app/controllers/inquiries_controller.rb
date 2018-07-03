class InquiriesController < ApplicationController
  before_action :set_inquiry, only: [:show, :edit, :update]
  before_action :require_login, only: [:new, :edit, :create, :update]
  before_action :edit_permition_require, only: [:edit, :update]

  def index
    @inquiries = Inquiry.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  # GET /inquiries/new
  def new
    @inquiry = Inquiry.new
  end

  def edit
  end

  # POST /inquiries
  def create
    @inquiry_post_slack = InquirySaveAndSlackDecorator.new(current_user.inquiries.build(inquiry_params))

    if @inquiry_post_slack.save
      redirect_to @inquiry_post_slack.inquiry
    else
      render :new
    end
  end

  def update
    if @inquiry.update(inquiry_params)
      redirect_to @inquiry
    else
      render :edit
    end
  end

  private

    def inquiry_params
      params.require(:inquiry).permit(:subject, :body)
    end

    def edit_permition_require
      redirect_to @inquiry unless @inquiry.posted_by?(current_user)
    end

    def set_inquiry
      @inquiry ||= Inquiry.find(params[:id])
    end
end
