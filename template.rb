require 'bundler'

# =============================================================================
#  Gemfile Settings

  #gem 'simple_form'
  gem 'slim-rails'
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
  gem 'devise'
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-livereload'
  gem 'terminal-notifier-guard'
  gem 'minitest-reporters'
#  gem 'minitest-rails'
#  gem 'minitest-rails-capybara'

  Bundler.with_clean_env do
    run 'bundle install --quiet --without production'
  end

# =============================================================================
#  Application Settings

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
        #g.view_specs       false
        #g.controller_specs true
        #g.routing_specs    false
        #g.helper_specs     false
        #g.request_specs    false
        #g.assets           false
        #g.helper           false
        g.stylesheets      false
        g.javascripts      false
        g.helper           false
      end
    }
  end

# =============================================================================
#  Gem Settings - simple_form

  #run 'rails generate simple_form:install'
  #run 'rails generate simple_form:install --bootstrap'

# =============================================================================
#  Gem Settings - twitter-bootstrap-rails

  run 'rails generate bootstrap:install static      --force'
  run 'rails generate bootstrap:layout  application --force'
  remove_file 'app/views/layouts/application.html.erb'

# =============================================================================
#  Gem Settings - devise

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
  
  run 'rails g devise:install'
  run 'rails g devise:views'
  run 'rails g devise user'
  run 'rails db:migrate'
  
  create_file 'app/views/layouts/_sign_in.slim', <<~FILE
    - if user_signed_in?
      li= link_to "設定", edit_user_registration_path, :class => "navbar-link"
      li= link_to "ログアウト", destroy_user_session_path, method: :delete, :class => "navbar-link"
    - else
      li= link_to "ユーザ登録", new_user_registration_path, :class => 'navbar-link'
      li= link_to "ログイン", new_user_session_path, :class => 'navbar-link'
  FILE

  insert_into_file "app/views/layouts/application.html.slim", after: "li= link_to \"Link 3\", \"/path3\"" do
  %q{
              = render partial: "layouts/sign_in"
  }
  end

# =============================================================================
#  Gem Settings - guard-minitest

  run 'guard init minitest'
  append_to_file 'Guardfile', <<~FILE
    guard :minitest, spring: "bin/rails test" do
      watch(%r{^test/(.*)\/?(.*)_test\.rb$})
    end
  FILE

# =============================================================================
#  Gem Settings - minitest-reporters

  insert_into_file "test/test_helper.rb", after: "require 'rails/test_help'" do
    <<~FILE
      
      require "minitest/reporters"
      Minitest::Reporters.use!
    FILE
  end

# =============================================================================
#  Gem Settings - minitest-rails-capybara

#  insert_into_file "test/test_helper.rb", after: "require 'rails/test_help'" do
#    <<~FILE
#      
#      require "minitest/rails/capybara"
#    FILE
#  end

# =============================================================================
#  Gem Settings - guard-livereload

  run 'guard init livereload'

# =============================================================================
#  Git Settings

# .gitignore

  run 'wget --no-verbose -O .gitignore https://raw.githubusercontent.com/github/gitignore/master/Rails.gitignore'
  #run 'wget --no-verbose -O .gitignore https://www.gitignore.io/api/rails'

# Git Initialize

  after_bundle do
    git :init
    git add: '.'
    git commit: "-a -m 'Initial commit'"
  end

