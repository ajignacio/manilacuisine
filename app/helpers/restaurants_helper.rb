module RestaurantsHelper
  def select_for_cuisine
    Cuisine.all.collect {|p| [ p.name, p.id ] }
  end
end
