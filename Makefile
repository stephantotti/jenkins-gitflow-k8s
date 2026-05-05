.DEFAULT_GOAL := create

pre:
	@kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.15.3/config/manifests/metallb-native.yaml
	@kubectl wait --namespace metallb-system \
	  --for=condition=ready pod \
	  --selector=app=metallb \
	  --timeout=300s
	@sleep 10
	@kubectl apply -f manifests/
	
helm:
	@helmfile apply
	@kubectl wait --namespace ingress-nginx \
	  --for=condition=ready pod \
	  --selector=app.kubernetes.io/component=controller \
	  --timeout=300s

create:
	@kind create cluster --config cluster-config.yaml

up: create pre helm

destroy:
	@kind delete clusters kind

passwd:
	@echo "JENKINS:"
	@echo "admin"
	@kubectl get secret -n jenkins jenkins -ojson | jq -r '.data."jenkins-admin-password"' | base64 -d 
	@echo ""
	@echo "GITEA:"
	@echo "gitea_admin"
	@echo "r8sA8CPHD9!bt6d | jenkins: SK@dante2236" 
	@echo "HARBOR:"
	@echo "admin"
	@echo "Harbor12345"
	@echo "SONARQUBE:"
	@echo "admin"
	@echo "SK@dante2236"
	@echo "ARGOCD:"
	@echo "admin"
	@kubectl get secret -n argocd argocd-initial-admin-secret -ojson | jq -r '.data.password' | base64 -d