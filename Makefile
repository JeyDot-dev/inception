all:
	mkdir -p /home/${USER}/data/wordpress-volume
	mkdir -p /home/${USER}/data/db-volume
	docker compose -f srcs/docker-compose.yaml up -d
	echo "cmd to show logs: docker compose -f srcs/docker-compose.yaml logs -f"
up: all
down:
	docker compose -f srcs/docker-compose.yaml down
clean: 
	-docker compose -f srcs/docker-compose.yaml down
	-docker rmi --force $$(docker images -q "inception*")
	-docker volume rm inception_wordpress-volume inception_db-volume --force
	-rm -f /home/${USER}/data/*/*

re: clean
	docker compose -f srcs/docker-compose.yaml up -d --build
	

.PHONY: all re down up clean
