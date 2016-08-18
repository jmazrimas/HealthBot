

helpers do

  def nbayes_learn
    nbayes = NBayes::Base.new
    # train it - notice split method used to tokenize text (more on that below)
    200.times do 
      # street address alone
      nbayes.train( Faker::Address.street_address.split(/\s+/), 'address' )
      # intersection
      nbayes.train( "#{Faker::Address.street_name} and #{Faker::Address.street_name}".split(/\s+/), 'address' )
      # street address with apt/suite number
      nbayes.train( "#{Faker::Address.street_address.split} #{Faker::Address.secondary_address}".split(/\s+/), 'address' )
    end

    # Types of requests
    request_types = {
      1 => "Mental health",
      2 => "STI",
      3 => "WIC clinics",
      4 => "Substance Abuse",
      5 => "Public Health Primary Care - coordinates",
      6 => "Senior Centers",
      7 => "Condom Distribution",
      8 => "Warming Centers",
      9 => "Cooling Centers",
      10 => "2013 Flu Shot locations"
    }

    queries = CSV.read('nbayes_queries.csv', {:headers => true})

    queries.each do |query|
      nbayes.train( query[1].split(/\s+/), request_types[query[0].to_i] )
    end

    nbayes
  end

  def nbayes
    @nbayes ||= nbayes_learn
  end



  # def nbayes_learn_request_types

  #   queries = CSV.read('nbayes_queries.csv', {:headers => true})

  #   queries.each do |query|
  #     nbayes.train( query[1].split(/\s+/), 'request' )
  #   end

  # end

end


