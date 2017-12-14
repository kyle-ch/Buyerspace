class LoginController < ApplicationController
  def index
    session[:buyer_id] = nil
    session[:seller_id] = nil
  end

  def login
    @matches = Buyer.where(:email => params[:email]).pluck(:buyer_id)
    session[:email] = params[:email]
    if isEmail(params[:email])
      if (@matches.size < 1)
        redirect_to login_new_path
      else
        @buyer_id = @matches[0]
        session[:buyer_id] = @buyer_id
        redirect_to postings_all_path
      end
    else
      redirect_to root_path(success: "failed")
    end
  end

  def sellerlogin
    @matches = Seller.where(:email => params[:email]).pluck(:seller_id)
    session[:email] = params[:email]
    if isEmail(params[:email])
      if (@matches.size < 1)
        redirect_to login_sellernew_path
      else
        @seller_id = @matches[0]
        session[:seller_id] = @seller_id
        redirect_to seller_all_path
      end
    else
      redirect_to root_path(success: "failed")
    end
  end

  def new

  end

  def sellernew

  end

  def create
    Buyer.create(:fname => params[:fname].rstrip, :lname => params[:lname].rstrip,
      :email => session[:email].rstrip, :phone => params[:phone].rstrip,
      :zipcode =>params[:zipcode].rstrip, :city => params[:city].rstrip,
      :state => params[:state])
    @buyer_id = Buyer.where(:email => session[:email]).pluck(:buyer_id)[0]
    session[:buyer_id] = @buyer_id
    session[:mode] = 0
    redirect_to postings_all_path
  end

  def sellercreate
    Seller.create(:fname => params[:fname].rstrip, :lname => params[:lname].rstrip,
      :email => session[:email].rstrip)
    @seller_id = Seller.where(:email => session[:email]).pluck(:seller_id)[0]
    puts "seller id = #{@seller_id}"
    session[:seller_id] = @seller_id
    session[:mode] = 1
    redirect_to seller_all_path
  end
end
