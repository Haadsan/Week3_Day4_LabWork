require_relative("../db/sql_runner")

class Movie
  attr_reader :id
  attr_accessor :title, :genre, :budget

def initialize(options)
@id = options["id"].to_i if options["id"]
@title = options["title"]
@genre = options["genre"]
@budget = options["budget"].to_i
end


def save()
  sql = "INSERT INTO movies(
title,
genre,
budget
  )
  VALUES
  ($1, $2, $3)

  RETURNING id"
# pass the value of this query
values = [@title, @genre, @budget]
movie = SqlRunner.run(sql, values).first
@id = movie["id"].to_i
end

def update()
  sql = "UPDATE movies SET (title, genre, budget) = ($1, $2, $3) WHERE id = $4"
  values = [@title, @genre, @budget, @id]
  SqlRunner.run(sql, values) # no need to save the returned results
end

def remaining_budget
  sql = "SELECT sum(castings.fee)
  FROM castings
  WHERE castings.movie_id = $1"
  values = [@id]
  total_fee = SqlRunner.run(sql, values).first

  remaining_budget = @budget - total_fee["sum"].to_i
 return remaining_budget
end


def stars()  #instance method and not a class method
  sql = "SELECT stars.* FROM stars INNER JOIN castings
      ON stars.id = castings.star_id
      WHERE castings.movie_id = $1"
  values =[@id]
  stars = SqlRunner.run(sql, values)
  return stars.map {|star| Star.new(star)}
end

def self.all()
  sql = "SELECT * FROM movies"
  movies = SqlRunner.run(sql)
 result = movies.map{|movie| Movie.new(movie)}
 return result
end

def self.delete_all()
  sql = "DELETE FROM movies"
  SqlRunner.run(sql)
end

end
