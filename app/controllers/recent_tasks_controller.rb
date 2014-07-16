class RecentTasksController < ApplicationController
  def recent_tasks
    completed_after = params['completed-after']

    @total_count = Task.fetch_total_count(completed_after)
    @tasks = Kaminari.paginate_array(Task.fetch_tasks(completed_after)).page(page).per(per_page)
  end
end
