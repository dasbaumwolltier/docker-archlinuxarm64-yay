pipeline {
    agent { label 'arm' }

    environment {
        CREDENTIAL_ID = 'docker-hub-upload'
    }

    stages {
        stage('Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: CREDENTIAL_ID, usernameVariable: 'HUB_USER', passwordVariable: 'HUB_PASS')]) {
                    sh 'set -x && chmod +x build.sh && ./build.sh'
                }
            }
        }
    }
}