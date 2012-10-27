module SshHosts
  class << self
    def host_list_autocomplete
      Dir[File.expand_path('~/.ssh/hosts/**/*.yml')].map{|f| File.basename(f, '.yml') }.sort.each do |file|
        puts file unless file == 'global'
      end
    end

    def remote_command(server, command)
      system %{
        ssh #{server} -t "bash -i -c '#{ command }'"
      }
    end
  end
end