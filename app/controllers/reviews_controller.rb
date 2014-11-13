class ReviewsController < ApplicationController
  def reviews
    @total_count = Review.fetch_review_total
    @review_tasks = Kaminari.paginate_array(Review.fetch_review_tasks).page(page).per(per_page)
  end
end