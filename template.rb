require 'bundler'

@script_dir = File.expand_path(File.dirname(__FILE__))

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

# CSS Settings for Bootstrap

run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.css.scss'

#append_file 'app/assets/stylesheets/application.css.scss', <<-CODE
#@import "bootstrap-sprockets";
#@import "bootstrap";
#CODE

insert_into_file 'app/assets/javascripts/application.js', before: '//= require_tree .\n' do
'//= require bootstrap-sprockets'
end

# Custom CSS

copy_file @script_dir+'/assets/custom.css.scss', 'app/assets/stylesheets/custom.css.scss'

# Repace application.html

remove_file 'app/views/layouts/application.html.erb'
create_file 'app/views/layouts/application.html.slim' do
%q{
doctype html
html
  head
    title @app_name
    = csrf_meta_tags

    = stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload'
    = javascript_include_tag 'application', 'data-turbolinks-track': 'reload'

  body
    = render 'layouts/header'
    .container
      = yield
    = render 'layouts/footer'
}
end

# Add Navigation Bar

create_file 'app/views/layouts/_header.html.slim' do
%q{
header.navbar.navbar-fixed-top.navbar-inverse
  .container
    = link_to "@app_name", '#', id: "logo"
    nav
      ul.nav.navbar-nav.navbar-right
        li = link_to "Home",   '#'
        li = link_to "Help",   '#'
        li = link_to "Log in", '#'
}
end

# Add Header

# Add Footer

create_file 'app/views/layouts/_footer.html.slim' do
%q{
footer.footer
  small
    a> href="#" Link
  nav
    ul
      li = link_to "About", '#'
}
end

# Add User SignUp/Login Page

# Add Static Pages Controller

#run 'rails g controller static_pages'

run 'git add .'
run 'git commit -m "Applied Rails Template"'

