require 'test_helper'

class ListingZombiesTest < ActionDispatch::IntegrationTest

  setup { host! 'api.example.com' }

  test 'returns a list of all zombies' do
    get '/zombies', {}, { 'Accept' => Mime::JSON }
    assert_equal 200, response.status
    refute_empty response.body   
  end

  test ' returns zombies filtered by weapon' do
    john = Zombie.create!( name: 'john', weapon: 'axe')
    joanna = Zombie.create!( name: 'joanna', weapon: 'gun')

    get '/zombies?weapon=axe', {}, { 'Accept' => Mime::JSON }
    assert_equal 200, response.status

    zombies = json(response.body)
    names = zombies.collect { |z| z[:name] }
    assert_includes names, 'john'
    refute_includes names, 'joanna'
  end

  test 'returns zombie by id' do
    john = Zombie.create!( name: 'john', weapon: 'axe')

    get "/zombies/#{john.id}"
    assert_equal 200, response.status
    zombie_response = json(response.body)

    assert_equal john.name, zombie_response[:name]
  end

  test 'returns a JSON representation of zombies' do
    get '/zombies', {}, { 'Accept' => Mime::JSON }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'returns an XML representation of zombies' do
    get '/zombies', {}, { 'Accept' => Mime::XML }
    assert_equal 200, response.status
    assert_equal Mime::XML, response.content_type
  end


end