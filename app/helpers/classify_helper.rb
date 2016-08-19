helpers do


  # LOGIC FOR 'TRAINING' THE CATEGORY BOT
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
  # LOGIC FOR 'TRAINING' THE CATEGORY BOT

  def confirm_category
    session[:confirmed_category] = session[:last_suggestion]
  end

  def exclude_category
    session[:excluded_catgories] = [] if !session[:excluded_catgories]
    if session[:last_suggestion]
      p "exclude session_last: #{session[:last_suggestion]}"
      session[:excluded_catgories] << session[:last_suggestion]
      p "exclude excluded: #{session[:excluded_catgories]}"
    end
  end

  def get_next_suggestion(user_input)
    exclude_category
    categories = CategoryManager.new.names_excluding(session[:excluded_catgories])
    classing_bot = create_class_bot(categories)
    p "class bot says #{classing_bot.classify(user_input)}"
    session[:last_suggestion] = classing_bot.classify(user_input)
  end


end


