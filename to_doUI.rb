require 'pg'
require './lib/list'
require './lib/task'
DB = PG.connect(:dbname => 'to_do')

def main_menu
puts "\n\n\nWelcome to your Slug Thing."
puts 'Add some hood tasks to your To-Do List'
puts 'Enter "s" to Start a New List'
puts 'Enter "e" to See Your Lists'
puts "Hit the 'x' to Exit\n\n\n"

user_input = gets.chomp
  if user_input == 's'
    start_new_list
  elsif user_input == 'e'
    see_lists
  elsif user_input == 'x'
    puts "Good Luck Out There"
  else
    puts "You crazy?"
    main_menu
  end
end

def start_new_list
  puts "Enter the Title of your List"
  new_title = gets.chomp
  new_list = List.new(new_title)
  new_list.save
  puts "\n\nYour new list '#{new_list.name}' has been created dogg-\n\n"
  puts "Do you want to add a Task to this New List?"
  puts "Enter 'y' to Yes add a task.  Or type any character to just chill."
  add_task_entry = gets.chomp
  if add_task_entry == 'y'
    add_new_task
  else
    main_menu
  end
end

def see_lists
  puts "\n\n"
  puts "Your Lists are as Follows:"
  List.all.each_with_index do |list, index|
    puts "#{index+1}. #{list.name}"
    end
  puts "\n\n\n"
  puts "Want to Add a Task?  Select a List by Typing List Number"
  puts "Otherwise hit 'm' to return to main menu"
  puts "\n\n\n"
  input = gets.chomp
  if input == 'm'
    main_menu
  elsif
    List.all.each_with_index do |list, index|
      if input.to_i == (index+1)
        list_index = (index+1)
        puts "Tell us what u gonna do"
        task_name = gets.chomp
        new_task = Task.new(task_name, list_index)
        new_task.save
        puts "\nHere is Your List and the T-Do's, get goin"
        puts List.all[list_index].name
        puts "\n"

        list_tasks = DB.exec("SELECT (name) FROM tasks WHERE list_id = #{list_index};")
        list_tasks.each do |task|
          puts task['name']
          end
        puts "\n\n"
        puts "Want to Delete a Task? Press 'd'"
        user_delete = gets.chomp
        if user_delete == 'd'
          delete_task
        else
          see_lists
        end
      end
  end
  else puts "Get Yo Self Back to School"
    see_lists
  end
end

main_menu
