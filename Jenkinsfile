pipeline {
    agent any
    
    environment {
        SONAR_PROJECT_KEY = 'main-pipeline'
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
                        sh "\${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=\${SONAR_PROJECT_KEY}"
                    }
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building and deploying Docker image on Docker server...'
                sh "rsync -av --exclude='.git' ./ ubuntu@\${DOCKER_SERVER_IP}:/home/ubuntu/website"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@\${DOCKER_SERVER_IP} \"cd /home/ubuntu/website && sudo docker stop Main-Website || true && sudo docker rm Main-Website || true && sudo docker build -t nexwebsite . && sudo docker run -d -p 8085:80 --name=Main-Website --restart unless-stopped nexwebsite\""
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