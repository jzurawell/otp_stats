class ApprovalsController < ApplicationController
  def approvals
    @total_count = Approval.fetch_approval_total
    @approval_tasks = Kaminari.paginate_array(Approval.fetch_approval_tasks).page(page).per(per_page)
  end
end