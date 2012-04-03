Tire.configure do
  logger Rails.root + "log/tire_#{Rails.env}.log"
  
  if Rails.env.production?
    url "http://index.bonsai.io"
    BONSAI_INDEX_NAME = URI.parse(ENV['BONSAI_INDEX_URL']).path[1..-1]
  end
end