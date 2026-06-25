class GymsController < ApplicationController
  def new
    @gym = current_user.gyms.build
  end

  def create
    @gym = current_user.gyms.build(gym_params)
    if @gym.save
      redirect_to root_path, notice: "ジムを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def gym_params
    params.require(:gym).permit(:name)
  end
end
