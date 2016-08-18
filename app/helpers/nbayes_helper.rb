

helpers do

  def nbayes_learn
    nbayes = NBayes::Base.new
    # train it - notice split method used to tokenize text (more on that below)
    20.times do 
      # street address alone
      nbayes.train( Faker::Address.street_address.split(/\s+/), 'address' )
      # intersection
      nbayes.train( "#{Faker::Address.street_name} and #{Faker::Address.street_name}".split(/\s+/), 'address' )
      # street address with apt/suite number
      nbayes.train( "#{Faker::Address.street_address.split} #{Faker::Address.secondary_address}".split(/\s+/), 'address' )
    end

    nbayes
  end

  def nbayes
    @nbayes ||= nbayes_learn
  end

  # Notes on types of requests
end


# data for learning requests:
  request_types = {
  1: "Mental health",
  2: "STI",
  3: "WIC clinics",
  4: "Substance Abuse",
  5: "Public Health Primary Care - coordinates",
  6: "Senior Centers",
  7: "Condom Distribution",
  8: "Warming Centers",
  9: "Cooling Centers",
  10: "2013 Flu Shot locations"
  }

  {
    "i feel depressed" => 1,
    "i need help with depression" => 1,
    "i feel panic" => 1,
    "i'm schizophrenic" => 1,
    "i want to hurt myself" => 1,
    "" => ,
    "" => ,
    "" => ,
    "" => ,
    "" => ,
    "" => ,
    "" => ,
    "" => ,
    "" => ,
    "" => ,
    "" => ,
  }