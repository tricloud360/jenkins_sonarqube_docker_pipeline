pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Started by user tricloud360'
                echo 'Checking out source code...'
                script {
                    try {
                        checkout([$class: 'GitSCM', branches: [[name: '*/main']],
                            userRemoteConfigs: [[url: 'https://github.com/tricloud360/jenkins_sonarqube_docker_pipeline.git']]])
                    } catch (Exception e) {
                        error 'ERROR: Unable to checkout source code from Git repository.'
                    }
                }
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building the project...'
                script {
                    try {
                        sh './build.sh'
                    } catch (Exception e) {
                        error 'ERROR: Build step failed.'
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                script {
                    try {
                        sh './run_tests.sh'
                    } catch (Exception e) {
                        error 'ERROR: Test step failed.'
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                script {
                    try {
                        sh './deploy.sh'
                    } catch (Exception e) {
                        error 'ERROR: Deploy step failed.'
                    }
                }
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