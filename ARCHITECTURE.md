# Architecture Overview

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Frontend                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  React App (Vite)                                     │  │
│  │  - Components, Pages, Routes                          │  │
│  │  - React Query (API client)                           │  │
│  │  - TailwindCSS                                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                          ↓ HTTP                             │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                      Azure Functions                         │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  HTTP Triggers                                        │  │
│  │  - Business Logic                                     │  │
│  │  - Validation                                         │  │
│  │  - Azure Service Integration                          │  │
│  └──────────────────────────────────────────────────────┘  │
│                          ↓                                   │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                    Azure Services                            │
│  - Storage (Blob, Queue, Table)                             │
│  - Cosmos DB / SQL Database                                 │
│  - Key Vault                                                │
│  - Application Insights                                     │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    Shared Package                            │
│  - Type Definitions (TypeScript)                            │
│  - API Contracts                                            │
│  - Domain Models                                            │
│  (Imported by both frontend and backend)                    │
└─────────────────────────────────────────────────────────────┘
```

## Data Flow

### Request Flow

1. User interacts with UI (React)
2. Component triggers action
3. React Query sends HTTP request
4. Request hits Azure Function endpoint
5. Function validates input (using shared types)
6. Function processes business logic
7. Function interacts with Azure services if needed
8. Function returns response (matching shared contract)
9. React Query caches response
10. UI updates with new data

### Type Safety Flow

```
Shared Types (TypeScript)
    ↓
┌───┴───────────────────────┐
↓                           ↓
API Function               React Component
(Implements types)         (Consumes types)
    ↓                           ↓
Returns typed response    Typed request/response
    └───────────┬───────────────┘
                ↓
        Compile-time checking
        ensures compatibility
```

## Package Dependencies

```
shared (no dependencies on other packages)
    ↑                    ↑
    │                    │
    │                    │
   api                  web
   ↓                     ↓
Azure Functions      React + Vite
```

## Development Architecture

### Local Development

```
Developer Machine
├── Terminal 1: Azurite (Azure Storage Emulator)
│   ├── Blob Storage: http://127.0.0.1:10000
│   ├── Queue Storage: http://127.0.0.1:10001
│   └── Table Storage: http://127.0.0.1:10002
│
├── Terminal 2: Azure Functions (API)
│   └── http://localhost:7071
│       └── /api/* endpoints
│
└── Terminal 3: Vite Dev Server (Web)
    └── http://localhost:5173
        └── React app with HMR
```

### Build Process

```
1. Build Shared Package
   └── npm run build:shared
       └── Compiles TypeScript to JavaScript
       └── Generates .d.ts type definitions

2. Build API (parallel with Web)
   └── npm run build:api
       └── Compiles TypeScript
       └── Outputs to api/dist/

3. Build Web (parallel with API)
   └── npm run build:web
       └── Vite builds React app
       └── Outputs to web/dist/
```

## Deployment Architecture

### Production

```
┌─────────────────────────────────────────────────┐
│              Azure Static Web Apps               │
│  or Azure Storage + CDN                         │
│  ┌───────────────────────────────────────────┐ │
│  │  Static Assets (HTML, CSS, JS)            │ │
│  │  - Bundled and minified                   │ │
│  │  - Served over CDN                        │ │
│  └───────────────────────────────────────────┘ │
└─────────────────────────────────────────────────┘
                    ↓ HTTPS
┌─────────────────────────────────────────────────┐
│           Azure Functions (Premium/Dedicated)    │
│  ┌───────────────────────────────────────────┐ │
│  │  Function App                             │ │
│  │  - Auto-scaling                           │ │
│  │  - Managed identity                       │ │
│  │  - VNet integration                       │ │
│  └───────────────────────────────────────────┘ │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│              Azure Services                      │
│  - Storage Account (production data)            │
│  - Cosmos DB / Azure SQL                        │
│  - Key Vault (secrets)                          │
│  - Application Insights (monitoring)            │
└─────────────────────────────────────────────────┘
```

## Security Architecture

### Authentication Flow

```
User → Frontend → Azure Functions → Azure AD B2C
                       ↓
                  Validates Token
                       ↓
              Authorized / Unauthorized
```

### Secrets Management

- Local: `local.settings.json` (gitignored)
- Production: Azure Key Vault
- Access: Managed Identity

## Monitoring & Observability

```
Application Insights
    ↑
    │ (Telemetry)
    │
┌───┴───────────────────────┐
│                           │
API Functions          Frontend
    │                       │
    ↓                       ↓
Logs, Metrics,         User Interactions,
Exceptions,            Performance,
Traces                 Errors
```

## Scalability

### Frontend

- Static assets on CDN
- Global distribution
- Browser caching
- Code splitting

### Backend

- Azure Functions auto-scale
- Horizontal scaling
- Stateless functions
- Queue-based processing for long-running tasks

### Database

- Cosmos DB: Global distribution, auto-scaling
- Azure SQL: Elastic pools, read replicas

## Extension Points

### Adding New Services

1. **Storage**: Already integrated via Azurite/Azure Storage
2. **Database**: Add connection in API, update types in shared
3. **Authentication**: Add middleware in API functions
4. **Background Jobs**: Add timer or queue triggers
5. **External APIs**: Add service clients in API

### Adding New Features

1. Define types in `shared/`
2. Implement API endpoint in `api/`
3. Create UI components in `web/`
4. Wire up with React Query

## Performance Optimization

### Frontend

- **Code Splitting**: Lazy load routes
- **Caching**: React Query caching + browser caching
- **Bundling**: Vite optimizes bundles automatically
- **CDN**: Serve static assets from CDN

### Backend

- **Cold Start**: Keep functions warm, use premium plan
- **Caching**: Add Redis for frequently accessed data
- **Database**: Index optimization, connection pooling
- **Parallel Processing**: Use Promise.all for concurrent operations

## Error Handling

```
Error Occurs
    ↓
Try-Catch in Function
    ↓
Log to Application Insights
    ↓
Return structured error response
    ↓
React Query error handling
    ↓
User-friendly error message in UI
```

## Testing Architecture

```
┌─────────────────────────────────────────────┐
│  Unit Tests                                  │
│  - Shared utilities                          │
│  - Pure functions                            │
│  - React components (isolated)               │
└─────────────────────────────────────────────┘
┌─────────────────────────────────────────────┐
│  Integration Tests                           │
│  - API endpoints                             │
│  - Database operations                       │
│  - Azure service integration                 │
└─────────────────────────────────────────────┘
┌─────────────────────────────────────────────┐
│  E2E Tests                                   │
│  - Critical user flows                       │
│  - Full stack testing                        │
└─────────────────────────────────────────────┘
```

## CI/CD Pipeline

```
Git Push
    ↓
GitHub Actions
    ↓
┌───┴─────────────────────────┐
│                             │
Build & Test               Lint & Type Check
│                             │
└───┬─────────────────────────┘
    ↓
Deploy to Staging
    ↓
Run E2E Tests
    ↓
Deploy to Production
    ↓
Health Check
```
