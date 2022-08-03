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

        stage("Check code"){
            steps{
                    timeout(1){
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK'){
                        error "pipeline aborted due to quality Gate check failure : ${qg.status}"
                    }
                    else{
                        print "Quality Gate check is successful ${qg.status}. Procees to next stage"
                    } 
                }
            }
        }
    }
}