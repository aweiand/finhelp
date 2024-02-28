source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.0'

# Para usar .env
# https://github.com/bkeepers/dotenv
gem 'dotenv-rails', require: 'dotenv/rails-now'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.6.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
gem 'sassc-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem "mini_racer"#, "~>0.4.0"

# Esta gem sempre me causa problemas, agora fixando ela aparentemente os problemas sumiram
gem "nokogiri", "~>1.13.8"

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen'

  gem 'better_errors'
  gem 'binding_of_caller'

  # Use Capistrano for deployment
  gem "capistrano-rails"
end

# ADD TRANSPILER TO USE ES6
gem 'sprockets'
gem 'sprockets-es6'
gem "sprockets-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# https://github.com/twbs/bootstrap-sass
gem 'bootstrap-sass', '~> 3.2'

# DOC: https://github.com/maxim/bootswatch-rails
# Styles: https://bootswatch.com/paper/
gem "bootswatch-rails"

# https://github.com/bokmann/font-awesome-rails
gem "font-awesome-rails"

# JavaScript Rails Routes
# https://github.com/railsware/js-routes
gem "js-routes", '1.4.9'

gem "jquery-rails"
gem "jquery-ui-rails"

# Para validar o CPF no model
# https://github.com/rfs/validates_cpf_cnpj
gem 'validates_cpf_cnpj'

# Paginate
# https://github.com/mislav/will_paginate
gem 'will_paginate'

gem 'rubyzip', '~> 1.1.0'
gem 'axlsx', '2.1.0.pre'
gem 'axlsx_rails'
