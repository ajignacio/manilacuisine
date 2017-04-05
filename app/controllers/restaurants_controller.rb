class RestaurantsController < ApplicationController
  load_and_authorize_resource
  def index
    @restaurants = Restaurant.all
  end

  def new_restaurant
    @restaurant = Restaurant.new
    @url = build_restaurant_path
  end

  def build_restaurant
    @restaurant = Restaurant.build_restaurant(restaurant_params)
    respond_to do |f|
      if @restaurant.save
        f.html { redirect_to restaurants_path, notice: "Restaurant Successfully Create"}
      else
        f.html { render action: "new_restaurant" }
      end
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    @url = restaurant_path
  end

  def update
    #@restaurant = Restaurant.find(params[:id])
    respond_to do |f|
      if Restaurant.update_restaurant(params[:id], restaurant_params)
        f.html { redirect_to restaurants_path, notice: "Restaurant Successfully Updated" }
        f.json
      else
        f.html { render action: "edit" }
      end
    end
  end

  def destroy
    @restaurant.destroy
    respond_to do |f|
      f.html { redirect_to restaurants_path }
    end
  end

  def get_random_restaurant #  pick 3 random restaurants
    @restaurants = Restaurant.random_restaurant
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:cuisine, :name, :address, :telephone_number)
  end

end
