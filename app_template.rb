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
end

# bundle install
run 'run bundle install'

# rspec
generate 'rspec:install'
run "echo '--color --require rails_helper' > .rspec"
