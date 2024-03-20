pipeline {
  agent {
    kubernetes {
      // Without cloud, Jenkins will pick the first cloud in the list
      cloud "devops-k8s"
      label "jenkins-agent"
      yamlFile "jenkins-build-pod.yaml"
    }
  }

  stages {
    stage("Build") {
      steps {
        dir("python-test") {
          container("gcloud") {
            // Cheat by using Cloud Build to help us build our container
            sh "gcloud builds submit -t ${params.IMAGE_URL}:${GIT_COMMIT}"
          }
        }
      }
    }

    stage("Deploy") {
      steps {
        container("kubectl") {
          sh """cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: python-test
spec:
  replicas: 2
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  selector:
    matchLabels:
      app: python-test
  template:
    metadata:
      labels:
        app: python-test
    spec:
      containers:
      - name: python-test
        imagePullPolicy: Always
        image: ${params.IMAGE_URL}:${GIT_COMMIT}
        ports:
        - containerPort: 5000
          protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: python-test
spec:
  selector:
    app: python-test
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
  type: NodePort
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: basic-ingress
spec:
  defaultBackend:
    service:
      name: python-test
      port:
        number: 80
"""
          sh "kubectl rollout status deployments/hello-app"
        }
      }
    }
  }
}
