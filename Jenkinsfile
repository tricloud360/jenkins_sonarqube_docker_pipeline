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
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image on Docker server...'
                sh "rsync -av --exclude='.git' ./ ubuntu@${DOCKER_SERVER_IP}:/home/ubuntu/website"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${DOCKER_SERVER_IP} \"cd /home/ubuntu/website && sudo docker stop Main-Website || true && sudo docker rm Main-Website || true && sudo docker build -t nexwebsite . && sudo docker run -d -p 8085:80 --name=Main-Website --restart unless-stopped nexwebsite\""
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