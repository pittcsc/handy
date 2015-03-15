Easymon::Repository.add('database', Easymon::ActiveRecordCheck.new(ActiveRecord::Base), :critical)
