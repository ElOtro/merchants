# frozen_string_literal: true

module V1
  class DashboardController < V1::BaseController
    before_action :authenticate_admin!

    def index
      render json: { data: { series: [1, 2, 3] } }, status: :ok
    end
  end
end
