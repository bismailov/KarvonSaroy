# Edited on 21 Jun 2013, bismailov@gmail.com                                                                                              # Added gem file versions,
# similar to Hartl style.
# seach for 'The final Gemfile for the sample application'


# source 'https://rubygems.org'
source 'http://rubygems.org'

gem 'rails', '3.2.13'
gem 'pg', '0.15.1'
gem 'jquery-rails', '3.0.1'
gem 'bcrypt-ruby', '3.0.1'
gem 'bootstrap-sass', '2.3.2.0'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'

gem 'bootstrap-wysihtml5-rails', '0.3.1.23'
gem 'jwplayer-rails', '1.0.1'
gem 'paperclip', '3.5.1'
gem "irwi", "0.4.2"
# gem "cyrillizer", "0.1.0"
gem "cyrillizer", git: "git://github.com/bismailov/cyrillizer.git"

gem 'faker', '1.1.2'

# http://rubygems.org/gems/slim
# as an alternative to ERB
gem 'slim', '2.0.0'

#from Zombie School 2 video number 4
#for mass mailing list and etc
#gem madmimi 

group :development do
  gem "letter_opener", "1.2.0"
  gem "better_errors", "1.1.0"
  gem "bullet", "4.7.1"
end

group :test, :development do
  gem 'rspec-rails', '2.13.2'
  #gem 'guard-rspec', '2.5.2' #test automation
  #gem 'guard-spork', '1.5.0'
  #gem 'spork', '0.9.2' #test speed-up
end

gem 'annotate', '2.5.0', group: :development

group :test do
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
  #gem 'cucumber-rails', '1.3.1', require: false
  gem 'database_cleaner', '1.0.1'
end

group :production do
  gem 'rails_12factor'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end



# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
