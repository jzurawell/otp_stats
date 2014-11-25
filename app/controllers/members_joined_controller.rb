class MembersJoinedController < ApplicationController
  def members_joined
    after = Time.now - 1.week
    @member_joined_count = Activity.fetch_team_activity(:member_joined, after)
    members_joined = MemberJoined.fetch_members_joined(after)
    @user_data = Kaminari.paginate_array(members_joined).page(page).per(per_page)
    @user_data.each do |user|
      response = Rails.cache.fetch(user, expires_in: 1.hour) do
        url = Amara::HOST + Amara::USERS_BASE_URL + user['user']
        HTTParty.get( 
          url, :headers => Amara::HEADERS
        ).parsed_response
      end

      #user['full_name'] = response['full_name']
      user['languages'] = response['languages']
    end
  end
end
