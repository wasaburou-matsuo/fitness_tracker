class ExercisesController < ApplicationController
  def new
    @exercise = current_user.exercises.build
  end

  def create
    @exercise = current_user.exercises.build(exercise_params)
    if @exercise.save
      redirect_to root_path, notice: "種目を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :body_part)
  end
end
