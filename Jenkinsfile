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
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube Analysis...'
                script {
                    def scannerHome = tool 'SonarScanner'
                    withSonarQubeEnv() {
                        sh "\${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=\${SONAR_PROJECT_KEY} -Dsonar.nodejs.executable=\${NODEJS_PATH}"
                    }
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building and deploying Docker image on Docker server...'
                sh "rsync -av --exclude='.git' ./ ubuntu@\${DOCKER_SERVER_IP}:/home/ubuntu/website"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@\${DOCKER_SERVER_IP} \"cd /home/ubuntu/website && sudo docker stop Main-Website || true && sudo docker rm Main-Website || true && sudo docker build -t nexwebsite . && sudo docker run -d -p 8085:80 --name=Main-Website --restart unless-stopped --user root nexwebsite\""
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
        always {
            script {
                def buildStatus = currentBuild.result ?: 'SUCCESS'
                def subject = "Build \${env.BUILD_NUMBER} - \${buildStatus}"
                def body = """
                Jenkins Build \${env.BUILD_NUMBER} - \${buildStatus}
                
                Job: \${env.JOB_NAME}
                Build Number: \${env.BUILD_NUMBER}
                Build URL: \${env.BUILD_URL}
                
                Comprehensive Build Report:
                
                \${env.BUILD_REPORT}
                """
                
                emailext subject: subject,
                         body: body,
                         to: 'tricloud360@gmail.com',
                         attachLog: true
            }
        }
    }
}