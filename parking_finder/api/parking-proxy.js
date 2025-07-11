/**
 * Vercel Function for CORS Proxy
 * Proxies requests to Korean public data APIs with proper CORS headers
 */
export default async function handler(req, res) {
  // Handle preflight requests
  if (req.method === 'OPTIONS') {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    res.status(200).end();
    return;
  }

  // Only allow GET requests for the proxy
  if (req.method !== 'GET') {
    res.status(405).json({ error: 'Method not allowed' });
    return;
  }

  try {
    const { url, ...queryParams } = req.query;
    
    if (!url) {
      res.status(400).json({ error: 'URL parameter is required' });
      return;
    }

    // Construct the target URL with query parameters
    const targetUrl = new URL(decodeURIComponent(url));
    
    // Add query parameters to the target URL
    Object.entries(queryParams).forEach(([key, value]) => {
      if (key !== 'url') {
        targetUrl.searchParams.set(key, value);
      }
    });

    console.log('Proxying request to:', targetUrl.toString());

    // Make the request to the target API
    const response = await fetch(targetUrl.toString(), {
      method: 'GET',
      headers: {
        'User-Agent': 'ParkingFinderApp/1.0',
        'Accept': 'application/json, text/plain, */*',
      },
    });

    const responseText = await response.text();
    
    // Set CORS headers
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    
    // Set content type based on response
    const contentType = response.headers.get('content-type') || 'application/json';
    res.setHeader('Content-Type', contentType);

    // Return the response with appropriate status
    res.status(response.status);
    
    // Try to parse as JSON, fallback to plain text
    try {
      const jsonData = JSON.parse(responseText);
      res.json(jsonData);
    } catch {
      res.send(responseText);
    }
    
  } catch (error) {
    console.error('Proxy error:', error);
    
    // Set CORS headers even for error responses
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    
    res.status(500).json({ 
      error: 'Proxy request failed',
      message: error.message 
    });
  }
}