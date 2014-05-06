require 'singleton'
require 'sqlite3'

require_relative './lonely'
require_relative './user'
require_relative './question'
require_relative './reply'
require_relative './like'
require_relative './follower'
require_relative './tag'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')

    self.results_as_hash = true
    self.type_translation = true
  end
end