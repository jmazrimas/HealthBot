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