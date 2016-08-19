get '/' do
  categories = CategoryManager.new.names_excluding([])

  classing_bot = create_class_bot(categories)

  p classing_bot.classify("i want to hurt myself")

  erb :temp
end

get '/sms-spoof' do

  erb :sms_spoof
end

post '/sms-spoof' do

  from_user = params["message"]

  if !session[:confirmed_category]
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
  else
  end

  erb :sms_spoof
end

get '/receive-sms' do

  # exclude = (session[:exclude_categories] ? session[:exclude_categories] : [])

  categories = CategoryManager.new.names_excluding([])
  classing_bot = create_class_bot(categories)
  classing_bot.classify(body)

  body = params["Body"]
  response = classing_bot.classify(body)
  msg = "Were you looking for info on #{response}?"


  twiml = Twilio::TwiML::Response.new do |r|
    r.Message msg
  end
  twiml.text
end

# needs to call pub_health method, receive a string with the place and the address which it returns to the user