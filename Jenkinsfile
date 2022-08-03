pipeline {
    agent any

    tools {
  maven 'Maven'
}

    stages{
        stage(ExecuteSonarQubeReport){
            steps{
                script{
                    withSonarQubeEnv('SonarQube') {
                     sh "mvn sonar:sonar"
                    }
                }
            }
        }
    }
}