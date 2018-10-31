require 'csv'

##############################################################################################
##  generate_schedule:       sets the on-call rotations for the employees
##
##  args:           start_date      -   day the scedule starts
##                  end_date        -   day schedule ends on
##                  employees       -   array of employee names
##                  
##  returns:    Array containing [weekday schedule, weekend schedule, number of weeks (int)]
def generate_schedule weekdays, weekends, num_weeks
    weekday_i = 0
    weekend_i = 0
    Dir.chdir "output-data"
    CSV.open("schedule.csv", "wb") do |csv|
        csv << ["Week Number", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        num_weeks.times do |i|
           week = []
           week << i + 1
           week += weekdays[weekday_i]
           week.fill(weekends[weekend_i].join(' and '), 6, 2)
           csv << week
           weekday_i = reset_index weekdays.length, weekday_i + 1
           weekend_i = reset_index weekends.length, weekend_i + 1
        end
    end
end

def reset_index length, index
    index < length ? index : 0
end