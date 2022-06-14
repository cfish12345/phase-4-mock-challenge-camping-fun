class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordNotFound, with: :invalid

    # def index
    #     render json: Signup.all, status: :ok
    # end

    # def show
    #     signup = Signup.find_by(id: params[:id])
    #     if signup
    #         render json: signup, status: :ok
    #     else
    #         render json: { error: "Signup not found" }, status: :not_found
    #     end
    # end

    def create
        signup = Signup.create(signup_params)
        render json: signup, includes: :activities, status: 201
    end

    private

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def not_found
        render json: { error: "Signup not found" }, status: 404
    end

    def invalid
        render json: { error: ["validation errors"] }, status: 422
    end
end
