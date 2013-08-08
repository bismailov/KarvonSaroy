# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#If you need to add more default categories later, you can append them to the seed file and reload it.
#If you want to rerun the seed data, the trick is that the seeds file doesn’t know whether the records
#already in the database have to be cleaned up; running rake db:seed again adds all records one more
#time, and you end up with duplicate user and categories. You should instead call rake db:setup, which
#re-creates the database and adds the seed data as you may expect.

subjects = Subject.create([{title: 'english 5-7 year olds'},
               {title: 'english 8-11 year olds'}])

# http://en.wikipedia.org/wiki/Common_European_Framework_of_Reference_for_Languages#Common_reference_levels
student_levels = StudentLevel.create([
               {title: 'beginner'}, #A1
               {title: 'elementary'}, #A2
               {title: 'intermediate'}, #B1
               {title: 'upper intermediate'}, #B2
               {title: 'advanced'}, #C1
               {title: 'proficiency'} #C2
                 ])

