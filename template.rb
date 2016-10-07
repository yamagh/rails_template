require 'bundler'

@script_dir = File.expand_path(File.dirname(__FILE__))
@app_name = app_name

apply "#@script_dir/applies/gem_settings.rb"
apply "#@script_dir/applies/application_config.rb"
apply "#@script_dir/applies/settings_for_bootstrap_gem.rb"
apply "#@script_dir/applies/theme_simple_white.rb", theme:'simple_white'

# Add User SignUp/Login Page

# Add Static Pages Controller

# Add Home View

#run 'rails g controller static_pages'


apply "#@script_dir/applies/git_settings.rb"


#run 'rails g simple_form:install'
#run 'rails g simple_form:install --bootstrap'
run 'rails g scaffold User name email'
rake 'db:migrate'
run 'rails g bootstrap:layout users --force'
run 'rails g bootstrap:themed users --force'

