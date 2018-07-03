class AnswersController < ApplicationController
  before_action :require_login, only: [:create]

  def create
    inquiry = Inquiry.find(params[:inquiry_id])
    @answer = inquiry.answers.create(answer_params.merge(user_id: current_user.id))
    redirect_to inquiry
  end

  private
    def answer_params
      params.require(:answer).permit(:content)
    end

end
