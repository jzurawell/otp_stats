class Amara
    HOST = "http://www.amara.org"
    TASKS_BASE_URL = "/api2/partners/teams/ted/tasks"
    ACTIVITY_BASE_URL = "/api2/partners/activity"
    HEADERS = {
        "X-api-username" => Rails.application.secrets.amara_api_username,
        "X-apikey" => Rails.application.secrets.amara_api_key
      }
end

# Amara::HOST
# Amara::BASE_URL
# Amara::HEADERS
