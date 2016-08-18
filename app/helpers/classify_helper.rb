helpers do

  def queries
    @queries ||= CSV.read('nbayes_queries.csv', headers:true)
  end


  def create_class_bot(categories)
    classing_bot = Classifier::Bayes.new(*categories.values)
    classing_training(queries, classing_bot, categories)
  end


  def classing_training(queries, classing_bot, categories)
    queries.each do |query|
      if categories.keys.include?(query[0])
        classing_bot.send("train_#{categories[query[0]]}", query[1])
      end
    end
    classing_bot
  end

end


