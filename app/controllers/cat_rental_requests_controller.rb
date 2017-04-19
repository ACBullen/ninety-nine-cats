class CatRentalRequestsController < ApplicationController



  def new
    render :req_form
  end

  def create
    @rental = CatRentalRequest.new(cat_rental_requests_params)
    if @rental.save
      redirect_to cats_url
    else
      render :req_form
    end
  end

  def approve
    @rental = CatRentalRequest.find_by(id: params[:id])
    @rental.approve!
    redirect_to cats_url
  end

  def deny
    @rental = CatRentalRequest.find_by(id: params[:id])
    @rental.deny!
    redirect_to cats_url
  end

  private

  def cat_rental_requests_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
