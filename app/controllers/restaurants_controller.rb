class RestaurantsController < ApplicationController
  def kitchen
  end

  def index
    @restaurants = Restaurant.all
    @background_pic = "blackpic"
  end

  def show
    @background_pic = "restaurantpic"
  end

  def menu
      @background_pic = "restaurantpic"
      @restaurant = Restaurant.find_by(id: params[:restaurant_id])
      @products = Product.where(restaurant_id: params[:restaurant_id])
      @bg_img_restaurant = @restaurant.img
  end

  def open
    @background_pic = "bg-dark"
    @meal = Meal.new
  end

  def meal
    mesa_id = params[:mesa_id]
    mesa = Mesa.find_by(id: mesa_id)
<<<<<<< HEAD
    mesa.available= true
=======
    mesa.available = true
    
    mesa.save
>>>>>>> c279ed846518f17174ae9e39ebe71e3ee8d6208f

    Meal.create(mesa_id:mesa_id)
    redirect_to "#{restaurant_mesa_index_path}/#{mesa_id}"
  end

  def mesas
    @mesas = Mesa.where(restaurant_id: params[:restaurant_id])
  end

  def availability
    res = {}
    Restaurant.all.each do |r|
      res[r.id] = {}
      res[r.id]["tablesAvailable"] = r.mesas.reduce(0) do |total, m|
        total += m.available ? 1 : 0
      end
    end
    render json: {restaurants: res}
  end
end
