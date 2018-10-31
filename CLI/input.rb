require 'date'

##################################################################################
##  input:      called outside this file for the CLI portion of the
##              on call scheduler
##
##  returns:    Array containing [start_date, end_date, employees_array]
def input 
    date = timeline
    employees = employees_input

    [date[0], date[1], employees]
end

####################################################################### 
##  timeline:   used to get the starting and ending dates from the user
##
##  returns:    Array containing [start_date, end_date]
def timeline
    flag = true
    start = DateTime.now
    finish = start.next_day(1)
     
    while flag
        puts "Is this starting today?"
        response = gets.chomp

        if positive_response? response
            finish = set_date "Finish"
        else
            start = set_date "Start"
            finish = set_date "Finish"
        end

        flag = false
    end

    [start, finish]
end

##################################################################################
##  set_date:   used to get the starting and ending dates from the user
##
##  args:       str - string for logging purposes. If it's gettign the start date
##                    or the end date
##  
##  returns:    A date for start or end
def set_date str

    flag = true
    date = 'none'

    while flag

        print "#{str} day: "
        day = gets.chomp.to_i
        print "#{str} month: "
        month = gets.chomp.to_i
        print "#{str} year: "
        year = gets.chomp.to_i

        if Date.valid_date?(year,month,day)
            date = Date.new(year,month,day)
            flag = false
        else
            puts "Invalid date - please try again"
        end

    end

    date

end

##################################################################################
##  employees_text:  used if there is an employees.txt file to use in the 
##                   input-files folder
##
##  args:           filename - self explanitory. Should be 'employees.txt' but
##                  keeping it a variable in case I need to change anything
##
##  returns:    Array containing [start_date, end_date]
def employees_text filename
    array = []
    File.open(filename,"r").each_line {|l| array << l.delete("\n")}.close
    array
end

##################################################################################
##  employees_text:  either gets a file called 'employees.txt' and uses that or
##                   prompts for one at  a time input
##
##  returns:    Array containing the employees to be scheduled
def employees_input
    filename = "input-data/employees.txt"
    employees = []

    if File.file? filename
        employees = employees_text filename
    else
        flag = true
        puts "Please input the employees below input 'exit' to stop"
        while flag
            name = gets.chomp
            name.downcase === "exit" ? flag = false : employees << name
        end
    end
    employees
end

def positive_response? var
    var = var.upcase
    var === "Y" or var === "YES"
end