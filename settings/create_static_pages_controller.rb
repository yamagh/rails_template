run "rails g controller static_pages index"
insert_into_file 'config/routes.rb', after: "Rails.application.routes.draw do\n" do
%q{
  root to: "static_pages#index"
}
end

