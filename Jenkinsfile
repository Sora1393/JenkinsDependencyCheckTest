pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                git 'https://github.com/Sora1393/JenkinsDependencyCheckTest.git'
            }
        }

        stage('OWASP Dependency-Check Vulnerabilities') {
            steps {
                dependencyCheck additionalArguments: ''' 
                    -o './'
                    -s './'
                    -f 'ALL' 
                    --prettyPrint
                    --suppression suppression.xml
                ''', odcInstallation: 'OWASP Dependency-Check Vulnerabilities'
				script {
                    def containerId = sh(script: "docker ps -q --filter ancestor=node:lts-buster-slim", returnStdout: true).trim()
                    def containerIp = sh(script: "docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${containerId}", returnStdout: true).trim()

                    echo "Container IP address: ${containerIp}"
                }
            }
        }
    }	
    post {
        success {
            dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        }
    }
}
