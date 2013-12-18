require 'rspec'
require_relative 'world.rb'

describe World do
  it 'creates a world object when you pass in a hash' do
    @world = World.new Hash.new
    @world.should be_an_instance_of World
  end

  it 'takes and empty hash and returns an empty hash' do
    @world = World.new Hash.new
    @world.next
    @world.to_hash.should == Hash.new
  end

  it 'takes a hash with one coordinant and returns an empty hash' do
    @world = World.new( { [1,1] => 1 } )
    @world.next
    @world.to_hash.should == Hash.new
  end
  
  it 'takes three blocks in a row and returns three blocks in column' do
    @world = World.new( { [0,0] => 1, [1,0] => 1, [2,0] => 1 } )
    @world.next
    @world.to_hash.should have_key([1,0])
    @world.to_hash.should have_key([1,1])
    @world.to_hash.should have_key([1,-1])
    @world.to_hash.should_not have_key([0,0])
    @world.to_hash.should_not have_key([2,0])
  end

  it 'takes a 1x3 line and returns a 3x1 line then returns a 1x3 line again' do
    @world = World.new( { [0,0] => 1, [1,0] => 1, [2,0] => 1 } )
    @world.next
    @world.to_hash.should have_key([1,0])
    @world.to_hash.should have_key([1,1])
    @world.to_hash.should have_key([1,-1])
    @world.to_hash.should_not have_key([0,0])
    @world.to_hash.should_not have_key([2,0])   
    @world.next
    @world.to_hash.should have_key([1,0])
    @world.to_hash.should have_key([0,0])
    @world.to_hash.should have_key([2,0])
    @world.to_hash.should_not have_key([1,1])
    @world.to_hash.should_not have_key([1,-1])   
  end
end
