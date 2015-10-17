source 'https://rubygems.org'

#Specify Ruby version
ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
#, '4.1.7'

# Use jdbcsqlite3 as the database for Active Record
#gem 'activerecord-jdbcsqlite3-adapter'
#gem 'activerecord'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :assets do
  gem 'coffee-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'pg', group: :production
gem 'sqlite3', group: :development


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
gem 'unicorn'

gem 'devise'

group :test do
  gem "capybara"
  gem "shoulda"

end

#Heroku requires this gem
gem 'rails_12factor', group: :production
#iCal
gem 'ri_cal'
#Mandrill
gem 'mandrill-rails'
#Validator for dates
gem 'validates_timeliness', :git =>"https://github.com/johncarney/validates_timeliness.git", :branch => "remove-deprecated-setup-method"
#tripit
gem 'tripit', :git => "git://github.com/gonfva/tripit_api.git"
