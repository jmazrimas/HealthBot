get '/' do
  categories = CategoryManager.new.names_excluding([])

  classing_bot = create_class_bot(categories)

  p classing_bot.classify("i want to hurt myself")

  erb :temp
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