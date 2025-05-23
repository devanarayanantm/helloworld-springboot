pipeline {
    agent any

    stages {
        stage('Service') {
            steps {
		sh '''
		kubectl delete -f svc.yaml --ignore-not-found
		kubectl apply -f svc.yaml
		'''
            }
        }
    }
}
