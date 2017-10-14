namespace :pb do
  desc 'export people to csv'
  task export_people: :environment do
    people = []
    SubEntry.find_each do |se|
      unless [nil, '', 'Anonym'].include?(se.creator.strip)
        people << se.creator
      end
    end
    puts people.sort.uniq
  end
end