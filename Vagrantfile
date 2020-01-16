# Vagrant::DEFAULT_SERVER_URL.replace('https://vagrantcloud.com')
Vagrant.require_version ">= 1.8"

# get my custom variable from console
require 'getoptlong'

opts = GetoptLong.new(
  [ '--new-project', GetoptLong::OPTIONAL_ARGUMENT ]
)

$projectStatus=''

opts.each do |opt, arg|
  case opt
    when '--new-project'
      $projectStatus=arg

  end
end

# end of getting my custom variable

def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable? exe
        }
    end
    return nil
end

Vagrant.configure("2") do |config|

    # VirtualBox setting
    # Use all CPU cores and 1/4 system memory
    config.vm.provider "virtualbox" do |v|

        host = RbConfig::CONFIG['host_os']

        # Give VM 1/4 system memory & access to all cpu cores on the host
        if host =~ /darwin/
            cpus = `sysctl -n hw.ncpu`.to_i
            # sysctl returns Bytes and we need to convert to MB
            mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
        elsif host =~ /linux/
            cpus = `nproc`.to_i
            # meminfo shows KB and we need to convert to MB
            mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
        else # sorry Windows folks, I can't help you
            cpus = 2
            mem = 2048
        end

        v.customize ["modifyvm", :id, "--memory", mem]
        v.customize ["modifyvm", :id, "--cpus", cpus]
        v.customize ["modifyvm", :id, "--name", "vagrantbox.m2.local"]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//vagrant","1"]
    end


    #16.04
    config.vm.box = "ubuntu/xenial64"
    #14.04
    #config.vm.box = "ubuntu/trusty64"
    config.vm.network :private_network, ip: "192.168.33.51"
    config.ssh.forward_agent = true
    config.vm.hostname = "vagrantbox.m2.local"
    #config.hostsupdater.aliases = ["store1.m2.local" ,"store2.m2.local", "storeN.m2.local"]
    config.hostsupdater.remove_on_suspend = false

    # Synced folders
    # On OSX we use some tips to boost the nfs ;)
    host = RbConfig::CONFIG['host_os']
    if (/darwin/ =~ RUBY_PLATFORM)
        config.vm.synced_folder "", "/vagrant", nfs: true,
        mount_options: ["nolock", "async"],
        bsd__nfs_options: ["alldirs","async","nolock"]
    #On Linux synced folders
    elsif host =~ /linux/
        config.vm.synced_folder "./", "/vagrant", nfs: true,
        mount_options: ["nolock", "async"]
    #On Windows synced folders
    else
        config.vm.synced_folder "./", "/vagrant", nfs: true
    end

# Display my custom variable
        config.vm.provision "shell",
          inline: "echo '#{$projectStatus}'"

        config.vm.provision :shell, :path => "ansible/windows.sh", :args => "'vagrantbox.m2.local', '#{$projectStatus}'"
end
