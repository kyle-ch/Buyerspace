class SellerController < ApplicationController
  def all
    @seller = Seller.where(:seller_id => session[:seller_id])[0]
    @active = Posting.where(:completion_status => 0).order(posting_id: :desc)
    @trending =  Tag.select(:tag_id, :tag_text).joins("JOIN
      (select * from postings where completion_status = 0) p
      on p.tag_id = tags.tag_id
      group by tags.tag_id order by count(tags.tag_id) DESC")

    @ratings = Seller.select(:seller_id, :avg).joins("left join (select
      seller_id si, average_rating(seller_id) avg from ratings group by seller_id) r
      on sellers.seller_id = r.si where seller_id = #{session[:seller_id]}")
      .group(:seller_id)

    @offers = Offer.select(:title, :offer_id, :offer_price, :description).joins("JOIN postings on
      postings.posting_id = offers.posting_id")
      .where("offers.accepted = 'pending' and postings.completion_status = 0 and seller_id = #{session[:seller_id]}")
  end

  def show
    @posting = Posting.where(:posting_id => params[:id])[0]
  end

  def offer
    puts "id: #{params[:id]}"
    Offer.create(:seller_id => session[:seller_id], :posting_id => params[:id],
    :offer_price => params[:offer_price], :description => params[:description])
    redirect_to seller_all_path(:success => "offer")
  end

  def search
    @results = Posting.where("completion_status = 0
      and (description like '%#{params[:q]}%'
        or title like '%#{params[:q]}%')")
  end

  def tag
    @results = Posting.where(:tag_id => params[:id])
  end

  def delete
    Offer.delete(params[:id ])
    redirect_to seller_all_path(:success => "delete")
  end
end
