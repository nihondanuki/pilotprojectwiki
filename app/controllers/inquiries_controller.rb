class InquiriesController < ApplicationController
  before_action :set_inquiry, only: [:show, :edit, :update]
  before_action :require_login, only: [:new, :edit, :create, :update]
  before_action :require_permit, only: [:edit, :update]

  def index
    @inquiries = Inquiry.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  # GET /inquiries/new
  def new
    @inquiry = current_user.inquiries.build
  end

  def edit
  end

  # POST /inquiries
  def create
    @inquiry = current_user.inquiries.build(inquiry_params)

    if @inquiry.save
      redirect_to @inquiry
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
    # Use callbacks to share common setup or constraints between actions.
    def set_inquiry
      @inquiry ||= Inquiry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inquiry_params
      params.require(:inquiry).permit(:subject, :body)
    end

    def require_permit
      redirect_to @inquiry if current_user != @inquiry.user
    end
end
