namespace :pb do

  def combine(*args)
    args.map{|f| f.shuffle.first}.join(' ')
  end

  def inv_id
    "#{(rand * 2).to_i + 1} C #{(rand * 2).to_i + 1} #{(rand * 300).to_i}"
  end

  def location
    random(1, 22)
  end

  def seq
    @seq ||= 0
    @sub_seq = 0
    @seq += 1
  end

  def sub_seq
    @sub_seq += 1
  end

  def random(min = 1, max = 10)
    range = max - min + 1
    (rand * range).floor - 1 + min
  end

  def sentence(min = 3, max = 20)
    Faker::Lorem.sentence(random(min, max), true, 0)
  end

  def text(min = 5, max = 15)
    Faker::Lorem.sentences(random(min, max)).join(' ')
  end

  def distance(min, max, unit)
    "#{random(min, max)} #{unit}"
  end

  def date(min, max)
    Faker::Date.between(min.years.ago, max.years.ago).strftime('%d.%m.%Y')
  end

  def test(what = :main_entry)
    titles = ['Konsoltisch', 'Gueridon', 'Sitzmobiliar']
    connectors = ['mit', 'ohne', 'auf']
    add = ['Sphingen', 'Spiegeln', 'Tassen', 'Tellern', 'Vase', 'Säulen']
    amounts = ['zwei', 'drei', 'vier', 'sechzehn', 'neunzehn', 'zwölf', 'sechs']
    items = ['Sessel', 'Sofas', 'Bilder', 'Stühle']
    materials = ['Porzellan', 'Holz', 'Metall', 'Marmor', 'Glas']
    markings = ['Stempel', 'Etikett', 'Aufschrift']
    names = 20.times.map{Faker::Name.name}
    cities = 20.times.map{Faker::Address.city}
    framings = ['Rahmen', 'Passepartout', 'Sockel', 'Vitrine']

    case what
      when :main_entry
        entry = {
          title: combine(titles, connectors, add),
          location: location,
          sequence: seq,
          provenience: sentence(3, 10),
          historical_evidence: sentence(10, 50),
          literature: sentence(5, 15),
          description: text(4, 20),
          appreciation: text(2, 10)
        }
      when :sub_entry
        entry = {
          title: combine(amounts, items),
          description: Faker::Lorem.paragraph((rand * 60).to_i),
          inventory_id_list: (rand * 12).to_i.times.map{inv_id},
          sequence: "#{@seq}.#{sub_seq}",
          creator: combine(names),
          location: combine(cities),
          dating: date(250, 150),
          height: distance(10, 100, 'cm'),
          width: distance(10, 100, 'cm'),
          depth: distance(10, 100, 'cm'),
          diameter: distance(10, 100, 'cm'),
          weight: distance(10, 100, 'cm'),
          height_with_socket: distance(10, 100, 'cm'),
          width_with_socket: distance(10, 100, 'cm'),
          depth_with_socket: distance(10, 100, 'cm'),
          markings: combine(markings),
          material: combine(materials),
          framing: combine(framings),
          restaurations: sentence(10, 30)
        }
    end
  end

  desc 'import test data'
  task test_data: ['db:drop', 'db:setup', :environment] do
    15.times do
      me = MainEntry.create!(test(:main_entry))
      (rand * 7).to_i.times do
        me.sub_entries.create!(test(:sub_entry))
      end
    end

    User.create! username: 'admin'
  end

end