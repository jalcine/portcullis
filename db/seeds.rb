# Build up age groups.
AgeGroup.destroy_all
AgeGroup.create! min_age: 13, max_age: 17, name: 'Below 18'
AgeGroup.create! min_age: 18, max_age: 21, name: '18 - 21'
AgeGroup.create! min_age: 21, max_age: 28, name: '21 - 28'
AgeGroup.create! min_age: 28, max_age: 40, name: '28 - 40'
AgeGroup.create! min_age: 40, max_age: 200, name: '40 & Over'

# Define the parent categories.
Category.destroy_all
categoryMusic = Category.create! name: 'Music'
categoryNetworking = Category.create! name: 'Networking'
categorySocial = Category.create! name: 'Social'
categoryActivities = Category.create! name: 'Activities'
categoryArts = Category.create! name: 'The Arts'

# Add 'Campus Life' under Social

["Concert", "Music Show", "Alternative", "Classical", "Electronic/Dance",
 "Folk/Country", "Hip-Hop/RnB", "Jazz/Blues", "Pop", "Afrobeats", "Latin",
 "Religious", "Other"].each do | sub_music_category |
  sub_music = Category.new(name: sub_music_category)
  sub_music.category = categoryMusic
  sub_music.save!
end
