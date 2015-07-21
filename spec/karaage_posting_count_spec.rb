require 'spec_helper'

describe 'karaage fitbit count spec' do
  let(:fitbit_karaage_poster) {KaraagePosting::FitbitKaraagePosting.new}
  
  describe 'count karaage' do
    test_data_for_no_foodlog = {"foods"=>[],
                                "summary"=>
                                {"calories"=>0,
                                 "carbs"=>0,
                                 "fat"=>0,
                                 "fiber"=>0,
                                 "protein"=>0,
                                 "sodium"=>0,
                                 "water"=>0}}
 test_data_eat_karaage = {"foods"=>
                         [{"isFavorite"=>false,
                             "logDate"=>"2015-07-20",
                             "logId"=>2971560737,
                             "loggedFood"=>
                              {"accessLevel"=>"PRIVATE",
                                    "amount"=>6,
                                    "brand"=>"",
                                    "calories"=>426,
                                    "creatorEncodedId"=>"3HMVL2",
                                    "foodId"=>541730106,
                                    "mealTypeId"=>1,
                                    "name"=>"唐揚げ",
                                    "unit"=>{"id"=>4, "name"=>"個", "plural"=>"個"},
                                    "units"=>[4]},
                             "nutritionalValues"=>
                              {"calories"=>426,
                                    "carbs"=>0,
                                    "fat"=>0,
                                    "fiber"=>0,
                                    "protein"=>0,
                                    "sodium"=>0}},
                            {"isFavorite"=>false,
                                  "logDate"=>"2015-07-20",
                                  "logId"=>2972421716,
                                  "loggedFood"=>
                                   {"accessLevel"=>"PRIVATE",
                                         "amount"=>6,
                                         "brand"=>"",
                                         "calories"=>426,
                                         "creatorEncodedId"=>"3HMVL2",
                                         "foodId"=>541730106,
                                         "mealTypeId"=>3,
                                         "name"=>"唐揚げ",
                                         "unit"=>{"id"=>4, "name"=>"個", "plural"=>"個"},
                                         "units"=>[4]},
                                  "nutritionalValues"=>
                                   {"calories"=>426,
                                         "carbs"=>0,
                                         "fat"=>0,
                                         "fiber"=>0,
                                         "protein"=>0,
                                        }}]}

    it '#karaage_count(private method) for no foodlog' do
      expect(fitbit_karaage_poster.send(:karaage_count, test_data_for_no_foodlog)).to eq 0
    end
    
    it '#karaage_count(private method) for 16' do
      expect(fitbit_karaage_poster.send(:karaage_count, test_data_eat_karaage)).to eq 12
    end
  end

end
