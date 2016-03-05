class DeclinedVersionsController < ApplicationController
  def declined_versions
    after = Time.now - 1.week
    @decline_version_count = Activity.fetch(:decline_version, after)
    @declined_versions = Kaminari.paginate_array(DeclinedVersion.fetch_declined_versions(after)).page(page).per(per_page)
  end
end