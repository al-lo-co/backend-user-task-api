module Api
  class TasksController < ApplicationController
    before_action :set_task, only: [ :update, :show, :destroy ]

    def index
      render json: Task.all, status: :ok
    end

    def show
      if @task
        render json: @task, status: :ok
      else
        render status: :not_found
      end
    end

    def create
      task = Task.new(task_params)

      if task.save!
        render json: task, status: :created
      else
        render json: { errors: task.errors }, status: :unprocessable_entity
      end
    end

    def update
      if @task.update(task_params)
        render json: @task, status: :ok
      else
        render json: { errors: @task.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @task.destroy

      head :no_content
    end

    private

    def task_params
      params.require(:task).permit(:description, :status, :date, :user_id)
    end

    def set_task
      @task ||= Task.find(params[:id])
    end
  end
end
