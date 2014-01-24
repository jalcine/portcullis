# Define the parent categories.
Category.destroy_all
categoryMusic = Category.create! name: 'Music'
categoryNetworking = Category.create! name: 'Networking'
categorySocial = Category.create! name: 'Social'
categoryActivities = Category.create! name: 'Activities'
categoryArts = Category.create! name: 'The Arts'


['Concert', 'Music Show', 'Alternative', 'Classical', 'Electronic/Dance',
 'Folk/Country', 'Hip-Hop/RnB', 'Jazz/Blues', 'Pop', 'Afrobeats', 'Latin',
 'Religious', 'Other'].each do | sub_music_category |
  sub_music = Category.new(name: sub_music_category)
  sub_music.category = categoryMusic
  sub_music.save!
end
