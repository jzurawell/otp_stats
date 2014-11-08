class Auth
    CREDENTIALS = {
        name: Rails.application.secrets.basic_auth_name,
        password: Rails.application.secrets.basic_auth_password
    }
end