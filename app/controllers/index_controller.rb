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
      @res_back = "You're looking for help with #{session[:confirmed_category]} at #{session[:potential_location]}."
      p response_options(session[:confirmed_category], session[:potential_location])
    else
      @res_back = "Couldn't understand that. What is your address or zip code?"
    end
  else
    if excluded_all_categories?
      @res_back = "Sorry, I don't think we can help you :("
    elsif from_user.downcase == "yes"
      confirm_category
      session[:last_suggestion] = nil
      @res_back = "Great! We'll get you some info about #{session[:confirmed_category].gsub("_"," ")}. What is your location?"
    elsif from_user.downcase == "no"
      exclude_category
      @res_back = get_next_suggestion(from_user)
    else
      @res_back = get_next_suggestion(from_user)
    end
  end

  erb :sms_spoof
end

get '/receive-sms' do

  from_user = params["Body"]

  potential_location = parse_location(from_user)

  if potential_location
    session[:potential_location] = potential_location
  end

  if session[:confirmed_category]
    if session[:potential_location]
      @res_back = "You're looking for help with #{session[:confirmed_category]} at #{session[:potential_location]}."
      p response_options(session[:confirmed_category], session[:potential_location])
    else
      @res_back = "Couldn't understand that. What is your address or zip code?"
    end
  else
    if excluded_all_categories?
      @res_back = "Sorry, I don't think we can help you :("
    elsif from_user.downcase == "yes"
      confirm_category
      session[:last_suggestion] = nil
      @res_back = "Great! We'll get you some info about #{session[:confirmed_category].gsub("_"," ")}. What is your location?"
    elsif from_user.downcase == "no"
      exclude_category
      @res_back = get_next_suggestion(from_user)
    else
      @res_back = get_next_suggestion(from_user)
    end
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
