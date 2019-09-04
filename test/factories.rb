FactoryGirl.define do
  factory :main_entry do
    title "Kaiserliche Sitzgruppe"
    add_attribute :sequence, "001"

    factory :kings_seats do
      title 'Königliche Sitzgruppe'
      add_attribute :sequence, '002'
    end
  end

  factory :sub_entry do
    title "3 Spiegel"
    main_entry {MainEntry.first}
  end
end