module KaraagePosting
  class CLI < Thor
    default_command :counting

    desc 'posting YYYY-MM-DD', 'Posting number of karaage you eat at YYYY-MM-DD.'
    def posting(date=Date.today.to_s)
      karaage_poster = KaraagePosting::FitbitKaraagePosting.new

      authorize_url = karaage_poster.get_fitbit_authorize_uri

      puts '#################################'
      puts '#################################'
      puts "Yes, My life is Karaage eating..."
      puts '#################################'
      puts '#################################'
      puts ''

      #get Mechanize instance for OAuth login Automation

      agent = Mechanize.new

      #get fitbit login page

      page = agent.get(authorize_url)

      form = page.form_with('login')
      
      #get login email form the console
      print "Enter your fitbit email address: "

      email = $stdin.gets.chomp

      #get login password from the console
      print "Enter your fitbit password: "
      system 'stty -echo'
      password = $stdin.gets.chomp
      system 'stty echo'
      puts ""

      #set agent to login fitbit
      form.field_with(name: 'email').value = email
      form.field_with(name: 'password').value = password

      authed_page = form.click_button

      #after login, authed_page has two pattern.
      #1) you already have get a token
      #2) you have never get a token

      if %r%^#{ENV['FITBIT_REDIRECT_URL']}% =~ authed_page.uri.to_s then
        # A token has been already gotten
        redirect_page = authed_page
      else
        # A token has not been gotten
        redirect_page = authed_page.form.click_button(authed_page.form.button_with(value: 'Allow')) 
      end

      #parse authentication code query form rediret_page
      code = redirect_page.uri.query.split('=')[1]

      karaage_poster.get_fitbit_token(code)

      puts ''
      puts "/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_"
      puts "Date #{date}: number of karaage you eat!: #{karaage_poster.get_karaage_count(date)}"
      puts "/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_"
      puts ''

      puts "Posting https://karaage.click....."

      karaage_poster.posting_number_of_karaage
      
      puts "done!"

    end
    
  end
end
