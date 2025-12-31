# Contributing Guide

## Getting Started

### Prerequisites

- Node.js 18-20 (use `nvm` to manage versions)
- npm 9+
- Azure Functions Core Tools
- Git

### Initial Setup

```powershell
# Clone the repository
git clone https://github.com/YOUR_USERNAME/MarksFramework.git
cd MarksFramework

# Run setup script
.\setup.ps1

# Start development
.\dev.ps1
```

## Project Structure

```
marks-framework/
├── shared/          # Shared TypeScript types
│   └── src/
│       ├── index.ts
│       └── types/   # Domain types
├── api/             # Azure Functions backend
│   └── src/
│       └── index.ts
├── web/             # React frontend
│   └── src/
│       ├── App.tsx
│       └── main.tsx
└── scripts/         # Build and deployment scripts
```

## Development Workflow

### Making Changes

1. **Create a branch** for your feature or fix
   ```powershell
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** in the appropriate package

3. **Test locally** with `npm run dev`

4. **Build** to verify everything compiles
   ```powershell
   npm run build
   ```

5. **Commit** with a clear message
   ```powershell
   git commit -m "Add feature: description"
   ```

### Adding New Types (shared package)

1. Create new type file in `shared/src/types/`
2. Export from `shared/src/index.ts`
3. Rebuild shared package: `npm run build:shared`
4. Use in api or web packages

### Adding New API Endpoints

1. Add function in `api/src/index.ts` or new file
2. Import types from `@shared` package
3. Follow RESTful conventions
4. Add error handling
5. Test with local Azure Functions

### Adding New UI Components

1. Create component in `web/src/`
2. Import types from `@shared` package
3. Use Tailwind for styling
4. Ensure responsive design
5. Test in dev server

## Code Style

### TypeScript

- Use explicit types, avoid `any`
- Prefer interfaces over types for object shapes
- Use `const` over `let` when possible
- Descriptive variable names

### React

- Functional components with hooks
- Props interfaces exported
- Handle loading and error states
- Accessibility attributes

### Naming Conventions

- **Files**: `kebab-case.ts` or `PascalCase.tsx` (React components)
- **Functions**: `camelCase`
- **Types/Interfaces**: `PascalCase`
- **Constants**: `UPPER_SNAKE_CASE`

## Testing

### Running Tests

```powershell
npm test
```

### Writing Tests

- Unit tests for shared utilities
- Integration tests for API endpoints
- Component tests for React components

## Pull Request Process

1. Ensure your code builds without errors
2. Update documentation if needed
3. Add tests for new functionality
4. Push your branch
5. Create a pull request with:
   - Clear title describing the change
   - Description of what changed and why
   - Link to related issues

## Common Tasks

### Updating Dependencies

```powershell
npm update
npm run build  # Verify everything still works
```

### Adding a New Package Dependency

```powershell
# For shared package
npm install <package> --workspace=shared

# For API
npm install <package> --workspace=api

# For web
npm install <package> --workspace=web
```

### Debugging

- **Frontend**: Use browser DevTools
- **Backend**: Use VS Code debugger or console.log
- **Types**: Check TypeScript errors in VS Code

## Environment Variables

### Local Development

Create `api/local.settings.json` (gitignored):
```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "node"
  }
}
```

### Production

Set in Azure Functions configuration.

## Troubleshooting

### "Cannot find module '@shared'"

Run `npm run build:shared` to build the shared package.

### Port already in use

Stop existing dev servers or change ports in configuration.

### Azurite connection errors

Ensure Azurite is running: `azurite --silent --location ./azurite`

## Getting Help

- Check existing issues on GitHub
- Review documentation in README.md
- Check DESIGN_SPEC.md for architecture details

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
