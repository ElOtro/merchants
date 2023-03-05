class V1::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { data: { series: [1, 2, 3] } }, status: :ok
  end
end
