namespace :pb do

  def combine(*args)
    args.map{|f| f.shuffle.first}.join(' ')
  end

  def inv_id
    "#{(rand * 2).to_i + 1} C #{(rand * 2).to_i + 1} #{(rand * 300).to_i}"
  end

  def locations
    json = File.read("#{Rails.root}/public/sample-data/data/locations.json")
    data = JSON.parse(json)
    data.map{|e| e['options']}.flatten
  end

  def seq
    @seq ||= 0
    @sub_seq = 0
    @seq += 1
  end

  def sub_seq
    @sub_seq += 1
  end

  def test(what = :main_entry)
    titles = ['Konsoltisch', 'Gueridon', 'Sitzmobiliar']
    connectors = ['mit', 'ohne', 'auf']
    add = ['Sphingen', 'Spiegeln', 'Tassen', 'Tellern', 'Vase', 'Säulen']
    amounts = ['zwei', 'drei', 'vier', 'sechzehn', 'neunzehn', 'zwölf', 'sechs']
    items = ['Sessel', 'Sofas', 'Bilder', 'Stühle']
    groups = ['Porzellan', 'Holz', 'Metall', 'Marmor', 'Glas']

    case what
      when :main_entry
        entry = {
          title: combine(titles, connectors, add),
          location: combine(locations),
          group: combine(groups),
          sequence: seq
        }
      when :sub_entry
        entry = {
          title: combine(amounts, items),
          description: Faker::Lorem.paragraph((rand * 60).to_i),
          inventory_id_list: (rand * 12).to_i.times.map{inv_id},
          sequence: "#{@seq}.#{sub_seq}"
        }
    end
  end

  # def read_xls(file)
  #   sheet = Spreadsheet.open(file).worksheets.first
  #   headers = sheet.rows.first.to_a
  #   sheet.rows[1..-1].map do |line|
  #     record = {}
  #     line.each_with_index do |value, i|
  #       record[headers[i]] = value
  #     end
  #     record
  #   end
  # end

  desc 'import test data'
  task test_data: ['db:drop', 'db:setup', :environment] do
    # locations = read_xls("#{Rails.root}/../data/test_data/Aufstellungsort.xls")
    # people = read_xls("#{Rails.root}/../data/test_data/Künstler.xls")
    # accounts = read_xls("#{Rails.root}/../data/test_data/Kontoführung.xls")
    # objects = read_xls("#{Rails.root}/../data/test_data/Inventartabelle.xls")

    # objects.each do |o|
    #   o['person'] = people.find{|e| e['Künstler-Nr'] == o['Künstler-Nr']}
    #   o['location'] = locations.find{|e| e['Künstler-Nr'] == o['Künstler-Nr']}
    #   o['accounts'] = accounts.find{|e| e['Kontonummer'] == o['Konto-Nr']}
    # end

    15.times do
      me = MainEntry.create!(test(:main_entry))
      (rand * 7).to_i.times do
        me.sub_entries.create!(test(:sub_entry))
      end
    end

    byebug
  end

end