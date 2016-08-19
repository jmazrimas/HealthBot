class CategoryManager

  attr_reader :apis

  def initialize
    @names = {
    "1" => "mental_health",
    "2" => "sexually_transmitted_infections",
    "3" => "wic_clinics",
    "4" => "substance_abuse",
    "5" => "primary_care",
    "6" => "senior_centers",
    "7" => "condom_distribution",
    "8" => "warming_centers",
    "9" => "cooling_centers"
    }

    @apis = {
      "mental_health" => "https://data.cityofchicago.org/resource/t57k-za2y.json",
      "sexually_transmitted_infections" => "https://data.cityofchicago.org/resource/t57k-za2y.json",
      "wic_clinics" => "https://data.cityofchicago.org/resource/t57k-za2y.json",
      "substance_abuse" => "https://data.cityofchicago.org/resource/232q-2cqr.json",
      "primary_care" => "https://data.cityofchicago.org/resource/f8ze-n3rx.json",
      "senior_centers" => "https://data.cityofchicago.org/resource/r9g3-4ubb.json",
      "condom_distribution" => "https://data.cityofchicago.org/resource/dffv-gz9p.json",
      "warming_centers" => "https://data.cityofchicago.org/resource/6yaz-6v2j.json",
      "cooling_centers" => "https://data.cityofchicago.org/resource/r23p-6uic.json"
    }
  end

  def names_excluding(excluded)
    @names.select do |key, value|
      !excluded.include?(value)
    end
  end

end