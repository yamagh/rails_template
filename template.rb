require 'bundler'

# Get Application Name
@app_name = app_name

run 'git init'
run 'git add .'
run 'git commit -m "Initial commit"'

# git ignore
run 'wget --no-verbose -O .gitignore https://raw.githubusercontent.com/github/gitignore/master/Rails.gitignore'
#run 'wget --no-verbose -O .gitignore https://www.gitignore.io/api/rails'

# Gemfile Settings

append_file 'Gemfile', <<-CODE
gem 'bootstrap-sass'
gem 'slim-rails'
#gem 'twitter-bootswatch-rails'
#gem 'twitter-bootswatch-rails-helpers'
#gem 'therubyracer'
#gem 'erb2slim'
CODE

Bundler.with_clean_env do
  run 'bundle install --without production'
end

application do
  %q{
    # Timezone
    config.time_zone = 'Tokyo'
    #config.active_record.default_timezone = :local

    # Japan
    #I18n.enforce_available_locales = true
    #config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    #config.i18n.default_locale = :ja

    # Generator
    config.generators do |g|
      #g.orm :active_record
      g.template_engine :slim
      #g.test_framework  :rspec, :fixture => true
      #g.fixture_replacement :factory_girl, :dir => "spec/factories"
      #g.view_specs false
      #g.controller_specs true
      #g.routing_specs false
      #g.helper_specs false
      #g.request_specs false
      #g.assets false
      #g.helper false
    end
  }
end

# erb => slim
#Bundler.with_clean_env do
#  run 'bundle exec erb2slim -d app/views'
#end

#run 'rails g bootswatch:install lumen'
#run 'rails g bootswatch:import lumen'
#run 'rails g bootswatch:layout lumen'
#
#insert_into_file 'app/assets/stylesheets/application.css', after: " *= require_self\n" do
#  lines = <<-EOS
#   *= require lumen/lodader
#   *= require lumen/bootswatch
#  EOS
#end
#
#insert_into_file 'app/assets/javascripts/application.js', before: "//= require turbolinks" do
#  lines = <<-EOS
#  //= require lumen/loader
#  //= require lumen/bootswatch
#  EOS
#end
#
#insert_into_file 'config/initializers/assets.rb', after: "Rails.application.config.assets.version = '1.0'" do
#  lines = <<-EOS
#  Rails.application.config.assets.precompile += %w( lumen.css )
#  Rails.application.config.assets.precompile += %w( lumen.js )
#  EOS
#end

run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.css.scss'

append_file 'app/assets/stylesheets/application.css.scss', <<-CODE
@import "bootstrap-sprockets";
@import "bootstrap";
body { padding-top: 60px; }
CODE

insert_into_file 'app/assets/javascripts/application.js', before: '//= require_tree .\n' do
'//= require bootstrap-sprockets'
end

run 'git add .'
run 'git commit -m "Applied Rails Template"'

