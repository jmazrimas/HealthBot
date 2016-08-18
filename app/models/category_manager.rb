class CategoryManager

  def initialize
    @names = {
    "1" => "mental_health", 
    "2" => "sti", 
    "3" => "wic_clinics", 
    "4" => "substance_abuse", 
    "5" => "primary_care", 
    "6" => "senior_centers", 
    "7" => "condom_distribution", 
    "8" => "warming_centers", 
    "9" => "cooling_centers"
    }
  end

  def names_excluding(excluded)
    @names.select do |key, value|
      !excluded.include?(value)
    end
  end

end