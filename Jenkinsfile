pipeline {
    agent any

    tools {
  maven 'Maven'
}

    stages{
        stage("ExecuteSonarQubeReport"){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: '0b1ef999ad6e8a6ad54d336f0024dccd81470a15') {
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
