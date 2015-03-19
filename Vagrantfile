Vagrant.configure("2") do |config|
	# Add your synced folder with your python scripts here
	config.vm.synced_folder "/home/", "/home/"
	# Defines the devEnv virtual machine
	config.vm.define "devEnv" do |a|
		# Set the provider as docker
		a.vm.provider "docker" do |d|
			# Set the image to use here
			# I set this as the image on the local registry, but it can be changed
			d.image = "192.168.1.5:5000/test_env"
			# These arguments will be added to the docker run command
			d.create_args = ["-e", "NFS_MOUNT=192.168.1.18:/mnt/zvolume1", "--privileged", "-it", "--name", "test_env"]
			# Keeps the docker container running
			d.remains_running = true
			# Informs vagrant that the docker container has ssh
			d.has_ssh = true
			# STILL TO BE TESTED
			# When this is run on a Mac or Windows machine, vagrant will spin up a virtual environment that supports docker
			d.vagrant_machine = "dockerhost"
    			d.vagrant_vagrantfile = "./DockerHostVagrantfile"
		end
		# Network settings
		# This is disabled for now - only necessary if running a web service
		#a.vm.network "forwarded_port", host: 4567, guest: 80
		# These credentials must match those specified in the docker image
		a.ssh.username = "root"
		# Input the provided password
		a.ssh.password = "PASSWORD"
	end
end
