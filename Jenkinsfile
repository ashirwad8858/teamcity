pipeline {
  agent any
  tools {
        maven 'maven-1' // Replace with the name configured in Global Tool Configuration
    }

  stages {

    stage('Build Artifact - Maven') {
      steps {
        sh "mvn clean package -DskipTests=true"
        archive 'target/*.jar'
      }
    }

    stage('Unit Tests - JUnit and Jacoco') {
      steps {
        sh "mvn test"
      }
      post {
        always {
          junit 'target/surefire-reports/*.xml'
          jacoco execPattern: 'target/jacoco.exec'
        }
      }
    }
    stage('SonarQube'){
      steps{
        sh "mvn clean verify sonar:sonar \
  -Dsonar.projectKey=employee-java \
  -Dsonar.projectName='employee-java' \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.token=sqp_eb104fcf426dcb6a0606700d3e89c95cc16e5980"
      }
      
      
    }
    
    // stage('SonarQube - SAST') {
    //   steps {
    //     withSonarQubeEnv('sonarqube') {
    //       sh "mvn sonar:sonar \
    //           -Dsonar.projectKey=devsecops-numeric-application \
    //           -Dsonar.host.url=https://30012-port-9b3da16e5e284b6d.labs.kodekloud.com "
    //   }
    //     timeout(time: 2, unit: 'MINUTES') {
    //       script {
    //         waitForQualityGate abortPipeline: true
    //       }
    //     }
    //   }
    // }

    // stage('Docker image build and push') {
    //   steps {
    //     sh 'docker build -t docker-registry:5000/java-app:latest .'
    //     sh 'docker push docker-registry:5000/java-app:latest'
    //    }
    //  }
    // stage('Kubernetes Deployment - DEV') {
    //   steps {
    //     sh "sed -i 's#REPLACE_ME#docker-registry:5000/java-app:latest#g' k8s_deployment_service.yaml"
    //     sh "kubectl apply -f k8s_deployment_service.yaml"
    //   }
    // }
   }
 }
