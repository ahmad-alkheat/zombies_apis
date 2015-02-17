require 'test_helper'

class ListingZombiesTest < ActionDispatch::IntegrationTest

  setup { host! 'api.example.com' }

  test 'returns a list of all zombies' do
    get '/zombies'
    assert_equal 200, response.status
    refute_empty response.body   
  end
end