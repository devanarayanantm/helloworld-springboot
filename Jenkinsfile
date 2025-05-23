pipeline {
    agent any

    stages {
        stage('Service') {
            steps {
		kubectl delete -f svc.yaml --ignore-not-found
		kubectl apply -f svc.yaml
            }
        }
    }
}
