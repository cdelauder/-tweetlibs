require 'sqlite3'
require 'debugger'
require 'time'

$tweetlibs_database = SQLite3::Database.new "tweetlibs-database.db"

class Storybook
  attr_reader :title, :genre, :story
  def initialize
    @title = ''
    @genre = ''
    @story = ''
  end

  def read_in_story_file(file_path)
    file = File.new(file_path)
    story_array = file.readlines
    p @title = story_array[0].chomp
    p @genre = story_array[1].chomp
    p @story = story_array.slice(3,story_array.length)
  end

  def create_db_table
    $tweetlibs_database.execute("DROP TABLE IF EXISTS story_templates;")
    $tweetlibs_database.execute(<<-SQL
      CREATE TABLE story_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR DEFAULT NULL,
        genre VARCHAR DEFAULT NULL,
        story TEXT DEFAULT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );
      SQL
    )
  end

  def add_storys_to_table
    $tweetlibs_database.execute(
      "INSERT into story_templates (title, genre, story)
      VALUES (?, ?, ?);", [@title, @genre, @story.join("")]
    )
  end

  def return_story
    $tweetlibs_database.execute(
      "SELECT story FROM story_templates;")
  end

end

test = Storybook.new

test.read_in_story_file('romance.txt')
test.add_storys_to_table
