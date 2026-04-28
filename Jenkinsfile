pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Validate Files') {
            steps {
                sh '''
                if [ ! -f index.html ]; then
                  echo "❌ index.html not found"
                  exit 1
                fi
                echo "✅ index.html found"
                '''
            }
        }

        stage('Basic HTML Check') {
            steps {
                sh '''
                echo "Checking HTML structure..."
                grep -q "<html" index.html || (echo "❌ Missing <html> tag" && exit 1)
                grep -q "<head" index.html || (echo "❌ Missing <head> tag" && exit 1)
                grep -q "<body" index.html || (echo "❌ Missing <body> tag" && exit 1)
                echo "✅ Basic HTML structure looks fine"
                '''
            }
        }

        stage('List Files') {
            steps {
                sh 'ls -l'
            }
        }
    }

    post {
        success {
            echo "✅ HTML project validation successful"
        }
        failure {
            echo "❌ Validation failed"
        }
    }
}