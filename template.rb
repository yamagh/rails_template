require 'bundler'

@script_dir = File.expand_path(File.dirname(__FILE__))

# Get Application Name
@app_name = app_name

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

# Application Settings

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
      g.stylesheets false
      g.javascripts false
      g.helper      false
    end
  }
end

# erb => slim
#Bundler.with_clean_env do
#  run 'bundle exec erb2slim -d app/views'
#end

# CSS Settings for Bootstrap

run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.css.scss'

#append_file 'app/assets/stylesheets/application.css.scss', <<-CODE
#@import "bootstrap-sprockets";
#@import "bootstrap";
#CODE

insert_into_file 'app/assets/javascripts/application.js', before: '//= require_tree .\n' do
'//= require bootstrap-sprockets'
end

# Theme 01

remove_file 'app/views/layouts/application.html.erb'
copy_file @script_dir+'/assets/01/custom.css.scss',       'app/assets/stylesheets/custom.css.scss'
copy_file @script_dir+'/assets/01/application.html.slim', 'app/views/layouts/application.html.slim'
copy_file @script_dir+'/assets/01/_header.html.slim',     'app/views/layouts/_header.html.slim'
copy_file @script_dir+'/assets/01/_footer.html.slim',     'app/views/layouts/_footer.html.slim'

# Theme 02

#remove_file 'app/views/layouts/application.html.erb'
#copy_file @script_dir+'/assets/02/custom.css.scss',       'app/assets/stylesheets/custom.css.scss'
#copy_file @script_dir+'/assets/02/application.html.slim', 'app/views/layouts/application.html.slim'
#copy_file @script_dir+'/assets/02/_header.html.slim',     'app/views/layouts/_header.html.slim'
#copy_file @script_dir+'/assets/02/_footer.html.slim',     'app/views/layouts/_footer.html.slim'

# Add User SignUp/Login Page

# Add Static Pages Controller

# Add Home View

#run 'rails g controller static_pages'

# Git

run 'git init'
run 'git add .'
run 'git commit -m "Initial commit"'

# .gitignore
run 'wget --no-verbose -O .gitignore https://raw.githubusercontent.com/github/gitignore/master/Rails.gitignore'
#run 'wget --no-verbose -O .gitignore https://www.gitignore.io/api/rails'


run 'rails g scaffold User name email'
run 'rake db:migrate'

