source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.2'

gem 'bootsnap', '>= 1.1.0', require: false # Boot large ruby/rails apps faster
gem 'devise' # Flexible authentication solution for Rails with Warden
gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'mysql2', '>= 0.4.4', '< 0.6.0' # Use mysql as the database for Active Record
gem 'puma', '~> 3.11' # Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications. Puma is intended for use in both development and production environments. It's great for highly concurrent Ruby implementations such as Rubinius and JRuby as well as as providing process worker support to support CRuby well.
gem 'rails', '~> 5.2.2' # Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration.

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Byebug is a Ruby debugger. It's implemented using the TracePoint C API for execution control and the Debug Inspector C API for call stack navigation.  The core component provides support that front-ends can build on. It provides breakpoint handling and bindings for stack frames among other things and it comes with an easy to use command line interface.
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2' # The Listen gem listens to file modifications and notifies you about the changes. Works everywhere!
  gem 'spring' # Preloads your application so things like console, rake and tests run faster
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
end

group :test do
  gem 'capybara', '>= 2.15' # Capybara is an integration testing tool for rack based web applications. It simulates how a user would interact with a website
  gem 'chromedriver-helper' # Easy installation and use of chromedriver, the Chromium project's selenium webdriver adapter.
  gem 'faker' # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
  gem 'selenium-webdriver' # WebDriver is a tool for writing automated tests of websites. It aims to mimic the behaviour of a real user, and as such interacts with the HTML of the application.
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
