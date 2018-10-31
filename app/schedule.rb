require 'date'

require_relative './csv_setup.rb'

##############################################################################################
##  schedule:       sets the on-call rotations for the employees
##
##  args:           start_date      -   day the scedule starts
##                  end_date        -   day schedule ends on
##                  employees       -   array of employee names
##                  
##  returns:    Array containing [weekday schedule, weekend schedule, number of weeks (int)]
def schedule start_date, end_date, employees
    weekdays = weekday_arrange employees
    weekends = weekend_arrange employees
    number_of_weeks = (end_date - start_date).to_i / 7 + 1 

   
    generate_schedule weekdays, weekends, number_of_weeks
   
end

##############################################################################
##  weekday_arrange:  sets the rotation for 
##
##  args:             employees     -   array of employees
##
##  returns:          ans           -   nested array of one on call rotation
def weekday_arrange employees
    n = employees.length
    ans = []
    # does not require this since there will be >= 5 at all times
    if n < 5
        ans = employees
        ans << 'FREE DAY'
        ans << 'FREE DAY'
        ans.shuffle
    elsif n > 5
        temp = employees.shuffle
        scheduled = temp[0..4]
        waiting   = temp[5..n]
        n.times do |i|
            scheduled.unshift waiting.pop
            waiting.unshift scheduled.pop
            ans << scheduled.clone
        end
    else
        ans = employees.shuffle
    end
    ans
end

##############################################################################
##  weekday_arrange:  sets the rotation for 
##
##  args:             employees     -   array of employees
##
##  returns:          ans           -   nested array of one on call rotation
def weekend_arrange employees
    ans = employees.each_slice(2).to_a
    if employees.length % 2 == 0
        ans
    else
        temp = ans.pop
        ans.last << temp[0]
        ans
    end
end

def factorial n
    n < 0 ? nil : (1..n).inject(:*) || 1
end