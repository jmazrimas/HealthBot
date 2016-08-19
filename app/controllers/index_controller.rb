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
    if from_user.downcase == "yes"
      confirm_category
      session[:last_suggestion] = nil
      @res_back = "Great! We'll get you some info about #{session[:confirmed_category].gsub("_"," ")}. What is your location?"
    elsif from_user.downcase == "no"
      # categories = CategoryManager.new.names_excluding(session[:excluded_catgories])
      # classing_bot = create_class_bot(categories)
      # bot_category = classing_bot.classify(from_user)
      bot_category = get_next_suggestion(from_user).downcase
      session[:last_suggestion] = bot_category.gsub(/\s+/,"_")
      @res_back = "Are you looking for information on #{bot_category}? Tell us 'yes' when we've got it right."
    else
      # categories = CategoryManager.new.names_excluding([])
      # classing_bot = create_class_bot(categories)
      # bot_category = classing_bot.classify(from_user)
      bot_category = get_next_suggestion(from_user).downcase
      session[:last_suggestion] = bot_category.gsub(/\s+/,"_")
      # session[:last_suggestion] = bot_category
      @res_back = "Are you looking for information on #{bot_category}? Tell us 'yes' when we've got it right."
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