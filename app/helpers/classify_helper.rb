

helpers do

  def classing_training(query, classing_bot)

    case query[0].to_i
    when 1
      classing_bot.train_mental_health(query[1])
    when 2
      classing_bot.train_sti(query[1])
    when 3
      classing_bot.train_wic_clinics(query[1])
    when 4
      classing_bot.train_substance_abuse(query[1])
    when 5
      classing_bot.train_primary_care(query[1])
    when 6
      classing_bot.train_senior_centers(query[1])
    when 7
      classing_bot.train_condom_distribution(query[1])
    when 8
      classing_bot.train_warming_centers(query[1])
    when 9
      classing_bot.train_cooling_centers(query[1])
    end

    classing_bot
  end

  def classifier_learn

    classing_bot = Classifier::Bayes.new "mental_health", "sti", "wic_clinics", "substance_abuse", "primary_care", "senior_centers", "condom_distribution", "warming_centers", "cooling_centers"

    queries = CSV.read('nbayes_queries.csv', headers:true)

    queries.each do |row|
      classing_training(row, classing_bot)
    end

    classing_bot
  end


  def classing_bot
    @classing_bot ||= classifier_learn
  end

end


