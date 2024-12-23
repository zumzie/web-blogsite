pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build('myapp:latest')
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-credentials-id') {
                        docker.image('myapp:latest').push()
                    }
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                script {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
