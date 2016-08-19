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
    set_excluded
    if session[:last_suggestion]
      session[:excluded_catgories] << session[:last_suggestion]
    end
  end

  def get_next_suggestion(user_input)
    set_excluded
    categories = CategoryManager.new.names_excluding(session[:excluded_catgories])
    classing_bot = create_class_bot(categories)
    # session[:last_suggestion] = classing_bot.classify(user_input)
    bot_response = classing_bot.classify(user_input).downcase
    session[:last_suggestion] = bot_response.gsub(/\s+/,"_")
    "Are you looking for information on #{bot_response}? Tell us 'yes' when we've got it right."

  end

  def set_excluded
    session[:excluded_catgories] = [] if !session[:excluded_catgories]
  end

  def excluded_all_categories?
    session[:excluded_catgories] = [] if !session[:excluded_catgories]
    session[:excluded_catgories].length+1 == CategoryManager.new.names_excluding([]).length
  end

  def session_timeout?
    session[:start_time] ||= Time.now
    Time.now - session[:start_time] > 60
  end

  def parse_location(text)
    full_address = text.match(/\d+.+(?=AL|AK|AS|AZ|AR|CA|CO|CT|DE|DC|FM|FL|GA|GU|HI|ID|IL|IN|IA|KS|KY|LA|ME|MH|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|MP|OH|OK|OR|PW|PA|PR|RI|SC|SD|TN|TX|UT|VT|VI|VA|WA|WV|WI|WY)[A-Z]{2}[, ]+\d{5}(?:-\d{4})?/)
    return full_address[0] if full_address && full_address[0]
    partial_address = text.match(/\d+.+\b(ave\.|avenue|st\.|street|blvd\.|boulevard|ct\.|court|dr\.|drive|ln\.|lane|rd\.|road|sq\.|square|ter\.)/i)
    return partial_address[0] if partial_address && partial_address[0]
    zip_code = text.match(/\d{5}/)
    return zip_code[0] if zip_code && zip_code[0]
  end

end


