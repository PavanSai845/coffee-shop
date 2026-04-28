pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/PavanSai845/coffee-shop.git'
            }
        }

        stage('Validate Files') {
            steps {
                sh '''
                if [ ! -f coffeewebsite.html ]; then
                  echo "❌ coffeewebsite.html not found"
                  exit 1
                fi
                echo "✅ coffeewebsite.html found"
                '''
            }
        }

        stage('Basic HTML Check') {
            steps {
                sh '''
                echo "Checking HTML structure..."
                grep -q "<html" coffeewebsite.html || (echo "❌ Missing <html> tag" && exit 1)
                grep -q "<head" coffeewebsite.html || (echo "❌ Missing <head> tag" && exit 1)
                grep -q "<body" coffeewebsite.html || (echo "❌ Missing <body> tag" && exit 1)
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