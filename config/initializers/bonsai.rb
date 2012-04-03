if Rails.env.production?
  Tire.configuration.url = "http://index.bonsai.io"
  BONSAI_INDEX_NAME = URI.parse(ENV['BONSAI_INDEX_URL']).path[1..-1]
end

Tire.configure do
  logger Rails.root + "log/tire_#{Rails.env}.log"
end