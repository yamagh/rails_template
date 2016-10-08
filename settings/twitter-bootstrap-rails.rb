# CSS Settings for Bootstrap

#run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.css.scss'

#append_file 'app/assets/stylesheets/application.css.scss', <<-CODE
#@import "bootstrap-sprockets";
#@import "bootstrap";
#CODE

#insert_into_file 'app/assets/javascripts/application.js', before: '//= require_tree .\n' do
#'//= require bootstrap-sprockets'
#end

run 'rails generate bootstrap:install static      --force'
run 'rails generate bootstrap:layout  application --force'

remove_file "app/views/layouts/application.html.erb"

