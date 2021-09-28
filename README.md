# Packer manifest for building google machine images with ansible provisioning

#### In this playbook you can find:
    * group_vars  # The folder with files which contains the group vars of each instances
        Files in this folder:
        
        1.  jenkins_nginx
        2.  nexus_server
        3.  prod_server
        4.  slave_server
        5.  servers_ALL
    
    * roles # The folder which contain a roles
        Roles in this folder:

        1.  deploy # added ssh key to prod instances
        2.  docker_install  # install docker and docker-compose
        3.  jenkins_nginx # deploy jenkins with nginx and ssl
        4.  nexus # deploy nexus with nginx and ssl
        5.  packages # install all required packages
        6.  slave # provision docker slave host
    
    * ansible.cfg # File with configuration (included path to hosts.txt file)
    * hosts.txt # File which included groups of servers with their addresses
    * site.yml # The main file which contain the sequence of executing of each role
    * password.txt contain the secret password for ansible-vault
