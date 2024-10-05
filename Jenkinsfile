pipeline {
    agent any
    
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