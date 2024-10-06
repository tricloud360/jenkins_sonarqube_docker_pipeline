pipeline {
    agent any
    
    environment {
        SONAR_PROJECT_KEY = 'main-pipeline'
        NODEJS_PATH = '/usr/bin/node' // Update this path to the LTS version of Node.js installed on your system
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Started by user demo'
                echo 'Checking out source code...'
                // Simulating checkout step
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building the project...'
                // Simulating build step
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Simulating test step
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube Analysis...'
                script {
                    def scannerHome = tool 'SonarScanner'
                    withSonarQubeEnv() {
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=${SONAR_PROJECT_KEY} -Dsonar.nodejs.executable=${NODEJS_PATH}"
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // Simulating deploy step
            }
        }
    }
    
    post {
        success {
            echo 'Finished: SUCCESS'
        }
        failure {
            echo 'Finished: FAILURE'
        }
    }
}