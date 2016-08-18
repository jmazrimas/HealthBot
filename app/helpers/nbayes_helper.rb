

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

  end

end