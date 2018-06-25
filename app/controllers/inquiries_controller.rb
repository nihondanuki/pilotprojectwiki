class InquiriesController < ApplicationController
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :edit, :create, :update, :destroy]
  before_action :require_permit, only: [:edit, :update, :destroy]

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
      unless (current_user == @inquiry.user)
        redirect_to @inquiry
      end
    end
end
