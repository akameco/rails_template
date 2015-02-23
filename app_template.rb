txt = <<-TXT
             ＿
        〃:::::::｀ヽ
       |ｉ::iノ}八ﾊ
       |i:(|.ﾟ -ﾟﾉi|
       |i:ﾘ)づとﾘ >> Rails Application Templates
         く/_j｣>
           し'ﾉ
TXT
puts txt

# アプリ名の取得
@app_name = app_name

# README.rdoc -> README.md
run 'rm README.rdoc'
run 'touch README.md'

# gitignore
run 'gibo Ruby Vim JetBrains Linux > .gitignore'
run 'echo .envrc >> .gitignore'

# gem
comment_lines 'Gemfile', "gem 'sqlite3'"

# slim
gem 'slim-rails'

# server
gem 'puma'
gem 'foreman'

# bootstrap
gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'font-awesome-rails'

gem_group :development, :test do
  gem 'sqlite3'
  # rspec
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'capybara'
  gem 'shoulda-matchers', require: false

  # guard
  gem 'guard-rspec', require: false

  # pry
  gem 'pry-rails'
  gem 'awesome_print'

  # PryでのSQLの結果を綺麗に表示
  gem 'hirb'
  gem 'hirb-unicode'
end

gem_group :development do
  gem 'html2slim'
  # N+1問題の検出
  gem 'bullet'
end

gem_group :test do
  # test fixture
  gem 'factory_girl_rails'
end

gem_group :production do
  gem 'rails_12factor'
  gem 'pg'
end

# bundle install
run 'bundle install --without production'

# direnv
run "echo 'export PATH=$PWD/bin:$PATH' > .envrc"
run 'direnv allow .'

# rspec
run 'rails g rspec:install'
# run "echo '--color --require rails_helper' > .rspec"

# spring
run 'spring binstub --all'
# run 'spring binstub rspec'
run 'spring status'

# guard
run 'guard init'

# erb => slim
run 'bundle exec erb2slim -d app/views'

# Bootstrap/Bootswach/Font-Awesome
run 'rm -rf app/assets/stylesheets/application.css'
run 'wget https://raw.githubusercontent.com/akameco/rails_template/master/app/assets/stylesheets/application.scss -P app/assets/stylesheets/'

# foreman
run "echo 'web: bundle exec puma -t ${PUMA_MIN_THREADS:-8}:${PUMA_MAX_THREADS:-12} -w ${PUMA_WORKERS:-2} -p $PORT -e ${RACK_ENV:-development}' > Procfile"

# set Japanese locale
run 'wget https://raw.github.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml -P config/locales/'

# set pryrc
run 'wget https://raw.githubusercontent.com/akameco/rails_template/master/.pryrc'

# factory_girl
insert_into_file 'spec/rails_helper.rb', %(
  config.before :all do
    FactoryGirl.reload
    FactoryGirl.factories.clear
    FactoryGirl.sequences.clear
    FactoryGirl.find_definitions
  end

  config.include FactoryGirl::Syntax::Methods
), after: 'RSpec.configure do |config|'

# config/application.rb
application do
  %q{
    # タイムゾーン
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local 

    # 日本語化
    I18n.enforce_available_locales = true
    config.i18n.default_locale = :ja

    # generatorの設定
    config.generators do |g|
      g.orm :active_record
      g.template_engine :slim
      g.test_framework :rspec, :fixture => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.view_specs false
      g.controller_specs true
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.helper false
    end

    # lib/autoload 以下を自動読み込み
    config.autoload_paths += %W(#{config.root}/lib/autoload)
  }
end

# git init
git :init
git :add => '.'
git :commit => "-a -m 'first commit'"
