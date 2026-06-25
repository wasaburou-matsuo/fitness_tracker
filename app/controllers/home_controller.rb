class HomeController < ApplicationController
  def index
    @gyms = current_user.gyms

    session[:selected_gym_id] = params[:gym_id] if params[:gym_id].present?
    session[:selected_date]   = params[:date]   if params[:date].present?

    @selected_gym_id = session[:selected_gym_id]
    @selected_date   = session[:selected_date] || Date.today.to_s
    @selected_gym    = @gyms.find_by(id: @selected_gym_id)
  end
end
