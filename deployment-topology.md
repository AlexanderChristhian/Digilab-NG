# Digilab-NG Deployment Topology

This diagram shows the deployment architecture of Digilab-NG using Docker containers and their interactions.

```mermaid
graph TD
    subgraph Docker Network [app-network]
        frontend[Frontend Container<br>Nginx + React/Vite<br>Port: 2000:80]
        backend[Backend Container<br>Node.js<br>Port: 5000:5000]
        postgres[PostgreSQL Container<br>Port: 5432:5432]
        redis[Redis Container<br>Port: 6379:6379]
        
        %% Data volume
        pg_vol[(postgres_data<br>volume)]

        %% Dependencies
        frontend -->|depends on| backend
        backend -->|depends on| postgres
        backend -->|depends on| redis
        
        %% Volume connection
        postgres -.->|persists data| pg_vol

        %% Service interactions
        User((User)) -->|HTTP| frontend
        frontend -->|API calls| backend
        backend -->|queries| postgres
        backend -->|caching| redis
        
        %% Host directory mapping
        host_uploads[("Host Directory<br>./backend/uploads")] -.->|mapped to| backend
    end

    %% External Service
    cloudinary[(Cloudinary<br>Cloud Storage)]
    backend -.->|media storage| cloudinary
```

## Components

1. **Frontend Container**
   - Nginx serving React/Vite application
   - Port: 2000 (external), 80 (internal)
   - Depends on backend service

2. **Backend Container**
   - Node.js API server
   - Port: 5000
   - Depends on postgres and redis
   - Maps local uploads directory
   - Integrates with Cloudinary for media storage

3. **PostgreSQL Container**
   - Main database
   - Port: 5432
   - Uses persistent volume: postgres_data

4. **Redis Container**
   - Caching server
   - Port: 6379

5. **Host Directory Mapping**
   - Local path: ./backend/uploads
   - Container path: /app/uploads
   - Used for file uploads persistence

6. **External Services**
   - Cloudinary for cloud-based media storage

All services communicate through a Docker bridge network named 'app-network'.