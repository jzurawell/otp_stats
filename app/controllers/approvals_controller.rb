class ApprovalsController < ApplicationController
  def approvals
    @total_count = Approvals.fetch_approvals_total
    @approval_tasks = Kaminari.paginate_array(Approvals.fetch_approval_tasks).page(page).per(per_page)
  end
end