pipeline {
    agent {
        docker {
            image 'node:lts-buster-slim'
            args '-u root -p 3000:3000'
        }
    }
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
            }
        }
    }	
    post {
        success {
            dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        }
    }
}
