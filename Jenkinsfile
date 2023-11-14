pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mywebapp-image'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git 'https://github.com/Sora1393/JenkinsDependencyCheckTest.git'
            }
        }

        stage('OWASP Dependency-Check Vulnerabilities') {
            steps {
                script {
                    // Assuming you have OWASP Dependency-Check installed in Jenkins
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

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t $DOCKER_IMAGE ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh "docker run -d -p 3000:3000 --name mywebapp-container $DOCKER_IMAGE"
                }
            }
        }
    }

    post {
        always {
            // Stop and remove the Docker container after the pipeline finishes
            script {
                sh "docker stop mywebapp-container || true"
                sh "docker rm mywebapp-container || true"
            }
        }
        success {
            dependencyCheckPublisher pattern: 'dependency-check-report.xml'
        }
    }
}
