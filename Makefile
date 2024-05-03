all:
	docker compose -f srcs/docker-compose.yaml up -d
	echo "cmd to show logs: docker compose -f srcs/docker-compose.yaml logs -f"
up: all
down:
	docker compose -f srcs/docker-compose.yaml down
clean: 
	docker compose -f srcs/docker-compose.yaml down
	docker rmi $$(docker images -q "inception*")
	docker volume rm inception_wordpress-volume inception_mariadb-volume

re: clean
	docker compose -f srcs/docker-compose.yaml up -d --build
	

.PHONY: all re down up clean
