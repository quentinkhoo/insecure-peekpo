#Nice Try!:)
require 'eventmachine'
require 'open3'

module Peekpo
  def post_init
    set_comm_inactivity_timeout(10)
    send_data "⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠁⠀⠉⠙⠛⠿⠛⠉⠀⠀⠀⠉⢻⣿⣿⣿⣿⣿⣿⣿\n"
    send_data "⣿⣿⣿⣿⣿⣿⡿⠋⠀⢀⠔⠒⠒⠒⠒⠀⠠⠔⠚⠉⠉⠁⠀⠙⢿⣿⣿⣿⣿⣿\n"
    send_data "⣿⣿⣿⣿⠟⢋⠀⠀⠀⠀⣠⢔⠤⠀⢤⣤⡀⠠⣢⡭⠋⡙⢿⣭⡨⠻⣿⣿⣿⣿\n"
    send_data "⣿⣿⣿⠇⢀⠆⠀⠀⠀⣪⣴⣿⠐⢬⠀⣿⡗⣾⣿⡇⠈⠦⢸⣿⠗⢠⠿⠿⣿⣿\n"
    send_data "⣿⣿⡏⠀⠀⠀⢀⡀⠀⠈⠛⠻⠄⠀⠠⠋⠀⠈⠛⠻⠆⠀⠈⢀⡠⣬⣠⢣⣶⢸\n"
    send_data "⣿⡿⠀⠀⠀⣶⡌⣇⣿⢰⠷⠦⠄⣀⣀⣀⣀⣀⣀⣠⣤⠶⠞⡛⠁⣿⣿⣾⣱⢸\n"
    send_data "⣿⡇⠀⠀⠀⣬⣽⣿⣿⢸⡜⢿⣷⣶⣶⣶⣯⣽⣦⡲⣾⣿⡇⣿⠀⣌⠿⣿⠏⣼\n"
    send_data "⣿⡇⠀⠀⠀⠹⣿⡿⢫⡈⠻⢦⡹⢟⣛⣛⣛⣛⣛⣡⠿⣫⡼⠃⠀⣿⡷⢠⣾⣿\n"
    send_data "⣿⡇⡀⠀⠀⠀⠀⠰⣿⣷⡀⠀⠙⠳⠦⣭⣭⣭⣵⡶⠿⠋⠀⢀⣴⣿⡇⣾⣿⣿\n"
    send_data "⣿⢠⣿⣦⣄⣀⠀⠀⢻⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⣀⣤⣶⣿⣿⡟⣰⣿⣿\n"
    send_data "⡇⣸⣿⣿⣿⣿⣿⣷⣦⢹⣿⣇⢠⣤⣤⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⡇⢹⣿⣿⣿\n"
    send_data "⡇⣿⣿⣿⣿⣿⣿⣿⣿⣎⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⣸⣿⣿⣿\n"
    send_data "⣧⡘⠿⢿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⢋⣡⣾⣿⣿⣿⣿\n"
    send_data "⣿⣿⣿⣶⣤⣍⣉⣛⣛⡛⠛⠛⢛⣛⣛⣛⣛⣉⣩⣭⣤⣴⣶⣿⣿⣿⣿⣿⣿⣿\n"
    send_data "Hello! I am Peekpo. I was made with Ruby. I peek into files. Tell me a file and I'll peek into it: "
  end

  def receive_data data
    begin
      data = data.strip 
      if data.length < 3
        send_data "Peekpo needs more to understand!\n"
      else
        if data.length > 500 
          send_data "Information overload! Peekpo cannot process so much!\n"
        else
          if data =~ /help/
            send_data "You asked for help? Peekpo helps!\n"
            send_data "Peekpo shows you how peekpo peeks:\n"
            send_data "`head -c 12 \"\#{data}\"`\n"
          else
            Open3.popen3("#{data}") do |stdin, stdout, stderr, wait_thread|
              err = stderr.gets(nil)
              out = stdout.gets(nil)
              [stdin, stdout, stderr].each{|stream| stream.send('close')}
              exit_status = wait_thread.value
            end
          end
        end
      end
    rescue Exception => e
      send_data e.message + "\n"
      send_data e.backtrace.join("\n")+"\n"
    end
  end

  def check_blacklist str
    str =~ /[\d\s\(\)<>\?\+\/\\\!`:@\*#\^\%]/
  end
end


EventMachine.run {
  EventMachine.start_server "", 29900, Peekpo
  puts "Peekpo started!"
}
