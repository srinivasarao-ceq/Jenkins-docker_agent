pipeline{
    agent{
        dockerfile true 
    }

    parameters{
        string(name: 'REGION', defaultValue: 'ap-southeast-1', description: 'Select the region')
    }

    environment{
        AWS_DEFAULT_REGION = "${params.REGION}" // Set your desired AWS region
        AWS_CONFIGURE = credentials('aws_credentials')
        // SSH_KEY_CREDENTIAL = credentials('ansible_node_ec2-user')  // Use the credential ID
    }

    stages{
        stage('Install AWS'){
            steps{
                sh '''aws --version
                terraform --version'''
            }
        }
    }
}
