class MachinesController < ApplicationController
  before_action :set_gym

  def new
    @machine = @gym.machines.build
  end

  def create
    @machine = @gym.machines.build(machine_params)
    if @machine.save
      redirect_to root_path, notice: "マシンを登録しました"
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
