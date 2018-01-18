class FoodsController < ApplicationController

  def index
    @apps = Course.find_by(category:"Appetizer")
    @entrees = Course.find_by(category:"Entree")
    @sides = Course.find_by(category:"Sides")
    @desserts = Course.find_by(category:"Dessert")
    @foods = Food.all

    # when user is logged in
    if session[:id]
      @user = User.find(session[:id])
      if @user.admin
        @admin_logged == true
      end
    end

    # creates food object to be edited
    if session[:edit_id]
      @edit = Food.find(session[:edit_id])
    end

    # user initiates a new order
    if session[:order]
      @order = []
      @total = 0
      session[:order].each do |id|
        @order << Food.find(id)
        @total = @total + Food.find(id).price
      end
      order = @order
      @hash = order_hash(order)
    end

    # handles tip during active order
    if session[:tip]
      @tip = session[:tip]
      @tip = @tip.to_i
      @total = @total + (@total * @tip/100)
    end

    # Only needed after a successful order, clears sessions for pending order
    if session[:receipt]
      session.delete(:order)
      session.delete(:tip)
      @order_receipt = Order.find(session[:order_id])
    end
  end

  def create
    if params[:food][:course] == ""
      flash[:food_error] = ["select a valid category please"]
      redirect_to :back
      return
    end
    @user = User.find(session[:id])
    if @user.admin
      @admin = Admin.find_by(user_id:session[:id])
    end
    @course = course_params
    @input = food_params
    @food = create_food
    if @food.valid?
      @food.save
    else
      flash[:food_error] = @food.errors.full_messages
    end
    redirect_to root_path
  end

  def destroy
    Food.find(params[:id]).destroy
    redirect_to :back
  end


  def update
    @food = Food.find(session[:edit_id])
    food_change = food_params
    course = course_params
    if course.valid?
      food_change[:course] = course  # adds required "course_id" to update food form object.
      @food.update(food_change)
      if @food.valid?
        @food.save
        session.delete(:edit_id)
      else
        flash[:edit_errors] = ["Please enter a value for all fields when editing an item"]
        # flash[:edit_errors] = @foods.errors.full_messages
        flash[:edit] = true
      end
    else
      flash[:edit_errors] = ["please use existing course values to update an item. Contact admin for new food category."]
      flash[:edit] = true
    end
    redirect_to root_path
  end

  def edit
    session[:edit_id] = params[:id]
    flash[:edit] = true
    redirect_to root_path
  end

end

private

  def order_hash(order)
    i = 0
    hash_order = []
    order.uniq.each do |food|
      hash_order[i] = {id: food.id, quantity: food.count(order), name: food.name, total: food.count(order) * food.price}
      i = i + 1
    end
    hash_order
  end

  def course_params
    course = params.require(:food).permit(:course)
    if Course.find_by(category:course[:course]).present?
      Course.find_by(category:course[:course])
    else
      return ["course does not exist"]
      # course = Course.create(category:course[:course])
      # if course.valid?
      #   course.save
      # end
    course = Course.find_by(category:course[:course])
    end
  end

  def food_params
    params.require(:food).permit(:name, :description, :price)
  end

  def create_food
    Food.create(
      name: @input[:name],
      description: @input[:description],
      price: @input[:price],
      admin: @admin,
      course: @course)
  end
