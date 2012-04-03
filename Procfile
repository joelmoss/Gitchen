web: bundle exec rails server thin -p $PORT -e $RACK_ENV
worker: bundle exec sidekiq -e $RACK_ENV -c 1