class ActivitiesController < ApplicationController

    def index
        render json: Activity.all, status: :ok
    end

    # def show
    #     activity = Activity.find_by(id: params[:id])
    #     if activity
    #         render json: activity, status: :ok
    #     else
    #         render json: { error: "Activity not found" }, status: :not_found
    #     end
    # end

    def destroy
        activity = Activity.find_by(id: params[:id])
        if activity
            activity.destroy
            render json: {}
        else
            render json: { error: "Activity not found" }, status: :not_found
        end
    end

    private

    def activity_params
        params.permit(:name, :difficulty)
    end
end
