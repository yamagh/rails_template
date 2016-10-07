#remove_file "app/views/layouts/application.html.erb"
#copy_file "#{@script_dir}/assets/#{config[:theme]}/custom.css.scss",       "app/assets/stylesheets/custom.css.scss"
#copy_file "#{@script_dir}/assets/#{config[:theme]}/application.html.slim", "app/views/layouts/application.html.slim"
#copy_file "#{@script_dir}/assets/#{config[:theme]}/_header.html.slim",     "app/views/layouts/_header.html.slim"
#copy_file "#{@script_dir}/assets/#{config[:theme]}/_footer.html.slim",     "app/views/layouts/_footer.html.slim"

