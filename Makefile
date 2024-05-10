DIR_HOME	:= /home/${USER}/data
DB			:= ${DIR_HOME}/db-volume
WP			:= ${DIR_HOME}/wordpress-volume
all:
	./srcs/setup.sh
	mkdir -m 770 -p ${DB} ${WP}
	docker compose -f srcs/docker-compose.yaml up -d
	echo "cmd to show logs: docker compose -f srcs/docker-compose.yaml logs -f"
up: all
down:
	docker compose -f srcs/docker-compose.yaml down
clean: 
	-docker compose -f srcs/docker-compose.yaml down
	-docker rmi --force $$(docker images -q "inception*")
	-docker volume rm inception_wordpress-volume inception_db-volume --force
	-rm -f /home/${USER}/data/*

setup:
	./srcs/setup.sh ""
re: clean
	docker compose -f srcs/docker-compose.yaml up -d --build
	

.PHONY: all re down up clean setup
