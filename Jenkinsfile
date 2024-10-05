pipeline {
    agent any
    
    environment {
        GIT_REPO_URL = 'https://github.com/tricloud360/jenkins_sonarqube_docker_pipeline.git'
        BRANCH_NAME = 'main'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Started by user tricloud360'
                echo 'Checking out source code...'
                retry(3) {
                    checkout([$class: 'GitSCM', branches: [[name: "*/${BRANCH_NAME}"]],
                        userRemoteConfigs: [[url: GIT_REPO_URL]]])
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