pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                git 'https://github.com/Sora1393/JenkinsDependencyCheckTest.git'
            }
        }

        stage('Start Docker Container') {
            steps {
                script {
                    def containerId = sh(script: "docker run -d -p 3000:80 -v C:/JenkinsDependencyCheckTest:/usr/share/nginx/html nginx", returnStdout: true).trim()
                    def containerIp = sh(script: "docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${containerId}", returnStdout: true).trim()

                    echo "Container IP address: ${containerIp}"
                }
            }
        }
    }
    post {
        always {
            script {
                // Clean up: Stop and remove the Docker container
                sh "docker stop ${containerId}"
                sh "docker rm ${containerId}"
            }
        }
    }
}
