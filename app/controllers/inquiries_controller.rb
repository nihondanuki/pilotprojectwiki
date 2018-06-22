class InquiriesController < ApplicationController
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]
  before_action :login_watch, only: [:new, :edit, :create, :update, :destroy]

  # GET /inquiries/new
  def new
    @inquiry = current_user.inquiries.build
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inquiry
      @inquiry ||= Inquiry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inquiry_params
      params.require(:inquiry).permit(:subject, :body)
    end
end
