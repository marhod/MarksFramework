import { app, HttpRequest, HttpResponseInit, InvocationContext } from '@azure/functions';

// Example HTTP triggered function
export async function httpTrigger(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);

    const name = request.query.get('name') || await request.text() || 'world';

    return { 
        status: 200,
        jsonBody: {
            message: `Hello, ${name}!`
        }
    };
}

app.http('httpTrigger', {
    methods: ['GET', 'POST'],
    authLevel: 'anonymous',
    handler: httpTrigger
});

// Register additional functions here
// Example: app.http('users', { ... });
