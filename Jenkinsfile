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
                // Here you can add the commands to build your project, e.g., running a script or executing Maven/Gradle.
                sh './build.sh'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Add commands to run your unit or integration tests.
                sh './run_tests.sh'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // Add commands to deploy the application.
                sh './deploy.sh'
            }
        }
    }
    
    post {
        success {
            echo 'Finished: SUCCESS'
        }
        failure {
            echo 'ERROR: Unable to find Jenkinsfile from git https://github.com/tricloud360/jenkins_sonarqube_docker_pipeline.git'
            echo 'Finished: FAILURE'
        }
    }
}