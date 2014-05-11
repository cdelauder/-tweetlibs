Dir[APP_ROOT.join('db', '*.txt')].each do |story_file|
    file = File.new(story_file)
    story = file.readlines.map(&:chomp)

    genre = Genre.create(name: story[1])
    Story.create(
      story_text: story[3..-1].join(" "),
      title: story[0],
      genre: genre
    )

end



