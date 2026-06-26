class MachinesController < ApplicationController
  before_action :set_gym

  def index
    @machines = @gym.machines
  end

  def select
    session[:selected_machine_id] = params[:id]
    redirect_to new_training_session_path
  end

  def skip
    session[:selected_machine_id] = nil
    redirect_to new_training_session_path
  end

  def new
    @machine = @gym.machines.build
  end

  def create
    @machine = @gym.machines.build(machine_params)
    if @machine.save
      redirect_to gym_machines_path(@gym), notice: "マシンを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_gym
    @gym = current_user.gyms.find(params[:gym_id])
  end

  def machine_params
    params.require(:machine).permit(:name, :setting_memo)
  end
end
