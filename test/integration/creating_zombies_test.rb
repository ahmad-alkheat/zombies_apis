require 'test_helper'

class CreatingZombiesTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test 'creates a new zombie' do
    post '/zombies',
      { zombie:
        { name: 'brain_eater', weapon: 'teeth'}
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      assert_equal 201, response.status
      assert_equal Mime::JSON, response.content_type

      zombie = json(response.body)
      assert_equal api_zombie_url(zombie[:id]), response.location
    end

    test 'create a new zombie with nil name' do
      post '/zombies', 
      { zombie:
        { weapon: 'hands' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      assert_equal 422, response.status
    end
  end

