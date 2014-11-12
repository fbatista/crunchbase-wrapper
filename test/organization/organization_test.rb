require './test/test_helper'

class CrunchbaseCollectionTest < Minitest::Test

  def setup
    Crunchbase.config.user_key = '1683f336966578b1c1bb2f3874d733d0'
  end

  def test_exists
    assert Crunchbase::Organization
  end

  def test_it_gives_back_a_single_organization
    VCR.use_cassette('twitch') do
      o = Crunchbase::Organization.find('twitch')
      assert_equal Crunchbase::Organization, o.class

    end
  end
end
