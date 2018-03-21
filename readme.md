# Vagrant box for Magento 2

## You can change such variables for installing Magento, all this variable in file `ansible/group_vars/all.yml`.

You can set Magento version what need to be installed.

Just change `magento_version` (default 2.2.2).

Change PHP version: `php_version`

Magento encryption key: `magento_crypt_key`

Magento mode: `magento_mage_mode`

User for DB: `db_user`

Password for DB user: `db_user_password`

DB host: `db_host`

DB name: `db_name`

`db_dump_file` - there are empty database file, it temporary solution. But if You have already existing project just paste into this variable path to you db dump

`magentotools_install_composer` - leave this variable `true`

`mage_username` and `mage_password` - its credentials for mage.repo authentication - I use my data as default, change if you need

`mage_admin_url` - URL for admin panel

`mage_admin_user_name` - user name for admin panel

`mage_admin_password` - password for admin user

`mage_admin_first_name` - admin first name - 

`mage_admin_last_name` - admin last name

`mage_admin_email` - admin email - !! **please change this variable** !!


## Some notes about Magento 2 installation

With this vagrant box also installed mailcatcher: you can use them by url: `base_url:1080`

Change Ubuntu version: 45 or 47 line in __Vagrantfile__

Vagrant box with value `false` for variable `new_project` not tested yet. 

Before You start `vagrant up` command change base_url for your store and IP.

You can do this in such files:

__Vagrantfile__ - 38, 48, 50, 69 lines

~~Also if Your Magento have some stores, add they URL in __Vagrantfile__ at 51 line and uncomment it. But its functional temporary don't work, need to write template for sites-enabled~~

__ansible/group_vars/all.yml__ - 14, 15 lines

__ansible/inventory/vagrant__ - 2, 5, 8 lines. Also at this lines change `ansible_user` for Ubuntu 14.04 to `vagrant`
