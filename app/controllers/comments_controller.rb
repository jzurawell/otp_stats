class CommentsController < ApplicationController
  def comments
    after = Time.now - 1.week
    @comment_count = Activity.fetch(:comment, after)
    @comments = Kaminari.paginate_array(Comment.fetch_comments(after)).page(page).per(per_page)
  end
end