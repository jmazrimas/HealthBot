get '/' do
  erb :temp
end

get '/receive-sms' do

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "I'm responding to your text!"
  end
  puts twiml.text
end