module KaraagePosting
  class FitbitKaraagePosting

    #
    # Posting number of karaage to Karaage.click.
    #

    def posting_number_of_karaage
      agent = Mechanize.new('https://karaage.click/')
      agent.verify_mode = OpenSSL::SSL::VERIFY_NONE

      agent.get('https://karaage.click/Karaages/Create?') do |page|
        @number_of_karaage.times do
          page.forms[0].submit
        end
      end
    end
  end
end
