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

  desc 'export vikus timeline csv'
  task vikus_timeline_csv: :environment do
    puts 'year,titel,text,extra'
    datings = {}
    SubEntry.find_each do |se|
      datings[se.dating.scan(/\d{4}/).first.to_i] ||= se.dating
    end
    data = datings.keys.sort.map do |d|
      to_csv([d,datings[d],'','']).join(',')
    end

    puts data.join("\n")
  end

  desc 'export vikus data csv'
  task vikus_data_csv: :environment do
    require 'csv'
    out = CSV.generate do |csv|
      csv << ['id' , 'year', 'keywords', '_material', '_description', '_dating', '_creator']
      SubEntry.find_each do |se|
        csv << [
          se.id,
          se.dating.scan(/\d{4}/).first.to_i,
          [room_for(se)].join(','),
          se.material,
          se.description,
          se.dating,
          se.creator.gsub('"', "'")
        ]
      end
    end
    puts out
  end

  desc 'export vikus image data'
  task vikus_images: :environment do
    SubEntry.find_each do |se|
      if medium = se.media.published.first
        from = medium.image.path(:normal)
        to = "../cache/vikus-viewer-script/images/#{se.id}.jpg"
        system "cp #{from} #{to}"
      end
    end
  end

  def room_for(se)
    @rooms ||= JSON.parse(File.read 'lib/data/locations.json')

    @rooms.each do |m|
      etage = m['name']
      m['rooms'].each do |r|
        if r['id'] == se.main_entry.location
          return r['name']
        end
      end
    end

    nil
  end

  def to_csv(data)
    data.map do |e|
      e.to_s.match(/,/) ? "\"#{e}\"" : e.to_s
    end
  end
end