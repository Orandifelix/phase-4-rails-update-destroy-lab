class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_error_if_not_found

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # POST /plants
  def create
    plant = find_plant
    render json: plant, status: :created
  end

  def update 
    plant = find_plant
    plant.update(plant_params)
    render json: plant
  end

  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
     Plant.find( params[:id])
  end

  def render_error_if_not_found
    render json: { error: "Bird not found" }, status: :not_found
  end 
end
