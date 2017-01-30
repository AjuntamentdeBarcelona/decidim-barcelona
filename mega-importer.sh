bundle exec rake db:drop db:create db:schema:load
bundle exec rake import:all
heroku pg:reset --app decidim-barcelona --confirm decidim-barcelona 
heroku pg:push decidim-barcelona_development DATABASE_URL
