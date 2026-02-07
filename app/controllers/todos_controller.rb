class TodosController < ApplicationController
  # Use the callback to find the specific todo before actions
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = current_user.todos
    render json: @todos, status: :ok
  end

  def show
    render json: @todo, status: :ok
  end

  def create
    @todo = current_user.todos.create!(todo_params)
    render json: @todo, status: :created
  end

  def update
    @todo.update(todo_params)
    head :no_content
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    params.permit(:title)
  end

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end
end