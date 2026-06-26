class TrainingSessionsController < ApplicationController
  def new
    @training_session = current_user.training_sessions.build
    @training_session.trained_on = session[:selected_date] || Date.today
    @training_session.training_sets.build
    setup_form_options
  end

  def create
    @training_session = current_user.training_sessions.build(training_session_params)
    if @training_session.save
      redirect_to root_path, notice: "トレーニングを記録しました"
    else
      setup_form_options
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    @training_session.errors.add(:base, "同じ日付・種目・マシンの組み合わせはすでに記録されています")
    setup_form_options
    render :new, status: :unprocessable_entity
  end

  private

  def setup_form_options
    @exercises = current_user.exercises.order(:name)
    @gym = current_user.gyms.find_by(id: session[:selected_gym_id])
    @machines = @gym ? @gym.machines : Machine.none
  end

  def training_session_params
    params.require(:training_session).permit(
      :exercise_id, :machine_id, :trained_on, :memo,
      training_sets_attributes: [:set_number, :weight, :reps]
    )
  end
end
