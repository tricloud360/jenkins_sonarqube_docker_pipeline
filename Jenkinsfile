pipeline {
    agent any
    
    environment {
        SONAR_PROJECT_KEY = 'main-pipeline'
        NODEJS_PATH = '/Users/sam/.nvm/versions/node/v18.20.4/bin/node' // Update this path to the correct Node.js LTS version installed on your system
        DOCKER_SERVER_IP = '54.242.18.167'
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
        
        stage('Prepare Docker Directory') {
            steps {
                echo 'Setting up the target directory on the server...'
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${DOCKER_SERVER_IP} 'sudo mkdir -p /home/ubuntu/website && sudo chown ubuntu:ubuntu /home/ubuntu/website'"
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Transferring files and building Docker image on Docker server...'
                sh "scp -o StrictHostKeyChecking=no -r ./ ubuntu@${DOCKER_SERVER_IP}:/home/ubuntu/website --exclude='.git'"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${DOCKER_SERVER_IP} 'cd /home/ubuntu/website && docker build -t website-image .'"
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${DOCKER_SERVER_IP} 'docker run -d -p 80:80 --name website-container website-image || docker restart website-container'"
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
