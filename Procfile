web:    bundle exec rails server thin start -p $PORT -e $RACK_ENV
worker: bundle exec sidekiq -e $RACK_ENV -c 1