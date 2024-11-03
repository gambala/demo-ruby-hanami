CONTAINER_NAME=demo-ruby-hanami
PORT=2300
ID_FILE=.container_id

dev:
	bin/dev

docker-build:
	docker build -t $(CONTAINER_NAME) .

docker-run:
	@echo "Running Docker container..."
	@docker run -dp $(PORT):$(PORT) $(CONTAINER_NAME) > $(ID_FILE)
	@echo "Container started: $$(cat $(ID_FILE))"

docker-stop:
	@if [ -f $(ID_FILE) ]; then \
		CONTAINER_ID=$$(cat $(ID_FILE)); \
		echo "Stopping Docker container: $$CONTAINER_ID"; \
		docker stop $$CONTAINER_ID; \
		rm $(ID_FILE); \
		echo "Container stopped."; \
	else \
		echo "No container ID file found. Is the container running?"; \
	fi
