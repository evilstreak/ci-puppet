# == Class: ci_environment::jenkins_slave
#
# Class to install things only on the Jenkins Slave
#
# API token in hiera needs to be updated after provisioning a new master.
#
class ci_environment::jenkins_slave(
  $accounts
) {
    validate_hash($accounts)

    include java
    include jenkins::slave

    create_resources('account', $accounts)

    Exec['apt-get-update'] -> Class['java'] -> Class['jenkins::slave']

    ufw::allow { 'allow-jenkins-slave-swarm-to-listen':
        port  => '32768:65535',
        proto => 'udp',
        ip    => 'any',
    }
}
