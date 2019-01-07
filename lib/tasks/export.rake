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
    puts 'id,year,keywords,_material,_description,_dating,_creator'
    SubEntry.find_each do |se|
      data = [
        se.id,
        se.dating.scan(/\d{4}/).first.to_i,
        [se.location].join(','),
        se.material,
        se.description,
        se.dating,
        se.creator
      ]
      puts to_csv(data).join(',')
    end
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

  def to_csv(data)
    data.map do |e|
      e.to_s.match(/,/) ? "\"#{e}\"" : e.to_s
    end
  end
end