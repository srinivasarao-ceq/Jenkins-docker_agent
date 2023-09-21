pipeline{
    agent{
        docker{
            image 'ubuntu:latest'  // Specify the Docker image you want to use
            args '-u root'        // Optional: Run the container as root
        }
    }

    parameters{
        string(name: 'REGION', defaultValue: 'ap-southeast-1', description: 'Select the region')
    }

    environment{
        AWS_DEFAULT_REGION = "${params.REGION}" // Set your desired AWS region
        AWS_CONFIGURE = credentials('aws_credentials')
        // SSH_KEY_CREDENTIAL = credentials('ansible_node_ec2-user')  // Use the credential ID
    }

    stage{
        stage('Install AWS'){
            steps{
                 sh '''curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                 unzip awscliv2.zip
                 sudo ./aws/install'''
            }          
        }
    }
}