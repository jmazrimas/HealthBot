get '/' do

  tokens = "suicide".split(/\s+/)
  # tokens = "I need help".split(/\s+/)
  
  result = nbayes.classify(tokens)

  p result.max_class
  p result[result.max_class]
  p result

  erb :temp
end

get '/receive-sms' do

  body = params["Body"]

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "I'm responding to your text that said \"#{body}\""
  end
  twiml.text
end