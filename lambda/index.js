exports.handler = async (event, context, callback) => {
    //console.log('Received event:', JSON.stringify(event, null, 2));

    let body;
    let bodyObj;
    let statusCode = '200';
    const headers = {
        'Content-Type': 'application/json',
    };

    try {
        switch (event.httpMethod) {
            case 'DELETE':
                break;
            case 'GET':
                body = "Hello from GET Lambda!"
                break;
            case 'POST':
                body = "Hello from POST Lambda!"
                break;
            case 'PUT':
                break;
            default:
                throw new Error(`Unsupported method "${event.httpMethod}"`);
        }
    } catch (err) {
        statusCode = '400';
        body = err.message;
    } finally {}
    
    try{
        const retResults = {
            results: body
        }
        const response = {
            statusCode: statusCode,
            body: JSON.stringify(body),
            headers: headers
        };
        return response;
      } catch (_err) {
        console.error(_err);
      }
};

class ErrorResponse {
  constructor(
    message = 'An error occurred',
    statusCode = 500,
  ) {
    const body = JSON.stringify({ message });
    this.statusCode = statusCode;
    this.body = body;
    this.headers = {
      'Content-Type': 'application/json',
    };
  }
}exports.handler = async (event, context, callback) => {
    //console.log('Received event:', JSON.stringify(event, null, 2));

    let body;
    let bodyObj;
    let statusCode = '200';
    const headers = {
        'Content-Type': 'application/json',
    };

    try {
        switch (event.httpMethod) {
            case 'DELETE':
                break;
            case 'GET':
                body = "Hello from GET Lambda!"
                break;
            case 'POST':
                body = "Hello from POST Lambda!"
                break;
            case 'PUT':
                break;
            default:
                throw new Error(`Unsupported method "${event.httpMethod}"`);
        }
    } catch (err) {
        statusCode = '400';
        body = err.message;
    } finally {}
    
    try{
        const response = {
            statusCode: statusCode,
            body: JSON.stringify(retResults),
            headers: headers
            
        };
        return response;
      } catch (_err) {
        console.error(_err);
      }
};

class ErrorResponse {
  constructor(
    message = 'An error occurred',
    statusCode = 500,
  ) {
    const body = JSON.stringify({ message });
    this.statusCode = statusCode;
    this.body = body;
    this.headers = {
      'Content-Type': 'application/json',
    };
  }
}
