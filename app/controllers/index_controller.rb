get '/' do

  erb :temp
end

get '/sms-spoof' do

  erb :sms_spoof
end

post '/sms-spoof' do

  if session_timeout?
    session.clear
  end

  from_user = params["message"]

  potential_location = parse_location(from_user)

  if potential_location
    session[:potential_location] = potential_location
  end

  if session[:confirmed_category]
    if session[:potential_location]
      if from_user.downcase == "yes"
        session[:confirmed_location] = session[:potential_location]
      elsif from_user.downcase == "no"
        @res_back = "OK, could you please provide another type of address to search?"
      else
        @res_back = "You're looking for help with #{session[:confirmed_category]} at #{session[:potential_location]}."
      end
    else
      @res_back = "Couldn't understand that. What is your address or zip code?"
    end
  else
    if excluded_all_categories?
      @res_back = "Sorry, I don't think we can help you :("
    elsif from_user.downcase == "yes" && session[:last_suggestion]
      confirm_category
      session[:last_suggestion] = nil
      @res_back = "Great! We'll get you some info about #{session[:confirmed_category].gsub("_"," ")}. "
      @res_back += (session[:potential_location] != nil ? "Is your location #{session[:potential_location]}?" : "What is your location?")
    elsif from_user.downcase == "no" && session[:last_suggestion]
      exclude_category
      @res_back = get_next_suggestion(from_user)
    else
      @res_back = get_next_suggestion(from_user)
    end
  end

  if session[:confirmed_category] && session[:confirmed_location]
    @res_back = "we're saved!!!!!!"
  end

  erb :sms_spoof
end

get '/receive-sms' do

  if session_timeout?
    session.clear
  end

  from_user = params["Body"]

  potential_location = parse_location(from_user)

  if potential_location
    session[:potential_location] = potential_location
  end

  if session[:confirmed_category]
    if session[:potential_location]
      if from_user.downcase == "yes"
        session[:confirmed_location] = session[:potential_location]
      elsif from_user.downcase == "no"
        @res_back = "OK, could you please provide another type of address to search?"
      else
        @res_back = "You're looking for help with #{session[:confirmed_category]} at #{session[:potential_location]}."
      end
    else
      @res_back = "Couldn't understand that. What is your address or zip code?"
    end
  else
    if excluded_all_categories?
      @res_back = "Sorry, I don't think we can help you :("
    elsif from_user.downcase == "yes" && session[:last_suggestion]
      confirm_category
      session[:last_suggestion] = nil
      @res_back = "Great! We'll get you some info about #{session[:confirmed_category].gsub("_"," ")}. "
      @res_back += (session[:potential_location] != nil ? "Is your location #{session[:potential_location]}?" : "What is your location?")
    elsif from_user.downcase == "no" && session[:last_suggestion]
      exclude_category
      @res_back = get_next_suggestion(from_user)
    else
      @res_back = get_next_suggestion(from_user)
    end
  end

  if session[:confirmed_category] && session[:confirmed_location]
    res_back = response_options(session[:confirmed_category],session[:confirmed_location])
    @res_back = "You're out of luck."
    @res_back = res_back[0] if res_back.length > 0
  end

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message @res_back
  end
  twiml.text
end

get '/clear-session' do
  session.each { |k,v| session[k] = nil }
  redirect '/sms-spoof'
end

# needs to call pub_health method, receive a string with the place and the address which it returns to the user