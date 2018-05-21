class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.pageit(page, per_page = 10)
    if per_page == 'all'
      all
    else
      page = [(page || 1).to_i, 1].max - 1
      per_page = [(per_page || 10).to_i, 10].max
      limit(per_page).offset(per_page * page)
    end
  end

  def wikidata_people(field)
    qids = (self[field] || '').scan(/[Qq][0-9]+/).flatten
    qids.each do |qid|
      if data = fetch_wikidata(qid)
        lang = data['labels']['de'] || data['labels']['fr']
        self.people += [lang['value']]
      end
    end
    self.people.sort!.uniq!
  end

  def fetch_wikidata(qid)
    filename = Rails.root.join('data', 'wikidata', "#{qid}.json")
    if File.exists?(filename)
      Rails.logger.info "WikiData cache: #{qid}"
      JSON.parse File.read(filename)
    else
      Rails.logger.info "WikiData fetch: #{qid}"
      url = "http://www.wikidata.org/entity/#{qid}.json"
      response = Pb.http_client.get_content(url)
      data = JSON.parse(response)
      item = data['entities'][qid]
      File.open filename, 'w' do |f|
        f.write JSON.dump(item)
      end
      item
    end
  end
end
