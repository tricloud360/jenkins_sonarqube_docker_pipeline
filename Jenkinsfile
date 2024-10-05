pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Started by user tricloud360'
                echo 'Checking out source code...'
                checkout([$class: 'GitSCM', branches: [[name: '*/main']],
                    userRemoteConfigs: [[url: 'https://github.com/tricloud360/jenkins_sonarqube_docker_pipeline.git']]])
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building the project...'
                sh './build.sh'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh './run_tests.sh'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh './deploy.sh'
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