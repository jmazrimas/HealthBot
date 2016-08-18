get '/' do

  erb :temp
end

get '/receive-sms' do

  body = params["Body"]

  response = classing_bot.classify(body)
  # see if what was sent initially has an address
  # if not ask, and keep asking until you get a positive response

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "Were you looking for info on #{response}?"
  end
  twiml.text
end