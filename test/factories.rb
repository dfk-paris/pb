FactoryGirl.define do

  factory :main_entry do
    title "Kaiserliche Sitzgruppe"
  end

  factory :sub_entry do
    title "3 Spiegel"
    main_entry {MainEntry.first}
  end

end