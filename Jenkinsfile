pipeline {

    // Use any available Jenkins worker (agent)
    agent any

    // AWS credentials stored securely in Jenkins
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')      // AWS Access Key from Jenkins
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')      // AWS Secret Key from Jenkins
        AWS_DEFAULT_REGION    = 'ap-south-1'                        // AWS region
    }

    stages {

        stage('Build Docker Image') {
            steps {
                // Build Docker image using Dockerfile in this repo
                // This image will contain Terraform
                sh 'docker build -t terraform-image .'
            }
        }

        stage('Run Terraform') {
            steps {
                // Run Terraform inside Docker container
                // Pass AWS credentials to the container
                // Mount terraform folder to container
                sh '''
                docker run --rm \
                -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
                -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
                -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
                -v $(pwd)/terraform:/terraform \
                terraform-image \
                sh -c "terraform init && terraform apply -auto-approve"
                '''
            }
        }
    }
}
