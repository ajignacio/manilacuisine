class CuisinesController < ApplicationController
  load_and_authorize_resource

  def index
    @cuisines = Cuisine.all
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    respond_to do |f|
      if @cuisine.save
        f.html { redirect_to cuisines_path, notice: "Success"}
      else
        f.html { render action: "new" }
      end
    end
  end

  def update
    @cuisine = Cuisine.find(params[:id])
    respond_to do |f|
      if @cuisine.update_attributes(cuisine_params)
        f.html { redirect_to cuisines_path, notice: "Cuisine Successfully Updated" }
        f.json
      else
        f.html { render action: "edit" }
      end
    end
  end

  def destroy
    @cuisine.destroy
    respond_to do |f|
      f.html { redirect_to cuisines_path }
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

end
