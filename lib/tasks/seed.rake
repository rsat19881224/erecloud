desc "load data to development environment"
task "db:seed:development" => :environment do
  load(File.join(Rails.root, "db", "seeds", "development.rb"))
end

desc "load data to test environment"
task "db:seed:test" => :environment do
  load(File.join(Rails.root, "db", "seeds", "test.rb"))
end

desc "load data to product environment"
task "db:seed:product" => :environment do
  load(File.join(Rails.root, "db", "seeds", "product.rb"))
end
