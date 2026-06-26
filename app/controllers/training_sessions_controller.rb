class TrainingSessionsController < ApplicationController
  def index
    @training_sessions = current_user.training_sessions
                                     .includes(:exercise, :machine, :training_sets)
                                     .order(trained_on: :desc)
  end

  def show
    @training_session = current_user.training_sessions
                                    .includes(:exercise, :machine, :training_sets)
                                    .find(params[:id])
  end

  def new
    @training_session = current_user.training_sessions.build
    @training_session.trained_on = session[:selected_date] || Date.today
    @training_session.training_sets.build(set_number: 1)
    load_session_selections
  end

  def create
    @training_session = current_user.training_sessions.build(training_session_params)
    if @training_session.save
      redirect_to root_path, notice: "トレーニングを記録しました"
    else
      load_session_selections
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    @training_session.errors.add(:base, :duplicate_training_session)
    load_session_selections
    render :new, status: :unprocessable_entity
  end

  private

  def load_session_selections
    @exercise = current_user.exercises.find_by(id: session[:selected_exercise_id])
    @gym = current_user.gyms.find_by(id: session[:selected_gym_id])
    @machine = session[:selected_machine_id].present? ? @gym&.machines&.find_by(id: session[:selected_machine_id]) : nil
    @selected_date = session[:selected_date] || Date.today.to_s
  end

  def training_session_params
    params.require(:training_session).permit(
      :exercise_id, :machine_id, :trained_on, :memo,
      training_sets_attributes: [:set_number, :weight, :reps]
    )
  end
end
