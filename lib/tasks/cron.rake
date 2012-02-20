desc "Deletes every user-sent ID from the databse, for legal and security reasons."
task :cron => :environment do
  puts 'Deleting user-sent IDs...'
  
  complaints = Complaint.where(Complaint.arel_table[:statement_id].not_eq(nil)).where('created_at < :time', :time => 1.day.ago)

  count = complaints.count

  complaints.update_all({ :statement_id => nil })
  
  puts "Done. Affected #{count} entries."
end