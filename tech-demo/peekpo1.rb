#Nice Try!:)
require 'eventmachine'

module Peekpo
  def post_init
    set_comm_inactivity_timeout(1000000000)
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
    send_data "Hello! I am Peekpo. I was made with Ruby. I peek into files.\n"
    send_data "For example, I can peek into apu.txt, peepo.txt, but not flag.txt becuz Peekpo hate flags\n"
    send_data "Tell me a file and I'll peek into it:\n"
  end

  def receive_data data
    begin
      data = data.strip 
      if data.length < 3
        send_data "Peekpo needs more to understand!\n"
      else
        if data.length > 25
          send_data "Information overload! Peekpo cannot process so much!\n"
        else
          if data =~ /help/
            send_data "You asked for help? Peekpo helps!\n"
            send_data "Peekpo shows you how peekpo peeks:\n"
            send_data "`head -c 12 \#{data}`\n"
          else
            if check_blacklist(data)
              send_data "Peekpo cannot understand you. :(\n"
              send_data "Maybe ask Peekpo for help?\n"
            else
              user_input = `head -c 12 #{data} 2>&1`
              send_data "This is your result: #{user_input}\n"
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
    str =~ /[;]/
  end
end


EventMachine.run {
  EventMachine.start_server "", 29900, Peekpo
  puts "Peekpo started!"
}
