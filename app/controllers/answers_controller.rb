class AnswersController < ApplicationController
  def index
    @question = Quesiton.find(params[:question_id])
    @answers = @question.answers
  end

  def new
    @question = Quesiton.find(params[:question_id])
    @answer = Answer.new
  end

  def show
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
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
