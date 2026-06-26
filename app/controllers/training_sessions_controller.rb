class TrainingSessionsController < ApplicationController
  def new
    @training_session = current_user.training_sessions.build
    @training_session.trained_on = session[:selected_date] || Date.today
    @training_session.training_sets.build

    @exercises = current_user.exercises.order(:name)
    @gym = current_user.gyms.find_by(id: session[:selected_gym_id])
    @machines = @gym ? @gym.machines : Machine.none
  end

  def create
    @training_session = current_user.training_sessions.build(training_session_params)
    if @training_session.save
      redirect_to root_path, notice: "トレーニングを記録しました"
    else
      @exercises = current_user.exercises.order(:name)
      @gym = current_user.gyms.find_by(id: session[:selected_gym_id])
      @machines = @gym ? @gym.machines : Machine.none
      render :new, status: :unprocessable_entity
    end
  end

  private

  def training_session_params
    params.require(:training_session).permit(
      :exercise_id, :machine_id, :trained_on, :memo,
      training_sets_attributes: [:set_number, :weight, :reps]
    )
  end
end
