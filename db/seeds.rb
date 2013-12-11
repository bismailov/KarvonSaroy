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
               {title: 'beginner',
                description: 'Can understand and use familiar everyday expressions and very basic phrases aimed at the satisfaction of needs of a concrete type. Can introduce him/herself and others and can ask and answer questions about personal details such as where he/she lives, people he/she knows and things he/she has. Can interact in a simple way provided the other person talks slowly and clearly and is prepared to help.'}, #A1
               {title: 'elementary',
                description: 'Can understand sentences and frequently used expressions related to areas of most immediate relevance (e.g. very basic personal and family information, shopping, local geography, employment). Can communicate in simple and routine tasks requiring a simple and direct exchange of information on familiar and routine matters. Can describe in simple terms aspects of his/her background, immediate environment and matters in areas of immediate need.'}, #A2
               {title: 'intermediate',
                description: 'Can understand the main points of clear standard input on familiar matters regularly encountered in work, school, leisure, etc. Can deal with most situations likely to arise while travelling in an area where the language is spoken. Can produce simple connected text on topics that are familiar or of personal interest. Can describe experiences and events, dreams, hopes and ambitions and briefly give reasons and explanations for opinions and plans.
                <br>
                TOEFL (IBT): 57 to 86
                <br>
                IELTS: 4.0 to 5.0'}, #B1
               {title: 'upper intermediate',
                description: 'Can understand the main ideas of complex text on both concrete and abstract topics, including technical discussions in his/her field of specialisation. Can interact with a degree of fluency and spontaneity that makes regular interaction with native speakers quite possible without strain for either party. Can produce clear, detailed text on a wide range of subjects and explain a viewpoint on a topical issue giving the advantages and disadvantages of various options.
                <br>
                TOEFL (IBT): 87 to 109
                <br>
                IELTS: 5.0 to 6.5'}, #B2
               {title: 'advanced',
                description: 'Can understand a wide range of demanding, longer texts, and recognise implicit meaning. Can express ideas fluently and spontaneously without much obvious searching for expressions. Can use language flexibly and effectively for social, academic and professional purposes. Can produce clear, well-structured, detailed text on complex subjects, showing controlled use of organisational patterns, connectors and cohesive devices.
                <br>
                TOEFL (IBT): 110 to 120
                <br>
                IELTS: 7.0 to 8.0'}, #C1
               {title: 'proficiency',
                description: 'Can understand with ease virtually everything heard or read. Can summarise information from different spoken and written sources, reconstructing arguments and accounts in a coherent presentation. Can express him/herself spontaneously, very fluently and precisely, differentiating finer shades of meaning even in the most complex situations.
                <br>
                TOEFL (IBT): 29-30 (reading)
                <br>
                IELTS: 8.0 to 9.0'} #C2
                ])


                
