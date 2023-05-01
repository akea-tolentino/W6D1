# Question One
# What are the disadvantages of adding an index to a table column in a database?

A disadvantage of adding an index to a table column is that adding an index is costly. It costs time, and memory space to add an index so we would like to avoid casually adding an index to everything.

# Question Two
# Given the following table write all the belongs_to and has_many associations for models based on the below table (User, Enrollment, and Course)


# # == Schema Information
# #
# # Table name: users
# #
# #  id   :integer                not null, primary key
# #  name :string                 not null


# # Table name: enrollments
# #
# #  id   :integer                not null, primary key
# #  course_id :integer           not null
# #  student_id :integer          not null


# # Table name: courses
# #
# #  id   :integer                not null, primary key
# #  course_name :string          not null
# #  professor_id :integer        not null
# #  prereq_course_id :integer    not null

class User < ApplicationRecord
    has_many :enrollments,
        foreign_key: :student_id,
        class_name: :Enrollment
    
    has_many :courses_taught,
        foreign_key: :professor_id,
        class_name: :Course,
        optional: true
end

class Enrollment < ApplicationRecord
    belongs_to :student,
        foreign_key: :student_id,
        class_name: :User

    belongs_to :course,
        foreign_key: :course_id,
        class_name: :Course
end

class Course < ApplicationRecord
    has_many :enrollments,
        foreign_key: :course_id,
        class_name: :Enrollment

    has_many :students_enrolled,
        through: :enrollments,
        source: :student
    
    belongs_to :professor,
        foreign_key: :professor_id
        source: :User

    belongs_to :prerequisite,
        foreign_key: :prereq_course_id,
        class_name: :Course,
        optional: true
    
end

# Question Three
# Given all possible SQL commands order by order of query execution. (SELECT, DISTINCT, FROM, JOIN, WHERE, GROUP BY, HAVING, LIMIT/OFFSET, ORDER).

From
Join
Where
Group By
Having
Select
Distinct
Order by
Limit/Offset

# Question Four
# Given the following table:

# # == Schema Information
# #
# # Table name: nobels
# #
# #  yr          :integer
# #  subject     :string
# #  winner      :string

# Write the following SQL Query:

# In which years was the Physics prize awarded, but no Chemistry prize?

SELECT DISTINCT yr
FROM nobels
WHERE subject = 'Physics' AND yr NOT IN (
    SELECT yr
    FROM nobels
    WHERE subject = 'Chemistry'
);

# Question Five
# What is the purpose of a database migration?

A database migration provides a history of changes made to the database and to our code
# *A migration is a file containing Ruby code. This code describes a set of changes to a database. It can be used to create, drop, or update tables in our database.

# Question Six
# What is the difference between Database Constraints and Active Record Validations?

Database contstraints are our last line of defense, and ensures the data entering our tables follow our constraints. Active Record validations are meant to acheive the same goal, but SHOULD filter data before the database constraints see it.
# *Validations are defined inside models. These model-level validations are executed within Rails and written in Ruby code. Becuase of this, they are flexible database agnostic and convenient to test or reuse. Database constraints are defined within migrations and give us hard errors whenever something that shouldn't enter our database is inputted

# Question Seven
# Given the following table write all the belongs_to and has_many associations for models based on the below table (User, Game, and Score)

# # == Schema Information
# #
# # Table name: user
# #
# #  id   :integer          not null, primary key
# #  name :string           not null


# # Table name: score
# #
# #  id   :integer           not null, primary key
# #  number :integer         not null
# #  user_id :integer        not null
# #  game_id :integer        not null


# # Table name: game
# #
# #  id   :integer           not null, primary key
# #  name :string            not null
# #  game_maker_id :integer  not null

class User < ApplicationRecord
    has_many :scores,
        foreign_key: :user_id,
        class_name: :Score,
        dependent: :destroy

    has_many :games_made,
        foreign_key: :game_maker_id,
        class_name: :Game

end

class Score < ApplicationRecord
    belongs_to :user,
        foreign_key: :user_id,
        class_name: :User

    belongs_to :game,
        foreign_key: :game_id,
        class_name: :Game
end

class Game < ApplicationRecord
    has_many :scores,
        foreign_key: :game_id,
        class_name: :Score,
        dependent: :destroy

    belongs_to :game_maker,
        foreign_key: :game_maker_id,
        class_name: :User

end