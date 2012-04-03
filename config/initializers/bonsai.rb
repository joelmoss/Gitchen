Tire.configure do
  logger Rails.root + "log/tire_#{Rails.env}.log"
  
  if Rails.env.production?
    url "http://index.bonsai.io"
  end
end

if Rails.env.production?
  BONSAI_INDEX_NAME = URL(ENV['BONSAI_INDEX_URL']).path[1..-1]
end