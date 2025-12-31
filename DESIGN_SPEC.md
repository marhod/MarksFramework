# Design Specification

## Overview

Mark's Framework is a full-stack TypeScript framework designed for rapid development of Azure-based web applications. It provides a solid foundation with modern tooling, type safety, and Azure integration.

## Architecture

### Monorepo Structure

The project uses NPM workspaces to manage three interconnected packages:

```
marks-framework/
├── shared/     # Shared types and utilities
├── api/        # Azure Functions backend
└── web/        # React frontend
```

### Design Principles

1. **Type Safety**: Full TypeScript coverage across frontend, backend, and shared code
2. **Developer Experience**: Hot reload, concurrent dev servers, minimal configuration
3. **Azure First**: Built specifically for Azure deployment
4. **Modularity**: Clean separation between packages with well-defined interfaces
5. **Convention over Configuration**: Sensible defaults with escape hatches

## Technology Stack

### Frontend (`web/`)

- **React 18**: Modern React with hooks and concurrent features
- **Vite**: Fast build tool and dev server
- **TailwindCSS**: Utility-first styling
- **React Query**: Server state management
- **TypeScript**: Type safety and IntelliSense

**Rationale**: This stack provides excellent DX with fast hot reload, small bundle sizes, and type safety.

### Backend (`api/`)

- **Azure Functions v4**: Serverless compute
- **TypeScript**: Consistent language across stack
- **Node.js 18-20**: LTS versions for stability

**Rationale**: Azure Functions provide cost-effective scaling and easy Azure service integration.

### Shared (`shared/`)

- **TypeScript**: Type definitions and contracts
- **Exported Types**: API interfaces, domain models, utility types

**Rationale**: Ensures frontend and backend stay in sync with compile-time type checking.

## Key Design Decisions

### 1. Monorepo vs. Separate Repos

**Decision**: Monorepo with NPM workspaces

**Reasoning**:
- Shared types between frontend and backend
- Atomic commits across the stack
- Simplified dependency management
- Single CI/CD pipeline

### 2. Local Development

**Decision**: Azurite for Azure Storage emulation

**Reasoning**:
- No cloud costs during development
- Fast feedback loop
- Offline development capability
- Consistent with production environment

### 3. Build Strategy

**Decision**: Build shared package first, then frontend and backend independently

**Reasoning**:
- Shared types must exist before they can be imported
- Parallel builds for frontend and backend
- Clear dependency chain

### 4. Node Version Constraint

**Decision**: Node 18-20 (>=18.0.0 <21.0.0)

**Reasoning**:
- Azure Functions v4 compatibility
- LTS version stability
- Modern JavaScript features
- ARM64 support

## Package Responsibilities

### Shared Package

**Purpose**: Type definitions and shared utilities

**Exports**:
- API request/response types
- Domain model interfaces
- Utility types and helpers
- Constants and enums

**Rules**:
- No runtime dependencies on frontend or backend
- Pure TypeScript (no runtime code unless universally useful)
- Zero external dependencies when possible

### API Package

**Purpose**: Backend business logic and Azure Functions

**Responsibilities**:
- HTTP triggers and function endpoints
- Business logic and data processing
- Azure service integration
- Authentication and authorization
- Data validation

**Rules**:
- Import types from `shared` package
- Return types matching shared contracts
- Handle errors gracefully
- Log appropriately

### Web Package

**Purpose**: User interface and client-side logic

**Responsibilities**:
- UI components and pages
- Client-side routing
- API communication
- State management
- User interactions

**Rules**:
- Import types from `shared` package
- Use React Query for server state
- Responsive design
- Accessibility considerations

## API Design

### RESTful Conventions

- **GET**: Retrieve resources
- **POST**: Create resources
- **PUT/PATCH**: Update resources
- **DELETE**: Remove resources

### Response Format

```typescript
{
  success: boolean;
  data?: T;
  error?: string;
  timestamp: string;
}
```

### Error Handling

- 200: Success
- 400: Bad request (validation errors)
- 401: Unauthorized
- 403: Forbidden
- 404: Not found
- 500: Internal server error

## Frontend Patterns

### Component Structure

```
ComponentName/
├── ComponentName.tsx
├── ComponentName.module.css (if needed)
└── index.ts (re-export)
```

### State Management

- **Local State**: useState for component-specific state
- **Server State**: React Query for API data
- **Global State**: Context API or state management library if needed

## Development Workflow

1. Make changes in any package
2. Hot reload triggers automatically
3. TypeScript compiler checks types
4. Save and test in browser
5. Build shared package if types changed

## Deployment Strategy

### Frontend

- Build with Vite
- Deploy to Azure Static Web Apps or Azure Storage + CDN
- Environment-specific configuration

### Backend

- Build with TypeScript compiler
- Deploy to Azure Functions
- Environment variables from Azure configuration

## Extension Points

The framework is designed to be extended:

1. **New API Endpoints**: Add functions in `api/src/`
2. **New Types**: Add to `shared/src/types/`
3. **New UI Pages**: Add to `web/src/`
4. **New Azure Services**: Integrate in API functions

## Security Considerations

- Input validation on all endpoints
- Authentication middleware
- CORS configuration
- Environment variable management
- Secrets in Azure Key Vault

## Performance Considerations

- Code splitting in frontend
- Lazy loading routes
- Caching strategies
- CDN for static assets
- Function cold start optimization

## Testing Strategy

- Unit tests for shared utilities
- Integration tests for API endpoints
- Component tests for React components
- E2E tests for critical user flows

## Future Enhancements

See [TODO.md](TODO.md) for planned improvements.
