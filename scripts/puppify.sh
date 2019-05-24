#!/bin/bash
PUPPET_REPO=https://github.com/jinostrozam/ctrl-repo-puppet-server-vagrant-lab.git
IDENTITY="-i /home/jaime/workspace/puppet/ssh-keys/provisioner/id_rsa"
if [ "$#" -lt 2 ]; then
  cat <<USAGE
Usage: $0 TARGET HOSTNAME [BRANCH]
Install Puppet on the node TARGET (IP address or DNS name) and run 
the bootstrap process. Set the hostname to HOSTNAME, and optionally use 
the control repo branch BRANCH.
USAGE
  exit 1
fi
TARGET=$1
HOSTNAME=${2}
BRANCH=${3:-production}

OPTIONS="-oStrictHostKeyChecking=no"-
echo -n "Copying bootstrap script... "
scp ${IDENTITY} ${OPTIONS} $(dirname $0)/bootstrap.sh provisioner@${TARGET}:/tmp
echo "done."
echo -n "Bootstrapping... "
ssh ${IDENTITY} ${OPTIONS} provisioner@${TARGET} "sudo bash /tmp/bootstrap.sh ${PUPPET_REPO} ${HOSTNAME} ${BRANCH}"
echo "done."
