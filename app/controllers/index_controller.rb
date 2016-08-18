get '/' do
  # tokenize message
  # tokens = "2140 W Potomac Ave #3".split(/\s+/)
  # tokens = "I need help".split(/\s+/)
  # result = nbayes.classify(tokens)
  # print likely class (SPAM or HAM)
  # p result.max_class
  # p result["address"]

  erb :temp
end

get '/receive-sms' do

  body = params["Body"]

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "I'm responding to your text that said \"#{body}\""
  end
  twiml.text
end