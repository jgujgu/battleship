require 'minitest/autorun'
require 'minitest/pride'
require './lib/battleship'
require './lib/ship'
require './lib/evaluator'
require './lib/printer'
require './lib/map'

class BattleshipTest < MiniTest::Test

	def setup
		@battleship = Battleship.new
		@ship_1x2 = Ship.new
		@ship_1x3 = Ship.new(@ship_1x2)
		@evaluator = Evaluator.new(@ship_1x2)
	end

	def test_it_exists
		assert @evaluator
		assert @battleship
	end

	def test_it_generates_a_predictable_2x2_ship
		assert_equal ["A1", "A2"], @ship_1x2.coordinates
	end

	def test_it_registers_a_hit
		@evaluator.hit("A1")
		assert_equal 1, @ship_1x2.hits
		@evaluator.hit("A3")
		assert_equal 1, @ship_1x2.hits
	end

	def test_it_hits_on_a_hit
		@evaluator.hit("A1")
		@evaluator.hit("A2")
		assert_equal 2, @ship_1x2.hits
	end

	def test_it_sinks_a_1x2
		@evaluator.hit("A1")
		@evaluator.hit("A2")
		assert_equal true, @ship_1x2.sunk
	end

	def test_it_sinks_a_1x3
		@ship_1x3.random_1x3
		@evaluator.ship = @ship_1x3
		@ship_1x3.coordinates[0] = "B1"
		@ship_1x3.coordinates[1] = "B2"
		@ship_1x3.coordinates[2] = "B3"
		@evaluator.hit("B1")
		@evaluator.hit("B2")
		@evaluator.hit("B3")
		assert @ship_1x3.sunk
	end


	def test_it_deletes_old_ship_entries
		@evaluator.hit("A1")
		@evaluator.hit("A1")
		assert_equal 1, @ship_1x2.hits
	end

	def test_it_ouputs_the_hit_entries
		@evaluator.hit("A1")
		@evaluator.hit("A2")
		assert_equal ["A1", "A2"], @evaluator.hits_record
	end


	def test_it_ouputs_the_miss_entries
		miss_evaluator = Evaluator.new(Ship.new)
		miss_evaluator.hit("A3")
		miss_evaluator.hit("A4")
		assert_equal ["A3", "A4"], miss_evaluator.misses_record
	end


	# def test_it_generates_a_random_1x2_ship
	# 	random_1x2 = Ship.new
	# 	puts random_1x2.random_1x2
	# end

	def test_space_check_checks_spaces_of_existing_ships_given_a_size
		refute @ship_1x3.horz_space_check("A1",3)
		assert @ship_1x3.horz_space_check("B1",3)
	end

	# def test_it_generates_a_1x3_not_on_top_of_the_1x2
	# 	puts @ship_1x3.random_1x3
	# end

	def test_it_generates_random_ships
		puts @ship_1x2.random_1x2
		puts @ship_1x3.random_1x3
	end

end