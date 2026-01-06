pipeline {

    // Use any available Jenkins worker (agent)
    agent any

    // AWS credentials stored securely in Jenkins
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')      // AWS Access Key
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')      // AWS Secret Key
        AWS_DEFAULT_REGION    = 'ap-south-1'                        // AWS region
    }

    stages {

        stage('Build Docker Image') {
            steps {
                // Build Docker image using Dockerfile in this repo
                sh 'docker build -t terraform-image .'
            }
        }

        stage('Run Terraform') {
            steps {
                // Run Terraform inside Docker container
                // -upgrade fixes provider version mismatch
                sh '''
                docker run --rm \
                -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
                -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
                -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
                -v $(pwd)/terraform:/terraform \
                terraform-image \
                sh -c "terraform init -upgrade && terraform apply -auto-approve"
                '''
            }
        }
    }
}
