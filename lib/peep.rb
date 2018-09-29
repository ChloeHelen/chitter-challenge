require 'pg'

class Peep

  def self.store(peep)
    self.connect_db
    @con.exec "INSERT INTO peeps (peep, time) VALUES ('#{peep}', CURRENT_TIMESTAMP)"
  end

  def self.all
    self.connect_db
    result = @con.exec "SELECT peep, TO_CHAR(time, 'DD-MON-YYYY HH24:MI') FROM peeps ORDER BY time DESC"
    result.map { |row| {:peep => row['peep'], :time => row['to_char']} }
  end

  private

  def self.connect_db
    database = ENV['ENVIRONMENT'] == 'test' ? 'peeps_manager_test' : 'peeps_manager'
    @con = PG.connect :dbname => database , :user => 'chloemingay'
  end


end
