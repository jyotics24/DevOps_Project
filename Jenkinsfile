pipeline {
    // Run pipeline on any available Jenkins agent
    agent any

    // Environment variables (AWS credentials from Jenkins)
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')      // AWS access key
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')      // AWS secret key
        AWS_DEFAULT_REGION    = 'ap-south-1'                        // AWS region
    }

    stages {

        stage('Clone GitHub Repo') {
            steps {
                // Clone the GitHub repository
                git branch: 'main',
                    url: 'https://github.com/your-username/terraform-jenkins-docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image that contains Terraform
                sh 'docker build -t terraform-image .'
            }
        }

        stage('Run Terraform') {
            steps {
                // Run Docker container and execute Terraform inside it
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
