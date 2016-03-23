class AnswersController < ApplicationController

  def update
    current_user
    @best_answer = Answer.find(params[:id])
    @question = @best_answer.question
    @answer = Answer.new
    @answers = @question.answers.order(best: :desc, created_at: :asc)

    if @current_user.nil?
      flash[:notice] = "You must log in"
      redirect_to question_path(@question)
    elsif @current_user.id != @question.user_id
      flash[:notice] = "You do not have permission to edit this question"
      redirect_to question_path(@question)
    else
      Answer.update_all best: false
      @best_answer.best = true
      @best_answer.save
      render 'questions/show'
    end
  end

  def create
    current_user
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answers = @question.answers.order(created_at: :asc)

    if @current_user.nil?
      flash[:notice] = 'Please sign in before deleting a question'
      render 'questions/show'
    else
      @answer.question = @question
      @answer.user_id = @current_user.id
      if @answer.save
        redirect_to question_path(@question)
      else
        render 'questions/show'
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :user_id, :best)
  end
end
