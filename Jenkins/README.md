# Jenkins

https://www.udemy.com/course/continous-integration-jenkins-pipelines/

https://github.com/anshulc55/Jenkins_Upgradev3.git

## Install Jenkins

https://pkg.jenkins.io/debian-stable/

```
#!/bin/bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install fontconfig openjdk-17-jre -y
sudo apt-get install jenkins -y
java -version
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```

```
sudo vim install_jenkins.sh
sudo chmod +x install_jenkins.sh && ./install_jenkins.sh
```

### change ports for jenkins if 8080 doesn't work

```
java -jar /usr/share/java/jenkins.war --httpPort=8081
```

### run in backround

```
java -jar /usr/share/java/jenkins.war &
```

### check jenkins status

```
sudo systemctl status jenkins
```

### Start jenkins

```
sudo systemctl start jenkins
```
