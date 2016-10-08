gem 'slim-rails'
gem 'therubyracer'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
#gem 'less-rails'
#gem 'bootstrap-sass'
#gem 'simple_form'
gem 'devise'

Bundler.with_clean_env do
  run 'bundle install --quiet --without production'
end

