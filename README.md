# Mark's Framework

A reusable full-stack framework for building Azure-based web applications with React, TypeScript, and Azure Functions.

## Features

- **Monorepo Structure**: NPM workspaces with `web`, `api`, and `shared` packages
- **Frontend**: React 18 + Vite + TailwindCSS + React Query
- **Backend**: Azure Functions v4 with TypeScript
- **Shared Types**: Type-safe contracts between frontend and backend
- **Local Development**: Azurite for Azure Storage emulation
- **Hot Reload**: Both frontend and backend with concurrent development

## Quick Start

### Prerequisites

- Node.js 18+ and npm 9+
- Azure Functions Core Tools
- Azurite (will be installed by setup script)

### Installation

```powershell
# Run the setup script
.\setup.ps1

# Or manually:
npm install
npm run build:shared
```

### Development

```powershell
# Start all development servers
npm run dev

# Or use the convenience script
.\dev.ps1
```

This starts:
- Frontend dev server at http://localhost:5173
- Azure Functions at http://localhost:7071
- Azurite (Azure Storage emulator)

### Individual Commands

```powershell
# Build all packages
npm run build

# Build individual packages
npm run build:web
npm run build:api
npm run build:shared

# Start/stop services
.\start.ps1
.\stop.ps1
```

## Project Structure

```
MarksFramework/
├── web/                 # React frontend
│   ├── src/
│   │   ├── App.tsx
│   │   ├── main.tsx
│   │   └── index.css
│   ├── index.html
│   ├── vite.config.ts
│   └── tailwind.config.js
├── api/                 # Azure Functions backend
│   ├── src/
│   │   └── index.ts
│   ├── host.json
│   └── local.settings.json
├── shared/              # Shared TypeScript types
│   └── src/
│       ├── types/
│       └── index.ts
├── azurite/            # Local Azure Storage data
├── package.json        # Root workspace config
└── tsconfig.base.json  # Base TypeScript config
```

## Technology Stack

### Frontend
- React 18.2 with TypeScript
- Vite 5 for build tooling
- TailwindCSS 3.4 with dark mode
- React Router DOM 6.21
- TanStack React Query 5.17
- React Quill for rich text editing
- DnD Kit for drag-and-drop
- Additional utilities: marked, diff, html2canvas, jsPDF

### Backend
- Azure Functions v4
- Azure Data Tables & Blob Storage
- OpenAI SDK for AI features
- JWT authentication
- TypeScript with esbuild bundling

### Development
- Azurite for local Azure Storage
- Concurrently for running multiple dev servers
- Hot module replacement
- TypeScript strict mode

## Available Scripts

### Root Level
- `npm run dev` - Start all dev servers
- `npm run build` - Build all packages
- `npm run clean` - Clean build artifacts

### Web Package
- `npm run dev --workspace=web` - Start Vite dev server
- `npm run build --workspace=web` - Build for production
- `npm run preview --workspace=web` - Preview production build

### API Package
- `npm run start --workspace=api` - Start Azure Functions
- `npm run build --workspace=api` - Compile TypeScript
- `npm run bundle --workspace=api` - Bundle with esbuild

### Shared Package
- `npm run build --workspace=shared` - Build shared types
- `npm run watch --workspace=shared` - Watch mode

## Configuration

### Environment Variables

API (`api/local.settings.json`):
```json
{
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "JWT_SECRET": "your-secret-here"
  }
}
```

### Vite Proxy

The frontend proxies `/api` requests to the Azure Functions backend running on port 7071.

### TypeScript Path Aliases

- `@/*` - Web package source files
- `@shared/*` - Shared types

## Deployment

This framework is designed to deploy to:
- **Azure Static Web Apps** (frontend)
- **Azure Functions** (backend)
- **Azure Storage** (tables and blobs)
- **Azure Key Vault** (secrets)

See `framework.md` for detailed deployment instructions.

## Customization

This is a framework template. Customize it by:
1. Adding your routes in `web/src/App.tsx`
2. Creating Azure Functions in `api/src/`
3. Defining your types in `shared/src/types/`
4. Updating the TailwindCSS theme in `web/tailwind.config.js`
5. Adding dependencies as needed

## License

MIT
