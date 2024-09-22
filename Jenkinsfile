pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/hackeddie/cicd_test.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ml_classification_project:latest .'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    sh 'docker run ml_classification_project python -m pytest'
                    }
                }
            }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_REGISTRY_CREDS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin docker.io"
                        sh 'docker push $DOCKER_BFLASK_IMAGE'
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}