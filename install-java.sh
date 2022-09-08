cd ~
source .bashrc

if [ -d ~/java1.8-272 ] 
then
  rm -rf ~/java1.8-272
  cd ~ && wget https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u272-b10/openlogic-openjdk-8u272-b10-linux-x64.tar.gz 
  tar -xvf openlogic-openjdk-8u272-b10-linux-x64.tar.gz
  rm -rf openlogic-openjdk-8u272-b10-linux-x64.tar.gz*
  mv openlogic-openjdk-8u272-b10-linux-x64 java1.8-272
  if [ -z "$(grep -e ':$JAVA_HOME/bin' ~/.bashrc | grep -w "export" | grep -w "PATH")" ] && [ -z "$(grep -e 'JAVA_HOME=' ~/.bashrc | grep -w "export")" ];
  then 
    echo 'export JAVA_HOME=~/java1.8-272' >> ~/.bashrc
    echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc
  else
    :
  fi
  source ~/.bashrc
else
  cd ~ && wget https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u272-b10/openlogic-openjdk-8u272-b10-linux-x64.tar.gz 
  tar -xvf openlogic-openjdk-8u272-b10-linux-x64.tar.gz 
  rm -rf openlogic-openjdk-8u272-b10-linux-x64.tar.gz* 
  mv openlogic-openjdk-8u272-b10-linux-x64 java1.8-272
  if [ -z "$(grep -e ':$JAVA_HOME/bin' ~/.bashrc | grep -w "export" | grep -w "PATH")" ] && [ -z "$(grep -e 'JAVA_HOME=' ~/.bashrc | grep -w "export")" ];
  then 
    echo 'export JAVA_HOME=~/java1.8-272' >> ~/.bashrc
    echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc
  else
    :
  fi
  source ~/.bashrc
fi
