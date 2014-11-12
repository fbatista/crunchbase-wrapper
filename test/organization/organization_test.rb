require './test/test_helper'

class CrunchbaseCollectionTest < Minitest::Test

  def setup
    Crunchbase.config.user_key = 'DUMMY'
  end

  def test_exists
    assert Crunchbase::Organization
  end

  def test_it_gives_back_a_single_organization
    VCR.use_cassette('twitch') do
      o = Crunchbase::Organization.find('twitch')
      assert_equal Crunchbase::Organization, o.class

      assert_equal "3dfd8d9c748079e8a983dcf1d0f8e1a5", o.uuid
      assert_equal "Organization", o.type
      assert o.properties
      assert_equal true, o.properties.secondary_role_for_profit
      assert_equal "twitch", o.properties.permalink
      assert o.relationships
      assert o.relationships.categories
      assert_equal "b1b3b2d785ed2cb1fc603e2b6a3b5ddd", o.relationships.categories.items.first.uuid
      assert_equal 4, o.relationships.categories.paging.total_items
      assert_equal 4, o.relationships.categories.items.size

    end
  end

  def test_it_gives_back_first_page_of_organizations
    VCR.use_cassette('organizations_1') do
      orgs_1 = Crunchbase::Organization.all

      # Make sure we got all the organizations
      assert_equal 1000, orgs_1.length

      # Make sure that the JSON was parsed
      assert orgs_1.kind_of?(Array)
      assert orgs_1.first.kind_of?(Crunchbase::Organization)

      assert_equal "organization/airzolo", orgs_1.first.path

      #load details
      details = orgs_1.first.load_details
      assert_equal orgs_1.first.name, details.properties.name
      assert_equal orgs_1.first.path.sub("organization/", ''), details.properties.permalink
    end
  end
end
