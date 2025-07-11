const http = require('http');
const https = require('https');
const url = require('url');

const server = http.createServer((req, res) => {
  // CORS 헤더 설정
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  // Preflight 요청 처리
  if (req.method === 'OPTIONS') {
    res.writeHead(200);
    res.end();
    return;
  }

  // GET 요청만 허용
  if (req.method !== 'GET') {
    res.writeHead(405, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'Method not allowed' }));
    return;
  }

  const parsedUrl = url.parse(req.url, true);
  
  // /api/parking-proxy 경로만 처리
  if (!parsedUrl.pathname.startsWith('/api/parking-proxy')) {
    res.writeHead(404, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'Not found' }));
    return;
  }

  const targetUrl = parsedUrl.query.url;
  if (!targetUrl) {
    res.writeHead(400, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'URL parameter is required' }));
    return;
  }

  console.log('Proxying request to:', targetUrl);

  // 대상 URL에 요청
  const targetUrlParsed = url.parse(targetUrl);
  const isHttps = targetUrlParsed.protocol === 'https:';
  const httpModule = isHttps ? https : http;

  const options = {
    hostname: targetUrlParsed.hostname,
    port: targetUrlParsed.port || (isHttps ? 443 : 80),
    path: targetUrlParsed.path,
    method: 'GET',
    headers: {
      'User-Agent': 'ParkingFinderApp/1.0',
      'Accept': 'application/json, text/plain, */*'
    }
  };

  const proxyReq = httpModule.request(options, (proxyRes) => {
    console.log('Response status:', proxyRes.statusCode);
    
    // 응답 헤더 복사 (CORS 헤더 제외)
    const responseHeaders = { ...proxyRes.headers };
    delete responseHeaders['access-control-allow-origin'];
    delete responseHeaders['access-control-allow-methods'];
    delete responseHeaders['access-control-allow-headers'];
    
    // CORS 헤더 추가
    responseHeaders['Access-Control-Allow-Origin'] = '*';
    responseHeaders['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS';
    responseHeaders['Access-Control-Allow-Headers'] = 'Content-Type, Authorization';
    
    res.writeHead(proxyRes.statusCode, responseHeaders);
    proxyRes.pipe(res);
  });

  proxyReq.on('error', (err) => {
    console.error('Proxy error:', err);
    res.writeHead(500, { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    });
    res.end(JSON.stringify({ 
      error: 'Proxy request failed', 
      message: err.message 
    }));
  });

  proxyReq.end();
});

const PORT = 3001;
server.listen(PORT, () => {
  console.log(`Test proxy server running on http://localhost:${PORT}`);
  console.log('API endpoint: http://localhost:3001/api/parking-proxy?url=<encoded_url>');
});