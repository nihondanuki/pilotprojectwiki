class AnswersController < ApplicationController
  def create
    inquiry ||= Inquiry.find(answer_params[:inquiry])
    @answer = inquiry.answers.create(content: answer_params[:content], user_id: current_user.id)
    redirect_to inquiry
  end

  private
    def answer_params
      params.require(:answer).permit(:inquiry, :content)
    end

end
