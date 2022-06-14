class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordNotFound, with: :unprocessable_entity

    def index
        render json: Camper.all, status: :ok
    end

    def show
        camper = Camper.find_by(id: params[:id])
        if camper
            render json: camper, includes: :activities, status: :ok
        else
            render json: { error: "Camper not found" }, status: 404
        end
    end

    def create
        camper = Camper.create(camper_params)
        render json: camper, include: :activity, status: 201
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def not_found
        render json: { error: "Signup not found" }, status: 404
    end

    def unprocessable_entity
        render json: { error: ["validation errors"] }, status: 422
    end
end
