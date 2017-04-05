class HomeController < ApplicationController
  load_and_authorize_resource except: [:index ]

  def index
    @restaurants = Restaurant.get_all_restaurant(params,current_user)
  end

end
