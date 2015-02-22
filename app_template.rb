txt = <<-TXT

      ＿人人人人人人人人人人人人人人人＿
      ＞　Rails Application Templates　＜
      ￣Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^Y^YY^Y￣

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
# gem 'rspec'
