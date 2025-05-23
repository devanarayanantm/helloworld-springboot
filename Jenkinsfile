pipeline {
    agent any

    stages {

        stage('build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'f578ee61-e2c4-424a-b945-83625ba11cfa', passwordVariable: 'PW', usernameVariable: 'USERNAME')]) 
                {
                    sh '''
                    mvn clean install
                    docker login -u "$USERNAME" -p "$PW"
                    docker build -t devanarayanantm/spring-devan-img .
                    docker push devanarayanantm/spring-devan-img
                    '''
                }
            }
        }
        stage('run') {
            steps {
                sh '''
                kubectl apply -f deploy.yaml
                '''
            }
        }
    }
}
