class PostingsController < ApplicationController
  def index
    redirect_to postings_all_path
  end

  def show
    @posting = Posting.where(:posting_id => params[:id])[0]
    @accepted = Offer.select(:offer_id, :seller_id, :offer_price, :description, :accepted, :fname, :lname).joins("JOIN sellers on sellers.seller_id = offers.seller_id
      where offers.accepted = 'accepted' and offers.posting_id = ", params[:id])
    if !@accepted.empty?
      @offers = @accepted
    else
      @offers = Offer.select(:offer_id, :seller_id, :offer_price, :description,
        :accepted, :fname, :lname, :avg).joins("JOIN sellers on sellers.seller_id = offers.seller_id
        left outer JOIN (select seller_id, average_rating(seller_id) avg from ratings group by seller_id) r
        on offers.seller_id = r.seller_id
        where offers.posting_id = ", params[:id])
    end
    @rating = Rating.where(:seller_id => params[:seller_id],
      :buyer_id => session[:buyer_id])
      if @rating.empty?
        @ratingval = 5
      else
        @ratingval = @rating[0].rating
      end
  end

  def edit
    @posting = Posting.where(:posting_id => params[:id])[0]
  end

  def delete
    @posting = Posting.where(:posting_id => params[:id])[0]
    @posting.destroy
    redirect_to postings_all_path(:success => "delete")
  end

  def all
    @buyer = Buyer.where(:buyer_id => session[:buyer_id])[0]
    @postings = Posting.where(:poster => session[:buyer_id]).where.not(:completion_status => 1)
    @completed = Posting.where(:poster => session[:buyer_id], :completion_status => 1)

  end

  def create
    @tag = Tag.where(:tag_text => params[:tag]).pluck(:tag_id)
    if (@tag.size < 1)
      Tag.create(:tag_text => params[:tag])
    end
    @tag = Tag.where(:tag_text => params[:tag]).pluck(:tag_id)
    @tag_id = @tag[0]

    Posting.create(:poster => session[:buyer_id], :title => params[:title],
    :posting_date => Date::today.strftime("%F"),
    :description => params[:description], :tag_id => @tag_id,
    :completion_status => 0, :asking_price => params[:asking_price])
    redirect_to postings_all_path(success: "create")
  end

  def new

  end

  def update
    @tag = Tag.where(:tag_text => params[:tag]).pluck(:tag_id)
    if (@tag.size < 1)
      Tag.create(:tag_text => params[:tag])
    end
    @tag = Tag.where(:tag_text => params[:tag]).pluck(:tag_id)
    @tag_id = @tag[0]
    @posting = Posting.where(:posting_id => params[:id])[0]
    @posting.update(title: params[:title], description: params[:description],
    asking_price: params[:asking_price])
    redirect_to postings_show_path(id: params[:id], success: "update")
  end

  def accept
    @offer = Offer.where(:offer_id => params[:id])[0]
    @offer.update(accepted: 'accepted')
    redirect_to postings_show_path(id: @offer.posting_id, success: "accept")
  end

  def decline
    @offer = Offer.where(:offer_id => params[:id])[0]
    @offer.update(accepted: 'declined')
    redirect_to postings_show_path(id: @offer.posting_id, success: "decline")
  end

  def rate
    @rating = Rating.where(:seller_id => params[:seller_id],
      :buyer_id => session[:buyer_id])
    if @rating.empty?
      Rating.create(:buyer_id => session[:buyer_id], :seller_id => params[:seller_id],
      :rating => params[:rating])
    else
      @rating[0].update(rating: params[:rating])
    end
    redirect_to postings_show_path(id: params[:posting_id], rated: "true")
  end
end
