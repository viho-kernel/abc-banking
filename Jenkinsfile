pipeline {
    agent any 
    environment {
        APP_NAME = 'abc-banking'
        ENVIRONMENT = "dev"
    }
    stages {
        stage("checkout") {
            steps {

                checkout scm
            }
        }
        stage('Installing Dependencies') {
            steps {
                dir('app') {
                    sh 'npm ci'
                }
            }
        }
        stage('Build') {
            steps {
                dir('app'){
                    sh 'npm run build'
                }
            }
        }
        stage('Test') {
            steps {
                dir('app') {
                    sh 'npm test'
                }
            }
        }
    }

    post {
         success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
        always {
            cleanWs()
        }
    }
}