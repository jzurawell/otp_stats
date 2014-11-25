class RejectedVersionsController < ApplicationController
  def rejected_versions
    after = Time.now - 1.week
    @reject_version_count = Activity.fetch(:reject_version, after)
    @rejected_versions = Kaminari.paginate_array(RejectedVersion.fetch_rejected_versions(after)).page(page).per(per_page)
  end
end