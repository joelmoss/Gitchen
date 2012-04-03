Tire.configure do
  logger Rails.root + "log/tire_#{Rails.env}.log"
  
  if Rails.env.production?
    url "http://index.bonsai.io"
  end
end

if Rails.env.production? && ENV['BONSAI_INDEX_URL']
  BONSAI_INDEX_NAME = URI.parse(ENV['BONSAI_INDEX_URL']).path[1..-1]
else
  BONSAI_INDEX_NAME = "gitchen-#{Rails.env[0..2]}"
end