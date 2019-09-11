require 'test_helper'

class MainEntryTest < ActiveSupport::TestCase
  test 'find by inventory nums' do
    me = FactoryGirl.create :main_entry
    se = FactoryGirl.create :sub_entry, {
      inventory_id_list: '88|12345|7000144993, 79|12345|7000144994'
    }

    assert_equal 1, MainEntry.by_inventory('88|80006273|7000144993').count
    assert_equal 1, MainEntry.by_inventory('79|80006274|7000144994').count

    assert_equal 0, MainEntry.by_inventory('144994').count
    assert_equal 0, MainEntry.by_inventory('274|700').count

    assert_equal 1, MainEntry.by_inventory('79|').count
    assert_equal 1, MainEntry.by_inventory('88').count
    assert_equal 1, MainEntry.by_inventory('12345').count
    assert_equal 1, MainEntry.by_inventory('7000144994').count
  end

  test 'find by full text search' do
    v = '1817, S. 31; 1927-1936, S. 47, Nr. 6; 1941-1944, Nr. 8, Inv. 18888; 1959; 1962 [Inv. 69]'
    me = FactoryGirl.create :main_entry, {
      historical_evidence: v,
      location: 15
    }
    se = FactoryGirl.create :sub_entry, {
      sequence: '008',
      location: 'Kopenhagen',
      inventory_id_list: '88|12345|7000144993, 79|12345|7000144994'
    }

    assert_equal 1, MainEntry.by_terms('69').count
    assert_equal 1, MainEntry.by_terms('79').count
    assert_equal 1, MainEntry.by_terms('Kopenhagen').count
    assert_equal 1, MainEntry.by_terms('008').count
    assert_equal 1, MainEntry.by_terms('Kirschsalon').count
  end
end
