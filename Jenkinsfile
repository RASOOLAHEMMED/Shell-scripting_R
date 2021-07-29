pipeline {
  agent any

  stages {

    stage('Terraform INIT') {
      steps {
        sh 'cd  roboshop ; terraform init'
      }
    }

    stage('Terraform Destroy') {
      steps {
        sh '''
          cd roboshop
          terraform destroy -auto-approve
        '''
      }
    }

  }
}