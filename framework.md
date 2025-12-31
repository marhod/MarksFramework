# Framework & Technology Stack Blueprint

This document describes the complete technology stack and framework elements used in this application, enabling easy replication for future projects.

## **Architecture Pattern**
- **Monorepo Structure**: NPM workspaces with three packages (`web`, `api`, `shared`)
- **Deployment**: Azure Static Web Apps (frontend + serverless functions)
- **Development**: Concurrently run frontend and backend with hot reload

---

## **Frontend (Web)**

### **Core Framework**
- **React 18.2** with TypeScript 5.3
- **Vite 5** for build tooling and dev server
- **React Router DOM 6.21** for routing

### **State Management & Data Fetching**
- **TanStack React Query 5.17** (data fetching, caching, synchronization)
- **React Context API** for auth and theme management

### **Styling**
- **TailwindCSS 3.4** with custom design system
- **PostCSS** + **Autoprefixer**
- Dark mode support via `class` strategy
- Custom color palette:
  - Primary: Blue scale (50-950)
  - Accent: Green scale (50-950)
- Utility classes: `.btn`, `.btn-primary`, `.btn-secondary`, `.btn-ghost`, `.input`, `.card`, `.badge`

### **Rich Content Editing**
- **React Quill 2.0** for WYSIWYG editing
- **Quill Better Table** for table support
- **Marked 17** for markdown parsing
- **React Markdown** with **remark-gfm** for display
- **Turndown** for HTML to markdown conversion
- **DOMPurify** for sanitization

### **UI Features**
- **@dnd-kit** (core, sortable, utilities) for drag-and-drop
- **html2canvas** + **jsPDF** for PDF export
- **diff** library for content comparison
- **clsx** for conditional classNames

### **Configuration**
```typescript
// Vite proxy setup
server: {
  port: 5173,
  proxy: {
    '/api': 'http://localhost:7071'
  }
}

// Path aliases
resolve: {
  alias: {
    '@': './src',
    '@km/shared': '../shared/src'
  }
}
```

---

## **Backend (API)**

### **Core Framework**
- **Azure Functions v4** (Node.js)
- **TypeScript 5.3** with ES2022 target
- **esbuild** for production bundling

### **Azure Services**
- **@azure/data-tables** - Table Storage for structured data
- **@azure/storage-blob** - Blob Storage for file attachments
- **@azure/keyvault-secrets** - Key Vault for secrets
- **@azure/identity** - Azure authentication

### **Additional Services**
- **OpenAI SDK 6.10** for AI features
- **jsonwebtoken 9.0** for JWT auth
- **marked 17** for markdown processing
- **ulid 2.3** for unique identifiers

### **Function Structure**
- HTTP-triggered functions in separate files
- Centralized registration via index.ts
- Middleware pattern for auth
- Service layer for storage operations

---

## **Shared Types Package**

### **Purpose**
Type-safe contract between frontend and backend

### **Structure**
```
shared/src/types/
  - activity.ts
  - ai.ts, api.ts
  - attachment.ts, auth.ts
  - customer.ts, connectwise.ts
  - dashboard.ts
  - magic-link.ts, page.ts
  - search.ts, etc.
```

### **Build**
TypeScript with declaration files, Node module resolution

---

## **Development Environment**

### **Local Services**
- **Azurite** for Azure Storage emulation (tables, blobs, queues)
- Persistent data in `./azurite` directory

### **Scripts (PowerShell)**
- `dev.ps1` - Start development servers
- `setup.ps1` - Initial setup
- `start.ps1` / `stop.ps1` - Service management

### **TypeScript Config**
- Base config extends across all packages
- Strict mode enabled
- ES2022 target
- NodeNext module resolution
- Source maps and declarations

---

## **Infrastructure (Azure)**

### **Deployment via Bicep**
- **Static Web App** (eastasia region optimized)
- **Function App** with App Service Plan
- **Storage Account** (Standard_LRS, Hot tier)
  - Table Services
  - Blob Services
- **Key Vault** for secrets
- **Application Insights** for monitoring

### **Security**
- TLS 1.2 minimum
- Public blob access disabled
- X-Content-Type-Options and X-Frame-Options headers
- JWT-based authentication

---

## **Key Features & Patterns**

### **Authentication**
- JWT tokens with role-based access (Admin, User, CustomerViewer)
- Magic link authentication for external users
- Auth middleware for API protection
- Auth context in React

### **UI/UX Patterns**
- Theme provider with dark mode toggle
- Responsive layout with navigation
- Modal dialogs for confirmations
- Toast notifications
- Search with autocomplete
- Breadcrumb navigation
- Activity feeds

### **Content Management**
- Multiple content types (Markdown, SOPs, Runbooks, Checklists)
- Version control with diff display
- Attachment handling
- Tag system
- Wiki-style internal linking
- Related pages suggestions
- AI-powered features

### **Developer Experience**
- Hot module replacement
- TypeScript throughout
- Shared type definitions
- Monorepo with workspace commands
- Comprehensive npm scripts

---

## **Complete Package Dependencies**

### **Root package.json**
```json
{
  "workspaces": ["shared", "api", "web"],
  "scripts": {
    "dev": "concurrently \"npm run dev:api\" \"npm run dev:web\"",
    "build": "npm run build --workspaces"
  },
  "devDependencies": {
    "concurrently": "^8.2.2",
    "typescript": "^5.3.3"
  }
}
```

