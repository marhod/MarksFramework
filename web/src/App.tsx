import { Routes, Route } from 'react-router-dom';

function App() {
  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-4xl font-bold text-gray-900 dark:text-white">
          Welcome to the Framework
        </h1>
        <p className="mt-4 text-gray-600 dark:text-gray-400">
          Your application is ready to be built!
        </p>
        
        <Routes>
          <Route path="/" element={<div>Home Page</div>} />
          {/* Add your routes here */}
        </Routes>
      </div>
    </div>
  );
}

export default App;
