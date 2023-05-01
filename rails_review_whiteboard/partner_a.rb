# Question One: Employees Query
# You are given a PostgreSQL database with two tables: the first is an employees table and the second is a departments table. Employees can belong to a single department.

# Write a SQL query that, given a department name, finds all the employees names that are in that department.

# Next find the name of the employees that don't belong to any department

SELECT employees.name
FROM employees
JOINS departments ON employees.department_id = departments.id
WHERE departments.name = '?';

SELECT employees.name
FROM employees
LEFT_OUTER_JOINS departments ON employees.department_id = departments.id
WHERE employees.department_id IS NULL;

# Question Two:
# Describe the differences between a primary key and a foreign key.

A primary key points to the subject of a table while a foreign key points to the ID column (primary key) of another table.

# Question Three:
# Given the following table write all the belongs_to and has_many and has_many through associations for models based on the below table (Physician, Appointment, and Patient)

# == Schema Information
#
# Table name: physicians
#
#  id   :integer          not null, primary key
#  name :string           not null


# Table name: appointments
#
#  id   :integer           not null, primary key
#  physician_id :integer   not null
#  patient_id :integer     not null


# Table name: patients
#
#  id   :integer           not null, primary key
#  name :string            not null
#  primary_physician_id :integer

class Physician < ApplicationRecord
    has_many :appointments,
        foreign_key: :physician_id,
        class_name: :Appointment

    has_many :patients,
        through: :appointments,
        source: :patient

    has_many :primary_patients,
        foreign_key: :primary_physician_id,
        class_name: :Patient

    has_many :primary_patient_appointments,
        through: :primary_patients,
        source: :appointments
end

class Appointment < ApplicationRecord
    belongs_to :patient,
        foreign_key: :patient_id,
        class_name: :Patient

    belongs_to :physician,
        foreign_key: :physician_id,
        class_name: :Physician
end

class Patient < ApplicationRecord
    has_many :appointments,
        foreign_key: :patient_id,
        class_name: :Appointment

    belongs_to :primary_physician,
        foreign_key: :primary_physician_id,
        class_name: :Physician
end

# Question Four:
# Paraphrase the advantages of using an ORM (like ActiveRecord).

Using an ORM such as ActiveRecord is advantageous becuase it allows us to manipulate data from SQL as RUBY objects

# Question Five:
# When are model validations run?

Model validations are ran after front end processes and before database processes
# *Whenever a model instance is updated or saved to our database

# Question Six:
# Given the following Schema:


# # == Schema Information
# #
# # Table name: actors
# #
# #  id          :integer      not null, primary key
# #  name        :string
# #
# # Table name: movies
# #
# #  id          :integer      not null, primary key
# #  title       :string
# #
# # Table name: castings
# #
# #  movie_id    :integer      not null, primary key
# #  actor_id    :integer      not null, primary key
# #  ord         :integer
# Write two SQL Queries:

# List the films where 'Harrison Ford' has appeared - but not in the star role.
# Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role
# Obtain a list in alphabetical order of actors who've had at least 15 starring roles.

SELECT movies.title
FROM movies
JOIN castings ON movies.id = movie_id
JOIN actors ON actors.id = actor_id
WHERE actors.name = 'Harrison Ford' AND castings.ord != 1;

SELECT actors.name
FROM actors
JOIN castings ON actors.id = actor_id
JOIN movies ON movies.id = movie_id
WHERE castings.ord = 1
GROUP BY actors.name
HAVING COUNT(actors.name) >= 15
ORDER BY actors.name;

# Question Seven:
# Identify the difference between a has_many through and a has_one association?

A has_many through association is an association that is made through another established association, while a has_one association is a direct association