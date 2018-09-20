require_relative( 'models/star' )
require_relative( 'models/movie' )
require_relative( 'models/casting' )
require( 'pry-byebug' )

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

star1 = Star.new({"first_name" => "Asma", "last_name" => "Malik"})
star1.save
star2 = Star.new({"first_name" => "Hadsan", "last_name" => "Geele"})
star2.save
star3 = Star.new({"first_name" => "Mike", "last_name" => "Tyson"})
star3.save

movie1 = Movie.new({"title" => "The Chaos In India", "genre" => "action", "budget" => 200000})
movie1.save
movie2 = Movie.new({"title" => "Mission Possible", "genre" => "action", "budget" => 300000})
movie2.save
movie3 = Movie.new({"title" => "Tlove Is In The Air", "genre" => "romance", "budget" => 100000})
movie3.save

casting1 = Casting.new({"movie_id" => movie3.id, "star_id" => star1.id, "fee" => 20000})
casting1.save
casting2 = Casting.new({"movie_id" => movie1.id, "star_id" => star2.id, "fee" => 30000})
casting2.save
casting3 = Casting.new({"movie_id" => movie1.id, "star_id" => star3.id, "fee" => 40000})
casting3.save

# Calling methods
Star.all
Movie.all
Casting.all

# update

movie1.title = "Another Movie"
movie1.update()

# select * from movies;

# get all the star of the movie
movie1.stars()
# get all the movies of a star
star2.movies()

movie1.remaining_budget

# first part total fee of casting of movie
# pry(main)> movie1.remaining_budget
# => {"sum"=>"700000"}
# [2] pry(main)>

movie1.remaining_budget()

# Total remaining budget
# [1] pry(main)> movie1.remaining_budget()
# => 130000
# [2] pry(main)>

binding.pry
nil
