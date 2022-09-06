pipeline {
    agent any

    tools {
  maven 'Maven'
}

options {
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
}

    stages{
        stage("ExecuteSonarQubeReport"){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'SonarQube') {
                     sh "mvn sonar:sonar"
                    }
                }
            }
        }

        stage("Check code"){
            steps{
                script{
                    timeout(time: 1, unit: 'HOURS'){
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

        stage("Docker build & Docker push"){
            steps{
                script{
                    withCredentials([string(credentialsId: 'Nexus', variable: 'Nexus')]) {
                        sh '''
                          docker build -t 43.205.127.177:8083/mavenwebapplication:${BUILD_NUMBER} .
                          docker login -u admin -p $Nexus 43.205.127.177:8083
                          docker push 43.205.127.177:8083/mavenwebapplication:${BUILD_NUMBER}
                          docker rmi 43.205.127.177:8083/mavenwebapplication:${BUILD_NUMBER}
                        '''
                    }
                }
            }
        }

            stage("Datree Validation"){
                steps{
                    script{
                        sh 'helm datree test helmcharts/'
                    }
                }
            }
    }
}
