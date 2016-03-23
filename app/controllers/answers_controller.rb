class AnswersController < ApplicationController

  def create
    current_user
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.user_id = @current_user.id
    @answers = @question.answers.order(created_at: :asc)

    if @answer.save
      redirect_to question_path(@question)
    else
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :user_id)
  end
end
