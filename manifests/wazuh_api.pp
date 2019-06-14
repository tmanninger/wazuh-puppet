
class wazuh::wazuh_api (

  $wazuh_api_package = "wazuh-api",
  $wazuh_api_service = "wazuh-api",
  $wazuh_api_version = "3.9.1-1",

  $nodejs_package = "nodejs"

){

  if $::osfamily == 'Debian' {
    exec { 'Updating repositories...':
      command => "cd /tmp && curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -",
      
    }
    package { $nodejs_package:
      provider => 'apt',
    }
    package { $wazuh_api_package:
      ensure  => $wazuh_api_version,
      provider => 'apt',
    }

  }else{
    exec { 'Updating repositories...':
      path    => "/usr/bin",
      command => "curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -",
      
    }
    package { $nodejs_package:
      provider => 'yum',
    }
    package { $wazuh_api_package:
      ensure  => $wazuh_api_version,
      provider => 'yum',
    }
  }

  service { "wazuh-api":
    ensure  => running,
    enable  => true,
    provider => "systemd",
  }


}
