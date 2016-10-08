require 'bundler'

@script_dir = File.expand_path(File.dirname(__FILE__))
@app_name = app_name

apply "#@script_dir/settings/gemfile.rb"
apply "#@script_dir/settings/config_application.rb"
apply "#@script_dir/settings/twitter-bootstrap-rails.rb"
apply "#@script_dir/settings/devise.rb"
apply "#@script_dir/settings/create_static_pages_controller.rb"
#apply "#@script_dir/settings/theme_simple_white.rb", theme:'simple_white'
apply "#@script_dir/settings/git.rb"

#run 'rails g scaffold Task title descripton'
#rake 'db:migrate'
#run 'rails g bootstrap:layout tasks --force'
#run 'rails g bootstrap:themed tasks --force'

