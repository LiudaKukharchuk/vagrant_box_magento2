# Vagrant box for Magento 2

## How to install
If you never used Vagrant before, read the [Vagrant Docs](https://www.vagrantup.com/docs/) first.

### Requirements
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

### Installation steps
1. Create directory for the project

    ```mkdir /path/to/your/project/directory```

2. Clone project 

    ```git clone https://github.com/LiudaKukharchuk/vagrant_box_magento2.git /path/to/your/project/directory```

3. Go to the project directory

    ```cd /path/to/your/project/directory```

4. Install hostupdater

    ```vagrant plugin install vagrant-hostsupdater```

5. Start vagrant box installation

    ```vagrant up```

6. Wait until vagrant box will be installed

Now you can use such url or IP in browser to see your site if don't change default value

http://vagrantbox.m2.local/

192.168.33.51

For run `bin/magento` command:

```bash
cd /path/to/your/project/directory
vagrant ssh
cd /vagrant/source
php bin/magento
```

Clean all caches & session data:
```bash
vagrant ssh
redis-cli flushall
```

For clean specific cache use this command:
```bash
redis-cli -n 0 flushdb
```

0 - default cache

1 - full page cache

2 - session


## You can change such variables for installing Magento, all this variable in file `ansible/group_vars/all.yml`.

Also, You can check other variables in this file.

You can set Magento version what need to be installed. I tested this box with installation only Magento 2.3.3 

_In brackets specified the default value for this vagrant box_

Just change `magento_version` (2.3.3).

Check if it's new Magento project `new_project` (true)

Check if need to deploy Sample data `install_sample_data` (true)

Change PHP version: `php_version` (7.3)

Magento encryption key: `magento_crypt_key` ("00000000000000000000000000000000")

Magento mode: `magento_mage_mode` "default", "production" or "developer" ("default")

User for DB: `db_user` ("magento")

Password for DB user: `db_user_password` ("magento")

DB host: `db_host` ("localhost")

DB name: `db_name` ("magentodb")

`db_dump_file` - there are empty database file, it temporary solution. But if You have already existing project just paste into this variable path to you db dump ("../extras/db.sql.gz")

`magentotools_install_composer` - leave this variable `true`. You have a possibility to not install a Composer. But would be better to have it in your box.

`mage_username` and `mage_password` - its credentials for mage.repo authentication. See https://devdocs.magento.com/guides/v2.3/install-gde/prereq/connect-auth.html

`mage_admin_url` - URL for admin panel ("admin")

`mage_admin_user_name` - user name for admin panel ("admin")

`mage_admin_password` - password for admin user ("qa123123")

`mage_admin_first_name` - admin first name ("Admin")

`mage_admin_last_name` - admin last name ("Admin")

`mage_admin_email` - admin email ("some.email@email.com")

`mage_language` - Magento language ("en_US")

`mage_currency` - currency for your magento store ("USD")

`mage_timezone` - timezone. Default value the same as `fradee_timezone` ("Europe/Kiev")

`mage_use_rewrites` - enable/disable rewrites ("1")


## Some notes about Magento 2 installation

With this vagrant box also installed mailcatcher: you can use them by url: `base_url:1080`

Change Ubuntu version: 65 or 67 line in __Vagrantfile__

Vagrant box with value `false` for variable `new_project` not tested yet. If you set `true` vagrant box automatically download Magento and install it via Composer.

Before You start `vagrant up` command change base_url for your store and IP. Default value "vagrantbox.m2.local" and "192.168.33.51"

You can do this in such files:

__Vagrantfile__ - 58, 68, 70, 94 lines

~~Also if Your Magento have some stores, add they URL in __Vagrantfile__ at 71 line and uncomment it. But its functional temporary don't work, need to write template for sites-enabled~~

__ansible/group_vars/all.yml__ - 14, 15 lines

__ansible/inventory/vagrant__ - 2, 5, 8 lines. Also at this lines change `ansible_user` for Ubuntu 14.04 to `vagrant`


P.S. After trying to start vagrant box on the MacOS I got an error 
```bash
There was an error loading a Vagrantfile. The file being loaded
and the error message are shown below. This is usually caused by
a syntax error.

Path: /Users/user/my/path/to/vagrantbox/Vagrantfile
Line number: 0
Message: RuntimeError: can't modify frozen String
```
I fixed it by commenting first line in `Vagrantfile`:
```
# Vagrant::DEFAULT_SERVER_URL.replace('https://vagrantcloud.com')
```

## Notes

This is my first vagrant box for Magento 2 it is a beta version and can be improved, please help me to improve and fix bugs for this vagrant box.

Thanks.