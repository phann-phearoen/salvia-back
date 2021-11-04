class ImportData < ActiveRecord::Migration[6.1]
  def change
    Rake::Task['db:data:load'].invoke
  end
end
