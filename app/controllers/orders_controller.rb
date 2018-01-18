class OrdersController < ApplicationController
  def new
    session[:order] = []
    session.delete(:receipt)
    redirect_to root_path
  end

  def create
    session[:order] << params[:food_id]
    redirect_to root_path
  end

  def edit
    session[:order].slice!(session[:order].index(params[:id]))
    session[:order].sort!
    redirect_to root_path
  end

  def cancel
    session.delete(:order)
    session.delete(:tip)
    redirect_to root_path
  end

  def update
    session[:tip] = params[:tip]
    redirect_to root_path
  end


  def save

    # begin saving order to DB

    if Order.last
      @ord_num = Order.last.id + 100001
    else
      @ord_num = 100000
    end

    if session[:tip]
      @tip = session[:tip]
      @tip = @tip.to_i
    else
      @tip = 0
    end

    if session[:order].length > 0
      @purchases = []
      @total = 0
      session[:order].each do |id|
        @purchases << Food.find(id)
        @total = @total + Food.find(id).price
      end
    else
      flash[:order_errors] = ["Add an item to your order first!"]
      redirect_to root_path
      return
    end

    # required variables to create an Order are now available
    @user_order = Order.create(order_num: @ord_num, tip: @tip, total: @total, user: User.find(session[:id]))
    if @user_order.valid?
      @user_order.save
      session[:order_id] = @user_order.id
    else
      flash[:order_errors] = @user_order.errors.full_messages
    end

    # Order established in DB; now save dependent purchases
    @purchases.each do |item|
      @indiv_purchase = Purchase.create(order: @user_order, food: item)
      if @indiv_purchase.valid?
        @indiv_purchase.save
      else
        flash[:purchase_errors] << @indiv_purchase.errors.full_messages
      end
    end
    session[:receipt] = true # will flag related variable creation/views in root
    redirect_to root_path
  end

  def destroy
    session.delete(:order)
    session.delete(:tip)
  end


private

  def order_params
  end

end
