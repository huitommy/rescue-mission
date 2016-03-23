class QuestionsController < ApplicationController
  def index
    @questions = Question.all.order(created_at: :DESC)
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.order(created_at: :asc)
  end

  def new
    current_user
    @question = Question.new
    if @current_user.nil?
      flash[:notice] = 'Please sign your in before posting a question.'
      redirect_to root_url
    end
  end

  def create
    current_user
    @question = Question.new(question_params)
    @question.user_id = @current_user.id

    if @question.save
      flash[:notice] = "Question was created successfully!"
      redirect_to(@question)
    else
      render :new
    end
  end

  def edit
    current_user
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.order(created_at: :asc)

    if @current_user.nil?
      flash[:notice]= "Please sign in before editing"
      render :show
    elsif @current_user.id != @question.user_id
      flash[:notice]= "Please sign in before editing"
      redirect_to root_url
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = "Question was updated successfully!"
      redirect_to(@question)
    else
      render :edit
    end
  end

  def destroy
    current_user
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.order(created_at: :asc)

    if @current_user.nil?
      flash[:notice]= "Please sign in before deleting a question"
      render :show and return
    elsif @current_user.id != @question.user_id
      flash[:notice]= "Please sign in before deleting this question"
      redirect_to root_url and return
    end

    @question.destroy
    flash[:notice] = "Question was deleted successfully!"
    redirect_to root_url
  end

  private

  def question_params
    params.require(:question).permit(
      :title,
      :body,
      :user_id
    )
  end
end
