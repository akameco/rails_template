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

# gem
gem_group :development, :test do
  # rspec
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
end

# bundle install
run 'run bundle install'

# spring
run 'bundle exec spring binstub --all'

# rspec
generate 'rspec:install'
run "echo '--color --require rails_helper' > .rspec"
run 'spring binstub rspec'

# direnv
run "echo 'export PATH=$PWD/bin:$PATH' > .envrc"
run 'direnv allow .'
