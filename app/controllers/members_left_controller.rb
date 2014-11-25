class MembersLeftController < ApplicationController
  def members_left
    after = Time.now - 1.week
    @member_left_count = Activity.fetch_team_activity(:member_left, after)
    @members_left = Kaminari.paginate_array(MemberLeft.fetch_members_left(after)).page(page).per(per_page)
  end
end
