pipeline {
    agent any 

    environment {
        APP_NAME = 'abc-banking'
        ENVIRONMENT = "dev"
    }

    options {
        skipDefaultCheckout(true)
    }

    stages {
        stage("checkout") {
            steps {
                checkout scm
            }
        }

        stage("Set Commit Hash") {
            steps {
                script {
                    env.shortCommit = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                }
            }
        }

        stage("Jenkins Environment") {
            steps {
                sh '''
                echo "Build Number: $BUILD_NUMBER" 
                echo "Job Name: $JOB_NAME"
                echo "Workspace: $WORKSPACE"
                echo "Branch: $BRANCH_NAME"
                echo "Build URL: $BUILD_URL"
                echo "Commit: $shortCommit"
                '''
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

        stage('Docker Build') {
            steps {
                sh "docker build -t abc-banking:${shortCommit} ."
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
