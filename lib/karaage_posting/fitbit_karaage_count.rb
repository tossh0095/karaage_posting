module KaraagePosting
  class FitbitKaraagePosting
    # number of karaage you eat
    # @return [Fixnum] number of karaage you eat
    #
    attr_reader :number_of_karaage

    #
    #  How many karaage you eat that date.
    #  @params [String] the date you want to know how many karaage you eat
    #  @return [Fixnum] number of karaage
    #
    def get_karaage_count(date= Date.today.to_s)

      @number_of_karaage = 0
      response = @fitbit_token.get("/1/user/-/foods/log/date/#{date}.json" ,  {})
      food_logs = JSON.parse response.body
      @number_of_karaage = karaage_count(food_logs)
    end
    
    private 

    #
    #  count number of karaage you eat from fitbit_token response
    #  @params [Hash] json parsed response body of fitbit food logs
    #  @return [Fixnum] number of karaage


    def karaage_count(food_logs)
      food_logs["foods"].inject(0) do |k_sum,log| 
         k_sum += log["loggedFood"]["amount"] if "唐揚げ"== log["loggedFood"]["name"]
         k_sum
      end
    end
  end
end
