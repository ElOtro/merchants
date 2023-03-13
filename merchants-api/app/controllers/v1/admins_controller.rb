# frozen_string_literal: true

module V1
  class AdminsController < V1::BaseController
    before_action :authenticate_admin!
    before_action :set_admin, only: %i[show update destroy]

    # GET /admins
    def index
      @admins = Admin.all

      render json: @admins
    end

    # GET /admins/1
    def show
      render json: @admin
    end

    # POST /admins
    def create
      @admin = Admin.new(admin_params)

      if @admin.save
        render json: @admin, status: :created
      else
        render json: @admin.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /admins/1
    def update
      if @admin.update(admin_params)
        render json: @admin
      else
        render json: @admin.errors, status: :unprocessable_entity
      end
    end

    # DELETE /admins/1
    def destroy
      @admin.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:name, :email)
    end
  end
end
