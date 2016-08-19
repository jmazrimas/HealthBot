

get '/sms-spoof' do

  erb :sms_spoof
end

post '/sms-spoof' do

  user_input = params["Body"]

  potential_location = parse_location(from_user)
  session[:location] = potential_location if potential_location

  if excluded_all_categories?
    @res_back = "Sorry, I don't think we can help you."
  else

  end

end
