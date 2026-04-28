pipeline {
    agent any

    environment {
        // Change these as per your setup
        APP_NAME = "my-app"
        DOCKER_IMAGE = "myrepo/my-app"
        GIT_REPO = "https://github.com/PavanSai845/coffee-shop.git"
    }

    tools {
        // Uncomment based on your project
        // nodejs "NodeJS"
        // maven "Maven"
        // jdk "JDK17"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    if (fileExists('package.json')) {
                        sh 'npm install'
                    } else if (fileExists('pom.xml')) {
                        sh 'mvn clean install -DskipTests'
                    } else if (fileExists('requirements.txt')) {
                        sh 'pip install -r requirements.txt'
                    } else {
                        echo "No dependency file found"
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    if (fileExists('package.json')) {
                        sh 'npm test || true'
                    } else if (fileExists('pom.xml')) {
                        sh 'mvn test'
                    } else if (fileExists('requirements.txt')) {
                        sh 'pytest || true'
                    } else {
                        echo "No tests configured"
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    if (fileExists('package.json')) {
                        sh 'npm run build || true'
                    } else if (fileExists('pom.xml')) {
                        sh 'mvn package'
                    } else {
                        echo "Nothing to build"
                    }
                }
            }
        }

        stage('Docker Build') {
            when {
                expression { fileExists('Dockerfile') }
            }
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:latest ."
            }
        }

        stage('Docker Push') {
            when {
                expression { fileExists('Dockerfile') }
            }
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh """
                    echo $PASS | docker login -u $USER --password-stdin
                    docker tag ${DOCKER_IMAGE}:latest ${DOCKER_IMAGE}:${BUILD_NUMBER}
                    docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploy stage (customize this)"
                // Example:
                // sh "kubectl apply -f k8s/"
                // or SSH deploy
            }
        }
    }

    post {
        success {
            echo "✅ Build Success"
        }
        failure {
            echo "❌ Build Failed"
        }
        always {
            cleanWs()
        }
    }
}