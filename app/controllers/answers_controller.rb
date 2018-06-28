class AnswerController < ApplicationController
  def create
    binding.pry
    inquiry ||= Inquiry.find(inquiry_id)
    @answer = inquiry.answers.build(answer_params)
    @answer.user = current_user
    redirect_to inquiry
  end

  private
    def inquiry_id
      params.require(:inquiry).permit(:id).[:id]
    end

    def answer_params
      params.require(:answer).permit(:context)
    end
end
