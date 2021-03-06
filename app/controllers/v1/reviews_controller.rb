class V1::ReviewsController < ApplicationController
  before_action :authenticate_request!

  def index
    destination = Destination.find(params[:destination_id])
    @reviews = destination.reviews.filter(params.slice(:heading_scope, :content_scope, :rating_scope))
    json_response(@reviews)
  end

  def show
    @review = Review.find(params[:id])
    json_response(@review)
  end

  def create
    @destination = Destination.find(params[:destination_id])
    @review = @destination.reviews.create!(review_params)
    json_response(@review, :created)
  end

  def update
    @review = Review.find(params[:id])
    if @review.update!(review_params)
      render status: 200, json: {
        message: "Your review has successfully been updated."
      }
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      render status: 200, json: {
        message: "Your review has been deleted."
      }
    end
  end

private
  def review_params
    params.permit(:content, :heading, :rating, :user_id)
  end
end
