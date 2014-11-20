class JoinsController < ApplicationController
  def joins
    after = Time.now - 1.week
    @member_joined_count = Activity.fetch_team_activity(:member_joined, after)
    @members_joined = Kaminari.paginate_array(Join.fetch_members_joined(after)).page(page).per(per_page)
  end
end
    