### **Web package.json**
```json
{
  "dependencies": {
    "@dnd-kit/core": "^6.3.1",
    "@dnd-kit/sortable": "^10.0.0",
    "@dnd-kit/utilities": "^3.2.2",
    "@tanstack/react-query": "^5.17.0",
    "clsx": "^2.1.0",
    "diff": "^8.0.2",
    "dompurify": "^3.3.0",
    "html2canvas": "^1.4.1",
    "jspdf": "^3.0.4",
    "marked": "^17.0.1",
    "quill-better-table": "^1.2.10",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-markdown": "^9.0.1",
    "react-quill": "^2.0.0",
    "react-router-dom": "^6.21.1",
    "remark-gfm": "^4.0.1",
    "turndown": "^7.2.2"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.2.1",
    "autoprefixer": "^10.4.16",
    "postcss": "^8.4.32",
    "tailwindcss": "^3.4.0",
    "typescript": "^5.3.3",
    "vite": "^5.0.10"
  }
}
```

### **API package.json**
```json
{
  "dependencies": {
    "@azure/data-tables": "^13.2.2",
    "@azure/identity": "^4.0.1",
    "@azure/keyvault-secrets": "^4.8.0",
    "@azure/storage-blob": "^12.17.0",
    "jsonwebtoken": "^9.0.2",
    "marked": "^17.0.1",
    "openai": "^6.10.0",
    "ulid": "^2.3.0"
  },
  "devDependencies": {
    "@azure/functions": "^4.5.0",
    "azure-functions-core-tools": "^4.0.5455",
    "esbuild": "^0.24.0",
    "typescript": "^5.3.3"
  }
}
```

---

## **Quick Start Template**

### **1. Initialize Project Structure**
```bash
# Create project directory
mkdir my-project
cd my-project

# Initialize root package
npm init -y

# Create workspace structure
mkdir -p web/src api/src shared/src
```

### **2. Configure Root Workspace**
```json
{
  "name": "my-project",
  "private": true,
  "workspaces": ["shared", "api", "web"],
  "scripts": {
    "dev": "concurrently \"npm run dev:api\" \"npm run dev:web\"",
    "dev:web": "npm run dev --workspace=web",
    "dev:api": "npm run start --workspace=api",
    "build": "npm run build --workspaces"
  }
}
```

### **3. Install Dependencies**
```bash
# Root dependencies
npm install -D concurrently typescript

# Web dependencies
npm install --workspace=web react react-dom react-router-dom @tanstack/react-query clsx
npm install --workspace=web -D vite @vitejs/plugin-react typescript tailwindcss postcss autoprefixer

# API dependencies
npm install --workspace=api @azure/functions @azure/data-tables @azure/storage-blob @azure/identity jsonwebtoken
npm install --workspace=api -D typescript azure-functions-core-tools esbuild

# Shared dependencies
npm install --workspace=shared -D typescript
```

### **4. Configure TypeScript**
Create `tsconfig.base.json`:
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022"],
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "declaration": true,
    "sourceMap": true
  }
}
```

### **5. Configure Vite**
Create `web/vite.config.ts`:
```typescript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@shared': path.resolve(__dirname, '../shared/src'),
    },
  },
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://localhost:7071',
        changeOrigin: true,
      },
    },
  },
});
```

### **6. Initialize TailwindCSS**
```bash
cd web
npx tailwindcss init -p
```

Configure `tailwind.config.js`:
```javascript
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: {
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
        },
        accent: {
          500: '#22c55e',
          600: '#16a34a',
        },
      },
    },
  },
};
```

### **7. Setup Azure Functions**
Create `api/host.json`:
```json
{
  "version": "2.0",
  "extensionBundle": {
    "id": "Microsoft.Azure.Functions.ExtensionBundle",
    "version": "[4.*, 5.0.0)"
  }
}
```

### **8. Start Development**
```bash
# Install Azurite
npm install -g azurite

# Start local storage
azurite --silent --location ./azurite

# Start dev servers
npm run dev
```

---

## **Deployment Checklist**

- [ ] Configure Azure Static Web Apps resource
- [ ] Set up Storage Account (tables + blobs)
- [ ] Create Key Vault for secrets
- [ ] Configure Application Insights
- [ ] Set up GitHub Actions or Azure DevOps pipeline
- [ ] Configure environment variables
- [ ] Set up custom domain (optional)
- [ ] Enable authentication providers
- [ ] Configure CORS policies
- [ ] Set up monitoring and alerts

---

## **Best Practices Applied**

1. **Type Safety**: Shared types ensure consistency between frontend and backend
2. **Code Organization**: Clear separation of concerns with service layers
3. **Security**: JWT authentication, secure headers, minimal permissions
4. **Performance**: React Query caching, lazy loading, code splitting
5. **Developer Experience**: Hot reload, TypeScript, comprehensive tooling
6. **Scalability**: Serverless architecture, Azure managed services
7. **Maintainability**: Consistent patterns, documented code, monorepo structure
8. **Testing**: Jest configured for unit tests (extensible)
9. **Accessibility**: Semantic HTML, keyboard navigation support
10. **Responsive Design**: Mobile-first approach with Tailwind

---

This framework provides a solid foundation for building modern, scalable web applications with Azure cloud services.
