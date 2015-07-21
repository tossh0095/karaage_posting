require 'spec_helper'

describe KaraagePosting::FitbitKaraagePosting do

  describe 'karaage fitbit oauth spec' do
    let(:fitbit_karaage_poster) { KaraagePosting::FitbitKaraagePosting.new }

    it 'is instance of KaraagePosting::FitbitKaraagePosting' do
      expect(fitbit_karaage_poster.class).to eq KaraagePosting::FitbitKaraagePosting
    end

    it '#get_fitbit_authorize_uri returns Client Authentication URL for fitbit.com' do
      expect(fitbit_karaage_poster.get_fitbit_authorize_uri).to match %r%^https://www\.fitbit\.com/oauth2/authorize\?client_id=[A-Z1-9]{6}&redirect_uri=%
    end
    
    it '#get_fitbit_token set @fitbit_oauth_client to https://api.fitbit.com' do
      dummy_code = '1234567890abcdef'
      client = fitbit_karaage_poster.instance_variable_get(:@fitbit_oauth_client)

      allow(client.auth_code).to receive(:get_token).and_return(OAuth2::AccessToken)
      fitbit_karaage_poster.get_fitbit_token(dummy_code)

      expect(client.site).to match %r%^https://api.fitbit.com%
    end

    it '#refresh_fitbit_token set @fitbit_oauth_client to https://api.fitbit.com' do
      token = fitbit_karaage_poster.instance_variable_get(:@fitbit_token)
      client = fitbit_karaage_poster.instance_variable_get(:@fitbit_oauth_client)

      allow(token).to receive(:refresh!).and_return(OAuth2::AccessToken)
      fitbit_karaage_poster.refresh_fitbit_token

      expect(client.site).to match %r%^https://api.fitbit.com%
    end
  end
end
