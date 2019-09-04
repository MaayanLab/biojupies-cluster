# biojupies-cluster

This `docker-compose.yml` will be used to document and test the entire standalone application deployment.

`.env.example` should be copied to `.env` and completed with relevant credentials and secrets.

## Usage
```
# Start database
docker-compose up -d mysql

# Wait for it to initialize
sleep 10

# Start everything else
docker-compose up
```
