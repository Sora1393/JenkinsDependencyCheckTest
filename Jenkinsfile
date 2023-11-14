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
                script {
                    // Run the Docker container and obtain its ID
                    def containerId = sh(script: "docker run -d -p 3000:3000 node:lts-buster-slim sleep 300", returnStdout: true).trim()

                    // Retrieve the container IP address
                    def containerIp = sh(script: "docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${containerId}", returnStdout: true).trim()

                    // Print the container IP address
                    echo "Container IP address: ${containerIp}"

                    // Now you can run your OWASP Dependency-Check with the containerIp
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
    }   
    post {
        success {
            dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        }
    }
}
