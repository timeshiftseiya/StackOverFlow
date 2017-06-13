class AnswersController < ApplicationController
  before_action :set_answer, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    @answer.update(answer_params)
    redirect_to quesiton_path(@answer.question), notice: "回答を更新しました！"
  end

  def create
    @answer = current_user.answers.build(answer_params)
    @question = @answer.question

    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_path(@question), notice: "回答を投稿しました！" }
        format.js { render :index }
      else
        format.html { render 'questions/index' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @answer.destroy
        format.js
        format.html { render 'questions/index' }
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :content)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

end