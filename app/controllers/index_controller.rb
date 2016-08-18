get '/' do

  p classing_bot.classify("i want to hurt myself")

  erb :temp
end

get '/receive-sms' do

  body = params["Body"]
  response = classing_bot.classify(body)

  msg = "Were you looking for info on #{response}?"

  session[:response] = response

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message msg
  end
  twiml.text
end