run 'rails g devise:install'

insert_into_file 'config/environments/development.rb', after: "do\n" do
%q{
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address        => 'smtp.gmail.com',
    :port           => 587,
    :authentication => :plain,
    :user_name      => 'メールアドレス',
    :password       => 'パスワード'
  }
}
end

run 'rails g devise user'
run 'rake db:migrate'

copy_file "#@script_dir/assets/_sign_in.slim", "app/views/layouts/_sign_in.slim"
insert_into_file "app/views/layouts/application.html.slim", after: "li= link_to \"Link 3\", \"/path3\"" do
%q{
              = render partial: "layouts/sign_in"
}
end

