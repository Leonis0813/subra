VERSION=$1
yum -y install rsync openssh-clients
wget https://opscode-omnibus-packages.s3.amazonaws.com/el/${VERSION}/x86_64/chefdk-0.7.0-1.el${VERSION}.x86_64.rpm
rpm -ivh chefdk-0.7.0-1.el${VERSION}.x86_64.rpm
rm -f chefdk-0.7.0-1.el${VERSION}.x86_64.rpm
