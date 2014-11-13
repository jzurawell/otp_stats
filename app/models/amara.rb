class Amara
    include HTTParty
    # debug_output $stdout # <~ uncomment for verbose output

    HOST = "http://www.amara.org"
    BASE_URL = "/api2/partners"
    TASKS_BASE_URL = "/api2/partners/teams/ted/tasks"
    ACTIVITY_BASE_URL = "/api2/partners/activity"
    HEADERS = {
        "X-api-username" => Rails.application.secrets.amara_api_username,
        "X-apikey" => Rails.application.secrets.amara_api_key
    }

    class << self
        def fetch_tasks(params={})
            get(HOST + TASKS_BASE_URL,
              :query => params,
              :headers => HEADERS
            ).parsed_response
        end

        def fetch_activities(params={})
            get(HOST + ACTIVITY_BASE_URL,
                :query => params,
                :headers => HEADERS
            ).parsed_response
        end
    end
end
