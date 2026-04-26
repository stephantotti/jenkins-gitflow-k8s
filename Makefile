.DEFAULT_GOAL := create

create:
	@kind create cluster --config cluster-config.yaml # O @ serve para criar o cluster usando o Kind com a configuração especificada sem jogar na tela a saída do comando. "echo Criando cluster"

destroy:
	@kind delete clusters kind