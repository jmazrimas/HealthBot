get '/' do

  erb :temp
end

get '/receive-sms' do

  body = params["Body"]
  response = classing_bot.classify(body)

  session[:response] = response

  p session[:response] if session[:response]

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "Were you looking for info on #{response}?"
  end
  twiml.text
end