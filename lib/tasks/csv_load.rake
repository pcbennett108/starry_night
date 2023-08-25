require "csv"

# rails csv_load:constellations
namespace :csv_load do
  desc "loads the constellations CSV"
  task :constellations => :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'constellations.csv'))
    constellations = CSV.parse(csv_text, headers: true, header_converters: :symbol)
    constellations.each do |row|
      constellation = Constellation.new
      constellation.id = row[:id]
      constellation.name = row[:name]
      constellation.symbolism = row[:symbolism]
      constellation.bayer_stars = row[:bayer_stars]
      constellation.stars_with_planets = row[:stars_with_planets]
      constellation.in_zodiac = row[:in_zodiac]
      constellation.save
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('constellations')
    puts "Constellations Loaded"
  end
end

# rails csv_load:stars
namespace :csv_load do
  desc "loads the stars CSV"
  task :stars => :environment do
    csv_text = File.read(Rails.root.join('db', 'data', 'stars.csv'))
    stars = CSV.parse(csv_text, headers: true, header_converters: :symbol)
    stars.each do |row|
      star = Star.new
      star.constellation_id = row[:constellation_id]
      star.name = row[:name]
      star.distance = row[:distance]
      star.mass = row[:mass]
      star.radius = row[:radius]
      star.visible = row[:visible]
      star.save
    end
    puts "Stars Loaded"
  end
end



namespace :csv_load do
  desc "loads all csv files"
  task :all => :environment do
    all = [
      :constellations,
      :stars
    ]
    all.each do |file|
      Rake::Task["csv_load:#{file}"].invoke
    end
    puts "All Loaded"
  end
end