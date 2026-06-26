class ExercisesController < ApplicationController
  def index
    @exercises = current_user.exercises.order(:name)
  end

  def select
    session[:selected_exercise_id] = params[:id]
    gym = current_user.gyms.find_by(id: session[:selected_gym_id])
    if gym
      redirect_to gym_machines_path(gym)
    else
      redirect_to new_training_session_path
    end
  end

  def new
    @exercise = current_user.exercises.build
  end

  def create
    @exercise = current_user.exercises.build(exercise_params)
    if @exercise.save
      redirect_to exercises_path, notice: "種目を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :body_part)
  end
end
