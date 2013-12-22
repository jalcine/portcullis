namespace :test do
  task :ci do
    `bundle exec rspec`
  end
end
