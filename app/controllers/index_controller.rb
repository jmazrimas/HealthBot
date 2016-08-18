get '/' do

  erb :temp
end

get '/receive-sms' do

  body = params["Body"]

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "I'm responding to your text that said \"#{body}\""
  end
  twiml.text
end

# needs to call pub_health method, receive a string with the place and the address which it returns to the user