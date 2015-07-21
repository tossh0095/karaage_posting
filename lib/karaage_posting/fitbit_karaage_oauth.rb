module KaraagePosting


  #
  # KaraagePosting Class for Fitbit
  #
  class FitbitKaraagePosting

    #
    # initialize FitbitKaraage Posting.
    #
    def initialize

      Dotenv.load("#{ENV['HOME']}/.fitbitenv")

      if ENV["FITBIT_ID"] == nil || ENV["FITBIT_SECRET"]==nil || ENV["FITBIT_REDIRECT_URL"] == nil then
        raise "There is no definitions for FITBIT enviroment variables.\n You must set ENV[FITBIT_ID], ENV['FITBIT_SECRET'], ENV['FITBIT_REDIRECT_URL']."
      end

      
      @fitbit_oauth_client = OAuth2::Client.new(ENV["FITBIT_ID"], ENV["FITBIT_SECRET"], :authorize_url =>'/oauth2/authorize',:token_url=>"/oauth2/token")

      @base64_id_secret = Base64.encode64(@fitbit_oauth_client.id + ':' + @fitbit_oauth_client.secret)

    end

    #
    # get the URI for Fitbit OAuth2.0 Authentication
    # @return [String] URL for Fitbit OAuth2.0 Authentication
    #
    def get_fitbit_authorize_uri
      scope = 'nutrition'
      
      Dotenv.load "#{ENV['HOME']}/.fitbitenv"
      @fitbit_oauth_client.site = "https://www.fitbit.com"
      @fitbit_oauth_client.auth_code.authorize_url(:scope => scope,:redirect_uri =>  ENV['FITBIT_REDIRECT_URL'])
    end

    # get the Access Token for Fitbit API
    # @params [String] Grant code for Fitbit API
    #
    def get_fitbit_token(code)
      @fitbit_oauth_client.site = "https://api.fitbit.com" 
      @fitbit_token = @fitbit_oauth_client.auth_code.get_token(code,:redirect_uri => ENV['FITBIT_REDIRECT_URL'] ,:headers =>{'Authorization' => "Basic #{@base64_id_secret}",'Body' => "client_id=#{@fitbit_oauth_client.id}"})
    end

    #
    # refresh the Access Token for Fitbit API
    #
    def refresh_fitbit_token
      @fitbit_oauth_client.site = "https://api.fitbit.com" 
      @fitbit_token = @fitbit_token.refresh!(:headers =>{'Authorization' => "Basic #{@base64_id_secret}",'Body' => "client_id=#{@fitbit_oauth_client.id}"})
    end

  end
end
