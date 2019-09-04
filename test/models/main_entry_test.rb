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
end
