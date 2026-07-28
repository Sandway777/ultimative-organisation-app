// Cloudflare Pages Function: sicherer Proxy zur Anthropic API.
// Haelt den API-Key serverseitig (Umgebungsvariable ANTHROPIC_API_KEY), der Client sieht ihn nie.
export async function onRequestPost({ request, env }) {
  const body = await request.text();

  const upstream = await fetch('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': env.ANTHROPIC_API_KEY,
      'anthropic-version': '2023-06-01'
    },
    body
  });

  return new Response(upstream.body, {
    status: upstream.status,
    headers: { 'Content-Type': 'application/json' }
  });
}
